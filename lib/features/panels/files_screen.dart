import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';

import 'package:admin_console/features/models/selected_images_model.dart';
import 'package:admin_console/widgets/image_upload_dialog.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image/image.dart' as img;
import 'package:image_compression_flutter/image_compression_flutter.dart';
import 'package:image_picker/image_picker.dart';

import 'package:admin_console/core/app_imports.dart';
import 'package:admin_console/widgets/files_container.dart';
import 'package:image_watermark/image_watermark.dart';
import 'package:path_provider/path_provider.dart';

class FilesScreen extends StatefulWidget {
  const FilesScreen({
    super.key,
    required this.clientId,
    required this.albumsId,
  });
  final String clientId;
  final String albumsId;

  @override
  State<FilesScreen> createState() => _FilesScreenState();
}

class _FilesScreenState extends State<FilesScreen> {
  List<UploadFile> selectedImages = [];

  Future<void> _pickImages() async {
    final ImagePicker picker = ImagePicker();
    final List<XFile> images = await picker.pickMultiImage();

    print('Images = ${images.length}');

    List<UploadFile> uploadedFiles = [];
    for (var file in images) {
      String status = 'Pending';
      String fileName = file.name;
      Uint8List image = await compressAndAddWatermark(file);

      uploadedFiles.add(
        UploadFile(
          selectedImage: image,
          fileName: fileName,
          status: status,
        ),
      );
    }
    setState(() {
      selectedImages = [...selectedImages, ...uploadedFiles];
    });
  }

  Future<Uint8List> compressAndAddWatermark(XFile file) async {
    final imageBytes = await file.readAsBytes();
    final compressedBytes = await compressImage(imageBytes, 500, 400);
    final watermarkBytes = await _loadWatermark();

    final watermarkedBytes =
        await addWatermark(compressedBytes, watermarkBytes);
    final watermarkCompressedBytes =
        await compressImage(watermarkedBytes, 500, 400);

    print('compressed size = ${_formatBytes(compressedBytes.length)}');
    print('watermarked Size = ${_formatBytes(watermarkedBytes.length)}');
    print(
        'watermarked compressed Size = ${_formatBytes(watermarkCompressedBytes.length)}');

    return watermarkCompressedBytes;
  }

  Future<Uint8List> addWatermark(
      Uint8List imageBytes, Uint8List watermarkBytes) async {
    final image = img.decodeImage(imageBytes);

    final watermarkedImgBytes = await ImageWatermark.addImageWatermark(
      originalImageBytes: imageBytes,
      waterkmarkImageBytes: watermarkBytes,
      imgHeight: 50,
      imgWidth: 50,
      dstY: image!.height - 60,
      dstX: image.width - 60,
    );
    return watermarkedImgBytes;
  }

  Future<Uint8List> _loadWatermark() async {
    // Load watermark image bytes
    final ByteData data = await rootBundle.load('assets/images/logo.jpeg');
    return data.buffer.asUint8List();
  }

  Future<String> _saveImage(Uint8List imageBytes) async {
    final directory = await getApplicationDocumentsDirectory();
    final filePath =
        '${directory.path}/compressed_image_${DateTime.now().millisecondsSinceEpoch}.jpg';
    final file = File(filePath);

    await file.writeAsBytes(imageBytes);

    return filePath;
  }

  // Function to compress an image
  Future<Uint8List> compressImage(
      Uint8List imageBytes, int width, int height) async {
    // Decode the image
    img.Image? image = img.decodeImage(imageBytes);
    if (image == null) {
      throw Exception('Failed to decode image');
    }
    // Resize the image
    img.Image resizedImage =
        img.copyResize(image, width: width, height: height);

    // Encode the image
    return Uint8List.fromList(img.encodeJpg(resizedImage, quality: 60));
  }

  String _formatBytes(int bytes, [int decimals = 2]) {
    if (bytes <= 0) return "0 B";
    const List<String> sizes = ["B", "KB", "MB", "GB", "TB"];
    final int i = (log(bytes) / log(1024)).floor();
    final double size = bytes / pow(1024, i);
    return "${size.toStringAsFixed(decimals)} ${sizes[i]}";
  }

