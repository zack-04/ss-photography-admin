import 'dart:convert';

import 'package:admin_console/constants.dart';
import 'package:admin_console/features/models/user_list_model.dart';
import 'package:admin_console/widgets/custom_container.dart';
import 'package:admin_console/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class UsersScreen extends StatefulWidget {
  const UsersScreen({
    super.key,
  });

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  UserListResponse? userListResponse;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    usersList();
  }

  Future<void> usersList() async {
    const url = 'https://photo.sortbe.com/User-List';

    try {
      final response = await http.post(
        Uri.parse(url),
        body: {
          'enc': encKey,
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = jsonDecode(response.body);
        print('Response - $responseData');
        setState(() {
          userListResponse = UserListResponse.fromJson(responseData);
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

  void _showAddClientDialog() {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController mobileController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    Future<void> userCreation() async {
      const url = 'https://photo.sortbe.com/User-Creation';

      try {
        final response = await http.post(
          Uri.parse(url),
          body: {
            'name': nameController.text,
            'mobile': mobileController.text,
            'password': passwordController.text,
            'role': 'Admin',
          },
        );

        Map<String, dynamic> responseData = jsonDecode(response.body);
        print('Response - $responseData');
        if (responseData['status'] == 'Success') {
          await usersList();
          GoRouter.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('User Created Successfully'),
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
            'Add User',
            style: TextStyle(
              fontSize: 19,
            ),
          ),
          content: SizedBox(
            //height: 250,
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
                  const SizedBox(height: 30),
                  CustomTextfield(
                    controller: mobileController,
                    text: 'Enter Mobile Number',
                    //autovalidateMode: AutovalidateMode.onUserInteraction,
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
                  const SizedBox(height: 30),
                  CustomTextfield(
                    controller: passwordController,
                    text: 'Enter Password',
                    obscureText: true,
                    maxLines: 1,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your Password';
                      }
                      return null;
                    },
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
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 40,
             // width: 130,
              child: ElevatedButton(
                onPressed: () async {
                  if (!formKey.currentState!.validate()) {
                    return;
                  }
                  await userCreation();

                  // else {
                  //   ScaffoldMessenger.of(context).showSnackBar(
                  //     const SnackBar(
                  //       content: Text('Fill all the details'),
                  //       backgroundColor: Colors.red,
                  //       duration: Duration(seconds: 2),
                  //     ),
                  //   );
                  // }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
                child: const Text(
                  'Create User',
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

  void _editUserDetails() {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController mobileController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text(
            'Edit User',
            style: TextStyle(
              fontSize: 19,
            ),
          ),
          content: SizedBox(
            height: 200,
            width: 450,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 20),
                CustomTextfield(
                  controller: nameController,
                  text: 'Enter Client Name',
                ),
                const SizedBox(height: 30),
                CustomTextfield(
                  controller: mobileController,
                  text: 'Enter Mobile Number',
                ),
                const SizedBox(height: 30),
                CustomTextfield(
                  controller: passwordController,
                  text: 'Enter Password',
                ),
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
                onPressed: () {
                  Navigator.of(context).pop();
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

  void _showDeleteDialog(BuildContext context, String empId) {
    Future<void> deleteUser() async {
      const url = 'https://photo.sortbe.com/User-Status';

      try {
        final response = await http.post(
          Uri.parse(url),
          body: {
            'status': 'Active',
            'emp_id': empId,
            'enc': encKey,
          },
        );

        Map<String, dynamic> responseData = jsonDecode(response.body);
        print('Response - $responseData');
        if (responseData['status'] == 'Success') {
          await usersList();
          GoRouter.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('User Deleted Successfully'),
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
                onPressed: () async {
                  await deleteUser();
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
      body: userListResponse == null
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
                    'Users List',
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
                      'Add User',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  Expanded(
                    child: Container(
                      color: Colors.grey.shade50,
                      child: GridView.builder(
                        itemCount: userListResponse!.data.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          crossAxisSpacing: crossAxisCount == 3 ? 40 : 20.0,
                          mainAxisSpacing: 20.0,
                          childAspectRatio: 1.7,
                        ),
                        itemBuilder: (context, index) {
                          return CustomContainer(
                            name: userListResponse!.data[index].name,
                            id: userListResponse!.data[index].id,
                            mobileNo: userListResponse!.data[index].mobile,
                            onEdit: _editUserDetails,
                            onDelete: () {
                              _showDeleteDialog(
                                context,
                                userListResponse!.data[index].id,
                              );
                            },
                          );
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
