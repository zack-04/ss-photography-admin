import 'dart:typed_data';

class UploadFile {
  final Uint8List selectedImage;
  final String fileName;
  String status;

  UploadFile({
    required this.selectedImage,
    required this.fileName,
    required this.status,
  });
}
