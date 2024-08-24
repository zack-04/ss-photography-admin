import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FilesContainer extends StatelessWidget {
  const FilesContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15),
      child: Container(
        padding: const EdgeInsets.all(20),
        height: 200,
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
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Radio(
                    value: 'value',
                    groupValue: 'groupValue',
                    onChanged: (value) {},
                  ),
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
              const Spacer(),
              Image.asset('icons/albums.png'),
              const Spacer(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Document-final',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 3),
                      Text(
                        '16 Nov 2022',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                  Image.asset(
                    'icons/client.png',
                    height: 40,
                    width: 40,
                    // color: const Color.fromRGBO(229, 138, 0, 1),
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
