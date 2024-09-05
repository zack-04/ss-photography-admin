// import 'package:admin_console/core/app_imports.dart';
// import 'package:admin_console/core/constants/c.dart';
// import 'package:admin_console/features/panels/albums_screen.dart';
// import 'package:admin_console/features/panels/client_screen.dart';
// import 'package:admin_console/features/panels/files_screen.dart';
// import 'package:admin_console/features/panels/search_screen.dart';
// import 'package:admin_console/my_drawer.dart';
// import 'package:flutter/material.dart';

// class DesktopScreen extends StatefulWidget {
//   const DesktopScreen({super.key});

//   @override
//   State<DesktopScreen> createState() => _DesktopScreenState();
// }

// class _DesktopScreenState extends State<DesktopScreen> {
//   int _selectedIndex = 0;
//   int? _selectedClientId;

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//       if (index == 2) {
//         // Reset selected client when navigating to ClientScreen
//         _selectedClientId = null;
//       }
//     });
//   }

//   void _onClientSelected(int clientId) {
//     setState(() {
//       _selectedClientId = clientId;
//       _selectedIndex = 2; // Switch to ClientScreen if needed
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     Widget mainContent;
//     if (_selectedIndex == 2 && _selectedClientId != null) {
//       // Show AlbumsScreen if a client is selected
//       mainContent = FilesScreen(clientId: _selectedClientId);
//     } else {
//       // Show the appropriate screen based on _selectedIndex
//       mainContent = IndexedStack(
//         index: _selectedIndex,
//         children: [
//           const SearchScreen(),
//           const Center(child: Text('Employee Screen')),
//           ClientScreen(onClientSelected: _onClientSelected),
//           // Placeholder, no AlbumsScreen if clientId is null
//           const Center(child: Text('Selected gallery Screen')),
//         ],
//       );
//     }

//     return Scaffold(
//       body: Row(
//         children: [
//           MyDrawer(onItemTapped: _onItemTapped, selectedIndex: _selectedIndex),
//           SizedBox(
//             child: VerticalDivider(
//               color: Colors.grey.shade300,
//               thickness: 1,
//               width: 2,
//             ),
//           ),
//           Expanded(child: mainContent),
//         ],
//       ),
//     );
//   }
// }
