import 'dart:convert';

import 'package:admin_console/constants.dart';
import 'package:admin_console/features/models/album_list_model.dart';
import 'package:admin_console/widgets/album_container.dart';
import 'package:admin_console/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;

class AlbumsScreen extends StatefulWidget {
  const AlbumsScreen({super.key, required this.clientId});
  final String clientId;

  @override
  State<AlbumsScreen> createState() => _AlbumsScreenState();
}

class _AlbumsScreenState extends State<AlbumsScreen> {
  AlbumListResponse? albumListResponse;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    albumsList();
  }

  Future<void> albumsList() async {
    const url = 'https://photo.sortbe.com/Album-List';

    try {
      final response = await http.post(
        Uri.parse(url),
        body: {
          'client_id': widget.clientId,
          'enc': encKey,
        },
      );

      Map<String, dynamic> responseData = jsonDecode(response.body);
      print('Response - $responseData');
      if (responseData['status'] == 'Success') {
        setState(() {
          albumListResponse = AlbumListResponse.fromJson(responseData);
        });
      } else {
        throw Exception('Failed to load');
      }
    } catch (e) {
      print('Error = $e');
    }
    // finally {
    //   if (mounted) {
    //     setState(() {
    //       isLoading = false;
    //     });
    //   }
    // }
  }

  void _showAddAlbumDialog() {
    final TextEditingController nameController = TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    Future<void> albumCreation() async {
      const url = 'https://photo.sortbe.com/Album-Creation';

      try {
        final response = await http.post(
          Uri.parse(url),
          body: {
            'client_id': widget.clientId,
            'album_name': nameController.text,
            'user_id': '3',
            'enc': encKey,
          },
        );

        Map<String, dynamic> responseData = jsonDecode(response.body);
        print('Response - $responseData');
        if (responseData['status'] == 'Success') {
          await albumsList();
          GoRouter.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Album Created Successfully'),
              backgroundColor: Colors.green,
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('${responseData['remarks']}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      } catch (e) {
        print('Error = $e');
      }
      // finally {
      //   if (mounted) {
      //     setState(() {
      //       isLoading = false;
      //     });
      //   }
      // }
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text(
            'Create Album',
            style: TextStyle(
              fontSize: 19,
            ),
          ),
          content: SizedBox(
            child: Form(
              key: formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 20),
                  CustomTextfield(
                    controller: nameController,
                    text: 'Enter Album Name',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Album Name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 30),
                ],
              ),
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
              width: 100,
              child: ElevatedButton(
                onPressed: () async {
                  if (!formKey.currentState!.validate()) {
                    return;
                  }
                  await albumCreation();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
                child: const Text(
                  'Add',
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

  void _showEditAlbumDialog() {
    final TextEditingController nameController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text(
            'Edit Album',
            style: TextStyle(
              fontSize: 19,
            ),
          ),
          content: SizedBox(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 20),
                CustomTextfield(
                  controller: nameController,
                  text: 'Enter Album Name',
                ),
                const SizedBox(height: 30),
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
              width: 100,
              child: ElevatedButton(
                onPressed: () async {
                  // if (!formKey.currentState!.validate()) {
                  //   return;
                  // }
                  // await albumCreation();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
                child: const Text(
                  'Edit',
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

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double width = screenWidth - 250;
    print('Width = $width');
    int crossAxisCount = 4;
    if (width < 1135) {
      setState(() {
        crossAxisCount = 3;
      });
    }
    if (width < 908) {
      setState(() {
        crossAxisCount = 2;
      });
    }
    return Scaffold(
      body: albumListResponse == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
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
                        'Album',
                        style: TextStyle(fontSize: 17),
                      ),
                      const SizedBox(width: 10),
                      GestureDetector(
                        onTap: _showAddAlbumDialog,
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
                  child: albumListResponse!.data.isEmpty
                      ? const Center(
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 60),
                            child: Text(
                              'No Albums Found...',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: GridView.builder(
                            itemCount: albumListResponse!.data.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: crossAxisCount,
                              crossAxisSpacing: 20.0,
                              mainAxisSpacing: 20.0,
                              childAspectRatio: 3,
                            ),
                            itemBuilder: (context, index) {
                              return AlbumContainer(
                                name: albumListResponse!.data[index].albumName,
                                albumId: albumListResponse!.data[index].albumId,
                                clientId: widget.clientId,
                                onEdit: _showEditAlbumDialog,
                              );
                            },
                          ),
                        ),
                ),
              ],
            ),
    );
  }
}
