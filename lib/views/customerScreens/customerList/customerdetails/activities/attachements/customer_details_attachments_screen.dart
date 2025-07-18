import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:websuites/utils/appColors/app_colors.dart';
import 'package:websuites/utils/common_responsive_list/common_responsive_list.dart';
import 'package:websuites/views/customerScreens/customerServices/widgets/ServicesCard/services_card.dart';
import 'package:websuites/views/leadScreens/createNewLead/widgets/createNewLeadCard/common_text_field.dart';
import '../../../../../../data/models/requestModels/customer/details/attachments/customer_details_upload_attachments_req_model.dart';
import '../../../../../../data/models/responseModels/customers/list/customer_detail_view/attachements/customer_details_attachemets_res_model.dart';
import '../../../../../../data/models/responseModels/customers/list/customer_detail_view/attachements/upload/customer_details_upload_attachments_res_model.dart';
import '../../../../../../resources/appUrls/app_urls.dart';
import '../../../../../../utils/container_Utils/container_border/container_border_screen.dart';
import '../../../../../../utils/responsive/responsive_utils.dart';
import '../../../../../../viewModels/customerScreens/customer_list/customer_detail_view/attachments/customer_details_attachements_view_model.dart';
import '../../../../../../viewModels/customerScreens/customer_list/customer_detail_view/attachments/upload/customer_details_upload_attachments_view_model.dart';

class CustomerDetailsAttachmentsScreen extends StatefulWidget {
  final String customerId;

  const CustomerDetailsAttachmentsScreen({
    super.key,
    required this.customerId,
  });

  @override
  State<CustomerDetailsAttachmentsScreen> createState() => _CustomerDetailsAttachmentsScreenState();
}

class _CustomerDetailsAttachmentsScreenState extends State<CustomerDetailsAttachmentsScreen> {
  bool _isExpanded = false;
  bool _isDragOver = false;
  List<PlatformFile> _uploadedFiles = [];
  String _selectedFileType = 'Image type';
  String _selectedCategory = 'Image name type';

  final CustomerDetailsAttachmentsViewModel _viewModel = Get.put(CustomerDetailsAttachmentsViewModel());

  // File types for dropdown
  final List<String> _fileTypes = [
    'Screenshot',
    'Attachments',
  ];

  // Categories for dropdown
  final List<String> _categories = [
    'Adhar',
    'Pan',
    'Drug License',
    'Gst',
    'Performa',
    'Screenshot'
  ];

  @override
  void initState() {
    super.initState();
    _loadAttachments();
  }

  void _loadAttachments() {
    _viewModel.customerDetailsAttachments(context, widget.customerId);
  }

