import 'package:admin_console/core/app_imports.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class ClientContainer extends StatelessWidget {
  const ClientContainer({
    super.key,
    required this.name,
    required this.id,
    required this.mobileNo,
    required this.onEdit,
    required this.onDelete,
    required this.imageFileName,
  });
  final String name;
  final String id;
  final String mobileNo;
  final String imageFileName;
  final VoidCallback onEdit; 
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('ontap');
        print('Id - $id');
        GoRouter.of(context).go('/clients/$id');
        print('AFter');
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
                  imageFileName.isNotEmpty
                      ? Image.network(
                    'https://photo.sortbe.com/uploads/$imageFileName',
                    height: 40,
                    width: 40,
                    errorBuilder: (context, error, stackTrace) {
                      // Fallback to default SVG if network image fails
                      return SvgPicture.asset(
                        'assets/icons/client.svg',
                        height: 40,
                        width: 40,
                      );
                    },
                  )
                      : SvgPicture.asset(
                    'assets/icons/client.svg',
                    height: 40,
                    width: 40,
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
                          color: Colors.black,
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
