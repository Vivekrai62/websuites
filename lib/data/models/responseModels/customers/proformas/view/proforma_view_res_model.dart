import 'dart:io';

class CustomerPerformaPdfResModel {
  String? status;
  String? contentType;
  String? pdfData; // Base64-encoded PDF
  String? pdfUrl;  // URL to download PDF
  File? file;      // For raw PDF bytes

  CustomerPerformaPdfResModel({
    this.status,
    this.contentType,
    this.pdfData,
    this.pdfUrl,
    this.file,
  });

  CustomerPerformaPdfResModel.fromJson(Map<String, dynamic> json) {
    status = json['status'] as String?;
    contentType = json['content_type'] as String?;
    pdfData = json['pdf_data'] as String?;
    pdfUrl = json['pdf_url'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['content_type'] = contentType;
    data['pdf_data'] = pdfData;
    data['pdf_url'] = pdfUrl;
    return data;
  }
}