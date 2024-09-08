import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class FilesContainer extends StatelessWidget {
  const FilesContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
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
          child: Column(
            children: [
              Container(
                height: 200,
                width: double.infinity,
                padding: const EdgeInsets.only(left: 30, right: 30, top: 30),
                decoration: BoxDecoration(
                  //color: Colors.red,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(10),
                  ),
                  child: Image.asset(
                    'assets/images/demo.jpg',
                    fit: BoxFit.fill,
                    height: 200,
                    width: double.infinity,
                  ),
                ),
              ),
              // const SizedBox(height: 10),
              Container(
                height: 1,
                width: double.infinity,
                color: Colors.grey.shade400,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 20, top: 0),
                child: SizedBox(
                  //color: Colors.amber,
                  height: 50,
                  width: double.infinity,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        constraints: const BoxConstraints(
                          maxWidth: 170,
                        ),
                        child: const Text(
                          'Document-final',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(height: 3),
                      PopupMenuButton<String>(
                        padding: const EdgeInsets.all(0),
                        tooltip: '',
                        color: Colors.white,
                        constraints: const BoxConstraints(
                          minWidth: 130,
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
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          left: 5,
          top: 5,
          child: Radio(
            activeColor: Colors.red,
            value: 'value',
            groupValue: 'groupValue',
            onChanged: (value) {},
          ),
        ),
      ],
    );
  }
}
