import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({
    super.key,
    required this.name,
    required this.id,
    required this.mobileNo,
    required this.onEdit,
    required this.onDelete,
  });
  final String name;
  final String id;
  final String mobileNo;
  final VoidCallback onEdit; // Callback for edit
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //GoRouter.of(context).go('/clients/$id');
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 0),
        child: Container(
          constraints: const BoxConstraints(
            maxWidth: 230,
          ),
          padding: const EdgeInsets.all(20),
          height: 200,
          // width: 230,
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
            //mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SvgPicture.asset(
                    'assets/icons/user1.svg',
                    height: 40,
                    width: 40,
                    // color: const Color.fromRGBO(229, 138, 0, 1),
                  ),
                  PopupMenuButton<String>(
                    padding: const EdgeInsets.all(0),
                    tooltip: '',
                    color: Colors.white,
                    constraints: const BoxConstraints(
                      minWidth: 160,
                    ),
                    onSelected: (String value) {
                      // Handle the menu selection
                      switch (value) {
                        case 'Edit':
                          // Handle Edit action
                          onEdit();
                          break;
                        case 'Delete':
                          // Handle Delete action
                          onDelete();
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
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
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
                      Text(
                        mobileNo,
                        style: const TextStyle(
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
