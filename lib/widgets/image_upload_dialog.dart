import 'package:admin_console/constants.dart';
import 'package:admin_console/core/app_imports.dart';
import 'package:admin_console/features/models/selected_images_model.dart';
import 'package:admin_console/widgets/progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class ImageUploadDialog extends StatefulWidget {
  final List<UploadFile> selectedImages;

  const ImageUploadDialog({super.key, required this.selectedImages});

  @override
  State<ImageUploadDialog> createState() => _ImageUploadDialogState();
}

class _ImageUploadDialogState extends State<ImageUploadDialog> {
  int _uploadedCount = 0;
  bool _isUploading = true;
  List<UploadFile> uploadingImages = [];

  @override
  void initState() {
    super.initState();
    uploadingImages = [...widget.selectedImages];
    _uploadImages();
  }

  Future<void> _uploadImages() async {
    for (var i = 0; i < uploadingImages.length; i++) {
      setState(() {
        uploadingImages[i].status = 'Processing';
      });
      await _uploadImage('imagePath');
      setState(() {
        uploadingImages[i].status = 'Completed';
        _uploadedCount++;
      });
    }

    setState(() {
      _isUploading = false;
    });
    Navigator.pop(context);
    toastification.show(
      context: context,
      type: ToastificationType.success,
      style: ToastificationStyle.flatColored,
      autoCloseDuration: const Duration(seconds: 5),
      title: const Text('Images uploaded successfully'),
      alignment: Alignment.topRight,
      direction: TextDirection.ltr,
      icon: const Icon(Icons.check),
      showIcon: true,
      primaryColor: Colors.green,
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      borderRadius: BorderRadius.circular(12),
      boxShadow: const [
        BoxShadow(
          color: Color(0x07000000),
          blurRadius: 16,
          offset: Offset(0, 16),
          spreadRadius: 0,
        )
      ],
      showProgressBar: true,
      closeButtonShowType: CloseButtonShowType.always,
    );
  }

  Future<void> _uploadImage(String imagePath) async {
    await Future.delayed(
      const Duration(seconds: 5),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: StatefulBuilder(
        builder: (context, setState) {
          return Container(
            width: 550,
            height: 550,
            decoration: BoxDecoration(
              color: const Color(0xFFE5E5E5),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Uploading Files',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      ProgressBar(
                        totalCount: uploadingImages.length,
                        currentCount: _uploadedCount,
                      ),
                    ],
                  ),
                  SizedBox(
                    child: Divider(
                      thickness: 1,
                      color: Colors.grey.shade400,
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: widget.selectedImages.length,
                      itemBuilder: (context, index) {
                        final status = widget.selectedImages[index].status;
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 15,
                              horizontal: 10,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color.fromRGBO(0, 0, 0, 0.1),
                                  offset: Offset(0, 4),
                                  blurRadius: 6,
                                  spreadRadius: -1,
                                ),
                                BoxShadow(
                                  color: Color.fromRGBO(0, 0, 0, 0.06),
                                  offset: Offset(0, 2),
                                  blurRadius: 4,
                                  spreadRadius: -1,
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  constraints: const BoxConstraints(
                                    maxWidth: 350,
                                  ),
                                  child: Text(
                                    widget.selectedImages[index].fileName,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      status,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: statusColor[status],
                                      ),
                                    ),
                                    status == 'Processing'
                                        ? Container(
                                            margin:
                                                const EdgeInsets.only(left: 10),
                                            width: 15.0,
                                            height: 15.0,
                                            child: CircularProgressIndicator(
                                              color: statusColor[status],
                                              strokeWidth: 2,
                                            ),
                                          )
                                        : const SizedBox(),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
