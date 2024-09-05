import 'dart:io';
import 'dart:typed_data';

import 'package:admin_console/core/app_imports.dart';
import 'package:admin_console/widgets/files_container.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

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
  // File? _pickedFile;
  Uint8List? webImage = Uint8List(8);

  List<Uint8List> selectedImages = [];

  Future<void> _pickImages() async {
    final ImagePicker picker = ImagePicker();
    final List<XFile>? images = await picker.pickMultiImage();
    print('Images = $images');

    if (images != null) {
      for (var image in images) {
        var bytes = await image.readAsBytes();
        double sizeInMB = bytes.lengthInBytes / (1024 * 1024);

        // Print the size in MB
        print('Image Size: ${sizeInMB.toStringAsFixed(2)} MB');
        setState(() {
          selectedImages.add(bytes);
        });
      }
    }
  }

  void _showAddFileDialog() {
    print('Inside');

    setState(() {
      selectedImages = [];
    });
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
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
              content: SizedBox(
                height: 420,
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
                        await _pickImages();
                        setState(() {});
                      },
                      child: DottedBorder(
                        color: Colors.grey,
                        radius: const Radius.circular(12),
                        dashPattern: const [8, 4],
                        child: Container(
                          height: 300,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            image: selectedImages.isNotEmpty
                                ? DecorationImage(
                                    image: MemoryImage(selectedImages.last),
                                    fit: BoxFit.cover,
                                  )
                                : null,
                          ),
                          child: selectedImages.isEmpty
                              ? Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        'assets/icons/arrow.svg',
                                        width: 40,
                                        height: 70,
                                        color: Colors.grey.shade300,
                                      ),
                                      const SizedBox(height: 20),
                                      const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Drop here or ',
                                            style: TextStyle(fontSize: 18),
                                          ),
                                          Text(
                                            'browse',
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.blue,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                )
                              : const SizedBox(),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
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
                      // Add file upload or processing logic here
                      Navigator.of(context).pop();
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
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          double screenWidth = MediaQuery.of(context).size.width;
          double width = screenWidth - 250;
          int crossAxisCount = 4;
          if (width < 1135) {
            crossAxisCount = 3;
          }
          if (width < 908) {
            crossAxisCount = 2;
          }
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
                  child: GridView.builder(
                    itemCount: 4,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 20.0,
                      mainAxisSpacing: 20.0,
                      childAspectRatio: 1.5,
                    ),
                    itemBuilder: (context, index) {
                      return const FilesContainer();
                    },
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
