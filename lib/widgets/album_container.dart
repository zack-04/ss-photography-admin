import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;

import '../constants.dart';



class AlbumContainer extends StatelessWidget {
  const AlbumContainer({
    super.key,
    required this.name,
    required this.albumId,
    required this.clientId,
    required this.onEdit,
  });

  final String name;
  final String albumId;
  final String clientId;
  final VoidCallback onEdit;


  Future<void> generateLink(
      BuildContext context, String enc, String albumId) async {
    final url = Uri.parse('https://photo.sortbe.com/Link-Trigger');

    try {
      final response = await http.post(
        url,
        body: {
          'enc': encKey,
          'album_id': albumId, // Pass the albumId from the backend
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final otp = data['otp'].toString(); // Get the OTP from backend response

        print('Generated OTP: $otp for albumId: $albumId');

        // Pass the OTP and albumId to OTP verification screen
        GoRouter.of(context).go(
          '/otp_verification',
          extra: {
            'enc': enc,
            'albumId': albumId,
            'otp': otp, // Pass the correct OTP
          },
        );
      } else {
        print('Failed to generate link. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        GoRouter.of(context).go('/clients/$clientId/albums/$albumId');
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 0),
        child: Container(
          padding: const EdgeInsets.all(20),
          height: 70,
          width: 250,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: const Color(0xFFe7eaee),
              width: 1,
            ),
            boxShadow: const [
              BoxShadow(
                color: Color.fromRGBO(27, 46, 94, 0.08),
                offset: Offset(0, 8),
                blurRadius: 24,
              ),
            ],
          ),
          child: Center(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  'assets/icons/folder.svg',
                  height: 40,
                  width: 40,
                  color: const Color.fromRGBO(229, 138, 0, 1),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 3),
                    const Text(
                      'All files',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                PopupMenuButton<String>(
                  padding: const EdgeInsets.all(0),
                  tooltip: '',
                  color: Colors.white,
                  constraints: const BoxConstraints(
                    minWidth: 160,
                  ),
                  onSelected: (String value) {
                    switch (value) {
                      case 'Edit':
                        onEdit();
                        break;
                      case 'Delete':
                        // Handle Delete action
                        break;
                      case 'GenLink':
                        generateLink(context, encKey,
                            albumId); // Generates link and navigates to OTP page
                        break;
                    }
                  },
                  icon: const Icon(
                    Icons.more_vert,
                    size: 20,
                    color: Colors.grey,
                  ),
                  itemBuilder: (BuildContext context) => [
                    const PopupMenuItem<String>(
                      value: 'Edit',
                      child: Text('Edit'),
                    ),
                    const PopupMenuItem<String>(
                      value: 'Delete',
                      child: Text('Delete'),
                    ),
                    const PopupMenuItem<String>(
                      value: 'GenLink',
                      child: Text('Generate Link'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
