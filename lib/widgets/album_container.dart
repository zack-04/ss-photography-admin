import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AlbumContainer extends StatelessWidget {
  const AlbumContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15),
      child: Container(
        padding: const EdgeInsets.all(20),
        height: 90,
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
                'icons/folder.svg',
                height: 40,
                width: 40,
                color: const Color.fromRGBO(229, 138, 0, 1),
              ),
              const SizedBox(width: 10),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Album Name',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 3),
                  Text(
                    '20 files',
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
                constraints: const BoxConstraints(
                  minWidth: 160,
                ),
                onSelected: (String value) {
                  // Handle the menu selection
                  switch (value) {
                    case 'Edit':
                      // Handle Edit action
                      break;
                    case 'Delete':
                      // Handle Delete action
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
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