  Future<void> _pickFiles() async {
    try {
      print('Starting file selection...');
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.any,
        withData: true, // Ensure bytes are loaded where possible
      );

      if (result != null) {
        print('Files selected: ${result.files.length}');
        for (var file in result.files) {
          print('File: ${file.name}, Size: ${_formatFileSize(file.size)}, '
              'Bytes: ${file.bytes?.length ?? 'null'}, Path: ${file.path ?? 'null'}');
        }
        setState(() {
          _uploadedFiles = result.files.where((file) => file.bytes != null || file.path != null).toList();
          print('Filtered files added to _uploadedFiles: ${_uploadedFiles.length}');
          if (_uploadedFiles.length != result.files.length) {
            print('Warning: Some files were excluded due to missing bytes or path.');
          }
        });
      } else {
        print('No files selected.');
      }
    } catch (e, stackTrace) {
      print('Error picking files: $e');
      print('Stack trace: $stackTrace');
      showDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          title: const Text('Error'),
          content: Text('Failed to pick files: $e'),
          actions: [
            CupertinoDialogAction(
              child: const Text('OK'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      );
    }
  }

  void _removeFile(int index) {
    setState(() {
      _uploadedFiles.removeAt(index);
    });
  }






  Future<void> _uploadFiles() async {
    if (_uploadedFiles.isEmpty) {
      print('No files to upload.');
      return;
    }

    final uploadViewModel = Get.put(CustomerDetailsAttachmentsUploadViewModel());

    setState(() {
      _viewModel.loading.value = true;
    });

    try {
      for (var file in _uploadedFiles) {
        Uint8List? fileBytes;

        // Try to get bytes directly or from file path
        if (file.bytes != null) {
          fileBytes = file.bytes!;
        } else if (file.path != null) {
          try {
            fileBytes = await File(file.path!).readAsBytes();
          } catch (e) {
            throw Exception('Failed to read file from path: ${file.name}, Error: $e');
          }
        } else {
          throw Exception('No bytes or path available for file: ${file.name}');
        }

        final requestModel = CustomerDetailsAttachmentsUploadReqModel(
          file: base64Encode(fileBytes), // Base64 for model, if required
          type: _selectedFileType.toLowerCase(),
          typeName: _selectedCategory,
        );

        print('Uploading file: ${file.name}');
        print('Request Model: type=${requestModel.type}, typeName=${requestModel.typeName}');

        // Call the API to upload the file
        final response = await uploadViewModel.uploadCustomerAttachment(
          context,
          widget.customerId,
          requestModel,
          fileBytes,
          file.name,
        );

        // Print the response data on successful upload
        print('Upload successful for file: ${file.name}');
        print('Response Data: ${response.map((e) => e.toJson()).toList()}');
      }

      showDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          title: const Text('Success'),
          content: Text('${_uploadedFiles.length} file(s) uploaded successfully!'),
          actions: [
            CupertinoDialogAction(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  _uploadedFiles.clear();
                  _selectedFileType = 'Image type';
                  _selectedCategory = 'Image name type';
                });
                _loadAttachments(); // Refresh the attachments list
              },
            ),
          ],
        ),
      );
    } catch (e, stackTrace) {
      print('Upload failed: $e');
      print('Stack trace: $stackTrace');
      showDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          title: const Text('Error'),
          content: Text('Failed to upload files: $e'),
          actions: [
            CupertinoDialogAction(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    } finally {
      setState(() {
        _viewModel.loading.value = false;
      });
    }
  }

  String _getImageUrl(String filename) {
    return AppUrls.customerDetailsAttachments(filename);
  }

  String _getFileType(String fileName) {
    String extension = fileName.split('.').last.toLowerCase();
    if (['png', 'jpg', 'jpeg', 'gif', 'bmp'].contains(extension)) {
      return 'screenshot';
    } else if (['pdf'].contains(extension)) {
      return 'document';
    } else if (['mp4', 'avi', 'mov'].contains(extension)) {
      return 'video';
    }
    return 'file';
  }

  Color _getFileTypeColor(String type) {
    switch (type) {
      case 'screenshot':
        return CupertinoColors.systemBlue;
      case 'document':
        return CupertinoColors.systemGreen;
      case 'video':
        return CupertinoColors.systemRed;
      default:
        return CupertinoColors.systemGrey;
    }
  }

  String _formatFileSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }

  IconData _getFileIcon(String fileType) {
    switch (fileType) {
      case 'screenshot':
        return CupertinoIcons.photo;
      case 'document':
        return CupertinoIcons.doc;
      case 'video':
        return CupertinoIcons.videocam;
      default:
        return CupertinoIcons.doc_text;
    }
  }

  String _formatDate(String dateString) {
    try {
      DateTime dateTime = DateTime.parse(dateString);
      return '${dateTime.day.toString().padLeft(2, '0')} ${_getMonthName(dateTime.month)}, ${dateTime.year} ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')} ${dateTime.hour >= 12 ? 'PM' : 'AM'}';
    } catch (e) {
      return dateString;
    }
  }

  String _getMonthName(int month) {
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return months[month - 1];
  }

  Widget _buildUploadedFileItem(PlatformFile file, int index) {
    String fileType = _getFileType(file.name);
    bool isImage = ['png', 'jpg', 'jpeg', 'gif', 'bmp', 'webp'].contains(
        file.name.split('.').last.toLowerCase());

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade100,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // File info row
          Row(
            children: [
               Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: isImage ? Colors.transparent : AllColors.background_green,
                  shape: BoxShape.circle,
                  border: isImage ? Border.all(color: AllColors.background_green, width: 2) : null,
                ),
                child: isImage && file.bytes != null
                    ? ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.memory(
                    file.bytes!,
                    width: 40,
                    height: 40,
                    fit: BoxFit.cover,
                  ),
                )
                    : Icon(
                  _getFileIcon(fileType),
                  color: AllColors.text__green,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      file.name,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: CupertinoColors.black,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _formatFileSize(file.size),
                      style: const TextStyle(
                        fontSize: 12,
                        color: CupertinoColors.systemGrey,
                      ),
                    ),
                  ],
                ),
              ),
              // Remove button
              GestureDetector(
                onTap: () => _removeFile(index),
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          CommonTextField(
            hintText: 'File Type',
            categories: _fileTypes,
            onChanged: (value) {
              setState(() {
                _selectedFileType = value;
              });
            },
          ),
          const SizedBox(height: 10),
          CommonTextField(
            hintText: 'Category',
            categories: _categories,
            onChanged: (value) {
              setState(() {
                _selectedCategory = value;
              });
            },
          ),

        ],
      ),
    );
  }
  Widget _buildAttachmentItem(CustomerDetailsAttachments attachment) {
    String fileType = _getFileType(attachment.filename ?? '');
    bool isImage = ['png', 'jpg', 'jpeg', 'gif', 'bmp', 'webp'].contains(
        (attachment.filename ?? '').split('.').last.toLowerCase()
    );

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: ContainerBorderComponent(
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: isImage ? Colors.transparent : AllColors.background_green,
                shape: BoxShape.circle,
                border: isImage ? Border.all(color: AllColors.background_green, width: 2) : null,
              ),
              child: isImage
                  ? ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  _getImageUrl(attachment.filename ?? ''),
                  width: 40,
                  height: 40,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                            : null,
                        strokeWidth: 2,
                        color: AllColors.text__green,
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(
                      _getFileIcon(fileType),
                      color: AllColors.text__green,
                      size: 20,
                    );
                  },
                ),
              )
                  : Icon(
                _getFileIcon(fileType),
                color: AllColors.text__green,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    attachment.filename ?? 'Unknown file',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: CupertinoColors.black,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _formatDate(attachment.createdAt ?? ''),
                    style: const TextStyle(
                      fontSize: 12,
                      color: CupertinoColors.systemGrey,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: _getFileTypeColor(fileType).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          attachment.typeName ?? fileType,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: _getFileTypeColor(fileType),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.category,
                        color: AllColors.mediumPurple,
                        size: 18,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'Category: ${attachment.typeName ?? fileType}',
                        style: TextStyle(
                          fontSize: 14,
                          color: AllColors.mediumPurple,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final uploadAttachmentSection =
    Container(
      decoration: BoxDecoration(
        color: CupertinoColors.systemBackground,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Upload Attachment',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: CupertinoColors.black,
            ),
          ),
          const SizedBox(height: 16),
          // Drag & Drop Area
          GestureDetector(
            onTap: _pickFiles,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              child: DottedBorder(
                color: _isDragOver
                    ? CupertinoColors.systemBlue
                    : CupertinoColors.systemGrey3,
                strokeWidth: 2,
                dashPattern: const [8, 4],
                borderType: BorderType.RRect,
                radius: const Radius.circular(12),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(32),
                  decoration: BoxDecoration(
                    color: _isDragOver
                        ? CupertinoColors.systemBlue.withOpacity(0.1)
                        : CupertinoColors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: AllColors.mediumPurple,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          CupertinoIcons.cloud_upload,
                          size: 30,
                          color: AllColors.whiteColor,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Drop files here or click to upload',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: CupertinoColors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Drop file here or click browse through your machine',
                        style: TextStyle(
                          fontSize: 12,
                          color: CupertinoColors.systemGrey,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      CupertinoButton(
                        onPressed: _pickFiles,
                        color: AllColors.mediumPurple,
                        borderRadius: BorderRadius.circular(8),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                        child: const Text(
                          'Browse Files',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // Show uploaded files preview
          if (_uploadedFiles.isNotEmpty) ...[
            const SizedBox(height: 24),
            const Text(
              'Files to Upload',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: CupertinoColors.black,
              ),
            ),
            const SizedBox(height: 16),
            Column(
              children: _uploadedFiles.asMap().entries.map((entry) {
                return _buildUploadedFileItem(entry.value, entry.key);
              }).toList(),
            ),
            const SizedBox(height: 16),
            // Upload button
            SizedBox(
              width: double.infinity,
              child: CupertinoButton(
                onPressed: _uploadFiles,
                color: AllColors.mediumPurple,
                borderRadius: BorderRadius.circular(8),
                padding: const EdgeInsets.symmetric(vertical: 3),
                child:  Text(
                  'Upload',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );

    final attachmentsSection = Obx(() {
      final attachments = _viewModel.customerAttachments;
      final isLoading = _viewModel.loading.value;
      final errorMessage = _viewModel.errorMessage.value;

      return Container(
        decoration: BoxDecoration(
          color: CupertinoColors.systemBackground,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Attachments (${attachments.length})',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: CupertinoColors.black,
                      ),
                    ),
                    Icon(
                      _isExpanded
                          ? CupertinoIcons.chevron_up
                          : CupertinoIcons.chevron_down,
                      color: CupertinoColors.systemGrey,
                    ),
                  ],
                ),
              ),
            ),
            if (_isExpanded)
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                child: isLoading
                    ? const Padding(
                  padding: EdgeInsets.all(20),
                  child: Center(
                    child: CupertinoActivityIndicator(),
                  ),
                )
                    : errorMessage.isNotEmpty
                    ? Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      const Icon(
                        CupertinoIcons.exclamationmark_triangle,
                        color: CupertinoColors.systemRed,
                        size: 24,
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Error loading attachments',
                        style: TextStyle(
                          color: CupertinoColors.systemRed,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        errorMessage,
                        style: const TextStyle(
                          color: CupertinoColors.systemGrey,
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 12),
                      CupertinoButton(
                        onPressed: _loadAttachments,
                        color: AllColors.mediumPurple,
                        borderRadius: BorderRadius.circular(8),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child: const Text(
                          'Retry',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
                    : attachments.isEmpty
                    ? const Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Icon(
                        CupertinoIcons.folder,
                        color: CupertinoColors.systemGrey,
                        size: 24,
                      ),
                      SizedBox(height: 8),
                      Text(
                        'No attachments found',
                        style: TextStyle(
                          color: CupertinoColors.systemGrey,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                )
                    : Column(
                  children: attachments
                      .map((attachment) => _buildAttachmentItem(attachment))
                      .toList(),
                ),
              ),
          ],
        ),
      );
    });

    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: ResponsiveMasonryGridView<Widget>(
        items: [uploadAttachmentSection, attachmentsSection],
        itemBuilder: (context, item, index) => item,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        padding: const EdgeInsets.symmetric(horizontal:0),
        shrinkWrap: true,
      ),
    );
  }
}