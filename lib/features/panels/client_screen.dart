import 'dart:convert';
import 'dart:io';
import 'package:admin_console/constants.dart';
import 'package:admin_console/features/models/client_list_model.dart';
import 'package:admin_console/widgets/client_container.dart';
import 'package:admin_console/widgets/custom_container.dart';
import 'package:admin_console/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class ClientScreen extends StatefulWidget {
  const ClientScreen({
    super.key,
  });

  @override
  State<ClientScreen> createState() => _ClientScreenState();
}

class _ClientScreenState extends State<ClientScreen> {
  ClientListResponse? clientListResponse;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    clientsList();
  }

  Future<void> clientsList() async {
    const url = 'https://photo.sortbe.com/Client-List';

    try {
      final response = await http.post(
        Uri.parse(url),
        body: {
          'enc': encKey,
          'client_name': '',
        },
      );

      Map<String, dynamic> responseData = jsonDecode(response.body);
      print('Response - $responseData');
      if (responseData['status'] == 'Success') {
        setState(() {
          clientListResponse = ClientListResponse.fromJson(responseData);
        });
      } else {
        throw Exception('Failed to load');
      }
    } catch (e) {
      print('Error = $e');
    }
  }

  Future<void> clientEdit(String clientId, String name, String mobile) async {
    const url = 'https://photo.sortbe.com/Client-Edit';

    try {
      final response = await http.post(
        Uri.parse(url),
        body: {
          'name': name,
          'mobile': mobile,
          'enc': encKey,
          'client_id': clientId,
        },
      );

      Map<String, dynamic> responseData = jsonDecode(response.body);
      print('Response - $responseData');
      if (responseData['status'] == 'Success') {
        await clientsList();
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Client Updated Successfully'),
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
  }

  void _showAddClientDialog() {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController addressController = TextEditingController();
    final TextEditingController mobileController = TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    File? capturedImage;
    final ImagePicker picker = ImagePicker();

    Future<void> captureImage() async {
      try {
        final XFile? image = await picker.pickImage(
          source: ImageSource.gallery,
          imageQuality: 100,
        );

        if (image != null) {
          setState(() {
            capturedImage = File(image.path);
          });
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error - $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }

    Future<void> clientCreation() async {
      const url = 'https://photo.sortbe.com/Client-Creation';

      try {
        final response = await http.post(
          Uri.parse(url),
          body: {
            'name': nameController.text,
            'mobile': mobileController.text,
            'enc': encKey,
          },
        );

        Map<String, dynamic> responseData = jsonDecode(response.body);
        print('Response - $responseData');
        if (responseData['status'] == 'Success') {
          await clientsList();
          GoRouter.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Client Created Successfully'),
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
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              shape: ContinuousRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              title: const Text(
                'Add Client',
                style: TextStyle(
                  fontSize: 19,
                ),
              ),
              content: SizedBox(
                //height: 470,
                width: 450,
                child: Form(
                  key: formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 20),
                      CustomTextfield(
                        controller: nameController,
                        text: 'Enter Client Name',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your Name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      CustomTextfield(
                        controller: mobileController,
                        text: 'Enter Mobile Number',
                        inputFormatter: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(10),
                        ],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your mobile number';
                          }
                          if (value.length != 10) {
                            return 'Mobile number must be 10 digits';
                          }
                          final RegExp regex = RegExp(r'^\d{10}$');
                          if (!regex.hasMatch(value)) {
                            return 'Enter valid mobile number';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      CustomTextfield(
                        controller: addressController,
                        maxLines: 3,
                        text: 'Enter Address',
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () async {
                          await captureImage();
                          setState(() {});
                        },
                        child: Container(
                          height: 150,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color(0xFFD4D4D4),
                              width: 1.5,
                            ),
                            borderRadius: BorderRadius.circular(5),
                            image: capturedImage != null
                                ? DecorationImage(
                                    image: FileImage(capturedImage!),
                                    fit: BoxFit.contain,
                                  )
                                : null,
                          ),
                          child: capturedImage == null
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset('assets/icons/gallery.png'),
                                    const SizedBox(height: 15),
                                    Text(
                                      'Capture Photo',
                                      style: GoogleFonts.inter(
                                        fontSize: 15.0,
                                        color: const Color(0xFF929292),
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                )
                              : const SizedBox(),
                        ),
                      )
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
                  //width: 100,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (!formKey.currentState!.validate()) {
                        return;
                      }
                      await clientCreation();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                    child: const Text(
                      'Create Client',
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

  void _editClientDetails(
    String clientId,
    String currentName,
    String currentMobile,
    // String currentAddress
  ) {
    final TextEditingController nameController =
        TextEditingController(text: currentName);
    final TextEditingController mobileController =
        TextEditingController(text: currentMobile);
    final TextEditingController addressController =
        TextEditingController(); // Not functional yet
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text(
            'Edit Client',
            style: TextStyle(
              fontSize: 19,
            ),
          ),
          content: SizedBox(
            height: 420,
            width: 450,
            child: Form(
              key: formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 20),
                  CustomTextfield(
                    controller: nameController,
                    text: 'Enter Client Name',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your Name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  CustomTextfield(
                    controller: mobileController,
                    text: 'Enter Mobile Number',
                    inputFormatter: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(10),
                    ],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your mobile number';
                      }
                      if (value.length != 10) {
                        return 'Mobile number must be 10 digits';
                      }
                      final RegExp regex = RegExp(r'^\d{10}$');
                      if (!regex.hasMatch(value)) {
                        return 'Enter valid mobile number';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  CustomTextfield(
                    controller: addressController,
                    text:
                        'Enter Address', // For now, this is just a placeholder
                    maxLines: 4,
                  ),
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
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    clientEdit(
                        clientId, nameController.text, mobileController.text);
                    Navigator.of(context).pop();
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
                child: const Text(
                  'Update',
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

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Deletion'),
          content: const Text('Are you sure you want to delete this user?'),
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
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
                child: const Text(
                  'Delete',
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
    // Get the screen width
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
      backgroundColor: Colors.grey.shade100,
      body: clientListResponse == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Client List',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 50),
                  ElevatedButton(
                    onPressed: _showAddClientDialog,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: ContinuousRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Add Client',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  Expanded(
                    child: GridView.builder(
                      itemCount: clientListResponse!.data.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        crossAxisSpacing: crossAxisCount == 3 ? 40 : 20.0,
                        mainAxisSpacing: 20.0,
                        childAspectRatio: 1.7,
                      ),
                      itemBuilder: (context, index) {
                        return ClientContainer(
                          name: clientListResponse!.data[index].clientName,
                          id: clientListResponse!.data[index].clientId,
                          mobileNo:
                              clientListResponse!.data[index].mobileNumber,
                          onEdit: () {
                            _editClientDetails(
                              clientListResponse!.data[index].clientId,
                              clientListResponse!.data[index].clientName,
                              clientListResponse!.data[index].mobileNumber,
                            );
                          },
                          onDelete: () {
                            _showDeleteDialog(context);
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