  void _showAddFileDialog() {
    print('Inside');

    setState(() {
      selectedImages = [];
    });
    showDialog(
      context: context,
      builder: (context) {
        bool isLoading = false;
        return AlertDialog(
          shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Upload Files',
                style: TextStyle(
                  fontSize: 19,
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.cancel),
              ),
            ],
          ),
          content: StatefulBuilder(
            builder: (context, setState) {
              //print('Loading = $isLoading');
              return Stack(
                children: [
                  SizedBox(
                    //height: 420,
                    width: 470,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: Divider(
                            color: Colors.grey.shade300,
                            thickness: 1,
                          ),
                        ),
                        const SizedBox(height: 20),
                        GestureDetector(
                          onTap: () async {
                            setState(() {
                              isLoading = true;
                            });
                            await _pickImages();
                            setState(() {
                              isLoading = false;
                            });
                          },
                          child: DottedBorder(
                            color: Colors.grey,
                            radius: const Radius.circular(12),
                            dashPattern: const [8, 4],
                            child: SizedBox(
                              height: 180,
                              width: double.infinity,
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      'assets/icons/arrow.svg',
                                      width: 40,
                                      height: 50,
                                      color: Colors.grey.shade300,
                                    ),
                                    const SizedBox(height: 20),
                                    const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Drop here or ',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        Text(
                                          'browse',
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.blue,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        selectedImages.isNotEmpty
                            ? const Padding(
                                padding: EdgeInsets.only(left: 20),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Selected Files',
                                    style: TextStyle(
                                      fontSize: 17,
                                    ),
                                  ),
                                ),
                              )
                            : const Padding(
                                padding: EdgeInsets.only(top: 10),
                                child: Center(
                                  child: Text(
                                    'No files selected',
                                    style: TextStyle(
                                      fontSize: 17,
                                    ),
                                  ),
                                ),
                              ),
                        const SizedBox(height: 10),
                        Expanded(
                          child: ListView.builder(
                            itemCount: selectedImages.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                leading: const Icon(Icons.image),
                                title: Text(
                                  selectedImages[index].fileName,
                                  style: const TextStyle(
                                    fontSize: 15,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                                trailing: IconButton(
                                  icon: const Icon(
                                    Icons.close,
                                    size: 20,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      selectedImages = List.from(selectedImages)
                                        ..removeAt(index);
                                    });
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: isLoading,
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                      child: Container(
                        color: Colors.black.withOpacity(0.5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: Image.asset(
                                'assets/images/loading2.png',
                                height: 70,
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              'Loading...',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white70,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          actions: [
            SizedBox(
              height: 40,
              width: 100,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey,
                ),
                child: const Text(
                  'Cancel',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 40,
              width: 120,
              child: ElevatedButton(
                onPressed: () {
                  if (!isLoading) {
                    print('Ontap');
                    Navigator.of(context).pop();
                    showImageUploadDialog(context, selectedImages);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
                child: const Text(
                  'Add File',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void showImageUploadDialog(
    BuildContext context,
    List<UploadFile> selectedImages,
  ) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return ImageUploadDialog(selectedImages: selectedImages);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          // double screenWidth = MediaQuery.of(context).size.width;
          // double width = screenWidth - 250;
          // int crossAxisCount = 4;
          // if (width < 1135) {
          //   crossAxisCount = 3;
          // }
          // if (width < 908) {
          //   crossAxisCount = 2;
          // }
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Row(
                  children: [
                    const Text(
                      'File',
                      style: TextStyle(fontSize: 17),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: _showAddFileDialog,
                      child: Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.blue,
                        ),
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: SingleChildScrollView(
                    child: Wrap(
                      spacing: 20.0, // Horizontal space between items
                      runSpacing: 20.0, // Vertical space between items
                      children: List.generate(4, (index) {
                        return const SizedBox(
                          width: 280,
                          child: FilesContainer(),
                        );
                      }),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
