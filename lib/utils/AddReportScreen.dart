import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:file_picker/file_picker.dart';
import 'package:websuites/utils/appColors/app_colors.dart';
import 'package:websuites/utils/button/CustomButton.dart';

class AddReportScreen extends StatefulWidget {
  const AddReportScreen({super.key});

  @override
  _AddReportScreenState createState() => _AddReportScreenState();
}

class _AddReportScreenState extends State<AddReportScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _ccController = TextEditingController();
  DateTime? _startDate;
  DateTime? _endDate;
  String? _fileName;

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        if (isStartDate) {
          _startDate = picked;
        } else {
          _endDate = picked;
        }
      });
    }
  }

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        _fileName = result.files.single.name;
      });
    } else {
      setState(() {
        _fileName = null;
      });
    }
  }

  String? _validateAttachment(String? value) {
    if (_fileName == null || _fileName!.isEmpty) {
      return 'Attachment is required';
    }
    return null;
  }

  Widget _buildLabel(String text) {
    return Row(
      children: [
        Text(
          text,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
        ),
        const Text(
          ' *',
          style: TextStyle(
              color: Colors.red, fontWeight: FontWeight.bold, fontSize: 12),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("hello"),
      ),
      body: Center(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Card(
                color: Colors.white,
                elevation: 4.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Form(
                  key: _formKey,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300, width: 1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.all(6.0),
                    width: MediaQuery.of(context).size.width * 0.75,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.0),
                          child: Center(
                            child: Text(
                              'Add Report',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        _buildLabel('Title'),
                        TextFormField(
                          controller: _titleController,
                          style: const TextStyle(fontSize: 12),
                          decoration: const InputDecoration(
                            hintText: 'Enter Title...',
                            hintStyle: TextStyle(fontSize: 10),
                            border: OutlineInputBorder(),
                            isDense: true,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Title is required';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 6.0),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildLabel('Start Date'),
                                  GestureDetector(
                                    onTap: () => _selectDate(context, true),
                                    child: AbsorbPointer(
                                      child: TextFormField(
                                        style: const TextStyle(fontSize: 12),
                                        decoration: InputDecoration(
                                          hintText: _startDate == null
                                              ? 'yyyy-MM-dd'
                                              : DateFormat('yyyy-MM-dd')
                                                  .format(_startDate!),
                                          hintStyle:
                                              const TextStyle(fontSize: 10),
                                          border: const OutlineInputBorder(),
                                          isDense: true,
                                        ),
                                        validator: (value) {
                                          if (_startDate == null) {
                                            return 'Start date is required';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 12.0),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildLabel('End Date'),
                                  GestureDetector(
                                    onTap: () => _selectDate(context, false),
                                    child: AbsorbPointer(
                                      child: TextFormField(
                                        style: const TextStyle(fontSize: 12),
                                        decoration: InputDecoration(
                                          hintText: _endDate == null
                                              ? 'yyyy-MM-dd'
                                              : DateFormat('yyyy-MM-dd')
                                                  .format(_endDate!),
                                          hintStyle:
                                              const TextStyle(fontSize: 10),
                                          border: const OutlineInputBorder(),
                                          isDense: true,
                                        ),
                                        validator: (value) {
                                          if (_endDate == null) {
                                            return 'End date is required';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6.0),
                        _buildLabel('Description'),
                        TextFormField(
                          controller: _descriptionController,
                          maxLines: 3,
                          style: const TextStyle(fontSize: 12),
                          decoration: const InputDecoration(
                            hintText: 'Enter Description...',
                            hintStyle: TextStyle(fontSize: 10),
                            border: OutlineInputBorder(),
                            isDense: true,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Description is required';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 6.0),
                        const Text(
                          'To:',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 12),
                        ),
                        const SizedBox(height: 4.0),
                        Row(
                          children: [
                            const Text(
                              'CC:',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 12),
                            ),
                            const SizedBox(width: 6.0),
                            Container(
                              padding: const EdgeInsets.all(6.0),
                              decoration: BoxDecoration(
                                color: Colors.purple.shade100,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: const Text(
                                'dev.whsuites@gmail.com',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 10),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6.0),
                        _buildLabel('Add more CC'),
                        TextFormField(
                          controller: _ccController,
                          style: const TextStyle(fontSize: 12),
                          decoration: const InputDecoration(
                            hintText: 'Multiple mail IDs',
                            hintStyle: TextStyle(fontSize: 10),
                            border: OutlineInputBorder(),
                            isDense: true,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'CC is required';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 6.0),
                        _buildLabel('Attachment'),
                        Row(
                          children: [
                            CustomButton(
                                height: Get.height / 34,
                                width: 100,
                                backgroundColor: AllColors.mediumPurple,
                                onPressed: _pickFile,
                                child: Text(
                                  'Choose files',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12),
                                )),
                            const SizedBox(width: 10),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 6.0),
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.grey.shade300),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Text(
                                  _fileName ?? 'No file chosen',
                                  style: const TextStyle(
                                      fontSize: 12, color: Colors.black),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12.0),
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState?.validate() ?? false) {
                                // Proceed with submission logic
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24.0, vertical: 10.0),
                            ),
                            child:
                                Text('Submit', style: TextStyle(fontSize: 12)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: -10,
              right: -10,
              child: Container(
                height: 28,
                padding: const EdgeInsets.all(0.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300,
                      blurRadius: 6,
                    ),
                  ],
                ),
                child: IconButton(
                  icon: const Icon(Icons.close, color: Colors.black, size: 14),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
