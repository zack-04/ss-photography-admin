// ignore_for_file: prefer_const_constructors

import 'package:admin_console/core/app_imports.dart';
import 'package:admin_console/core/constants/c.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({
    super.key,
    required this.onItemTapped,
    required this.selectedIndex,
    
  });
  final Function(int) onItemTapped;
  final int selectedIndex;


  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  int _selectedIndex1 = -1;
  int _hoverIndex = -1;

  bool _isExpanded = false;
  final Duration _animationDuration = Duration(milliseconds: 300);

  void _toggleExpansion() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  List<dynamic> items = [
    {
      'title': "My Account",
      'icon': Icons.person,
    },
    {
      'title': "Settings",
      'icon': Icons.settings,
    },
    {
      'title': "Lock Screen",
      'icon': Icons.lock,
    },
    {
      'title': "Logout",
      'icon': Icons.power_off,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: c.h(context) * 0.05,
                  child: Image.asset("assets/images/logo.png"),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Color.fromARGB(13, 48, 48, 48),
                    ),
                    color: Color(0xFFF3F5F7),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.blue,
                          child: Center(
                            child: Icon(Icons.person),
                          ),
                        ),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "John Smith",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w700),
                            ),
                            Text(
                              "Administrator",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                        trailing: Icon(Icons.filter_list),
                        onTap: _toggleExpansion,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      AnimatedContainer(
                        duration: _animationDuration,
                        height: _isExpanded ? 200.0 : 0.0,
                        child: SingleChildScrollView(
                          child: Column(
                            children: List.generate(
                              4,
                              (index) {
                                return _customListTile(
                                  icon: items[index]['icon'],
                                  title: items[index]['title'],
                                  index: index,
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // _buildInfo(),
                SizedBox(
                  height: 20,
                ),
                _buildDrawerItem(
                  icon: 'assets/icons/search.png',
                  text: 'Search',
                  index: 0,
                ),
                _buildDrawerItem(
                  icon: 'assets/icons/employee.png',
                  text: 'Employee',
                  index: 1,
                ),
                _buildDrawerItem(
                  icon: 'assets/icons/client.png',
                  text: 'Clients',
                  index: 2,
                ),
                // _buildDrawerItem(
                //   icon: 'assets/icons/albums.png',
                //   text: 'Albums',
                //   index: 3,
                // ),
                _buildDrawerItem(
                  icon: 'assets/icons/gallery.png',
                  text: 'Selected Gallery',
                  index: 3,
                ),
                SizedBox(
                  height: 25,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _customListTile({
    required IconData icon,
    required String title,
    required int index,
  }) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex1 = index;
        });
      },
      child: MouseRegion(
        onEnter: (_) => setState(() => _hoverIndex = index),
        onExit: (_) => setState(() => _hoverIndex = -1),
        child: ListTile(
          title: MouseRegion(
            onEnter: (_) => setState(() => _hoverIndex = index),
            onExit: (_) => setState(() => _hoverIndex = -1),
            child: Text(
              title,
              style: TextStyle(
                color: _hoverIndex == index || _selectedIndex1 == index
                    ? Color.fromARGB(255, 40, 104, 241)
                    : Color(0xFF5B6B79),
              ),
            ),
          ),
          leading: MouseRegion(
            onEnter: (_) => setState(() => _hoverIndex = index),
            onExit: (_) => setState(() => _hoverIndex = -1),
            child: Icon(
              icon,
              color: _hoverIndex == index || _selectedIndex1 == index
                  ? Color.fromARGB(255, 40, 104, 241)
                  : Color(0xFF5B6B79),
            ),
          ),
          hoverColor: _selectedIndex1 == index
              ? Color.fromARGB(255, 40, 104, 241)
              : Color(0xFF5B6B79),
        ),
      ),
    );
  }

  Widget _buildDrawerItem(
      {required String icon, required String text, required int index}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        selectedColor: widget.selectedIndex == index
            ? Color.fromARGB(255, 40, 104, 241)
            : Colors.grey[200],
        leading: Image.asset(
          icon,
          height: 20,
          width: 20,
          color: widget.selectedIndex == index
              ? Color.fromARGB(255, 40, 104, 241)
              : Color(0xFF5B6B79),
        ),
        title: Text(
          text,
          style: TextStyle(
            color: widget.selectedIndex == index
                ? Color.fromARGB(255, 40, 104, 241)
                : Color(0xFF5B6B79),
          ),
        ),
        selected: widget.selectedIndex == index,
        selectedTileColor: Colors.blue.withOpacity(0.1),
        hoverColor:
            widget.selectedIndex == index ? Colors.blue[50] : Colors.grey[200],
        onTap: () => widget.onItemTapped(index),
        // tileColor: _selectedIndex == index ? Colors.blue[200] : Colors.grey[300],
      ),
    );
  }
}

 // _buildInfo() => Container(
  //       padding: EdgeInsets.symmetric(horizontal: 10),
  //       decoration: BoxDecoration(
  //         border: Border.all(
  //           color: Color.fromARGB(13, 48, 48, 48),
  //         ),
  //         color: Color(0xFFF3F5F7),
  //         borderRadius: BorderRadius.circular(10),
  //       ),
  //       child: Column(
  //         children: [
  //           Container(
  //             width: c.w(context) * 0.8,
  //             decoration: BoxDecoration(),
  //             child: Padding(
  //               padding:
  //                   const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
  //               child: Row(
  //                 mainAxisAlignment: MainAxisAlignment.start,
  //                 crossAxisAlignment: CrossAxisAlignment.center,
  //                 children: [
  //                   CircleAvatar(
  //                     backgroundColor: Colors.blue,
  //                     child: Center(
  //                       child: Icon(Icons.person),
  //                     ),
  //                   ),
  //                   SizedBox(
  //                     width: 15,
  //                   ),
  //                   Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: const [
  //                       Text(
  //                         "John Smith",
  //                         style: TextStyle(
  //                             fontSize: 16, fontWeight: FontWeight.w700),
  //                       ),
  //                       Text(
  //                         "Administrator",
  //                         style: TextStyle(
  //                             fontSize: 14, fontWeight: FontWeight.w300),
  //                       ),
  //                     ],
  //                   ),
  //                   Spacer(),
  //                   IconButton(
  //                     onPressed: _toggleExpand,
  //                     icon: Icon(
  //                       _isExpanded
  //                           ? Icons.arrow_drop_up
  //                           : Icons.arrow_drop_down,
  //                       color: Colors.black,
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ),
  //           AnimatedCrossFade(
  //             firstChild: Container(height: 0),
  //             secondChild: Container(
  //               // padding: EdgeInsets.all(8),
  //               decoration: BoxDecoration(
  //                   // color: Colors.grey[100],
  //                   // borderRadius: BorderRadius.circular(10),
  //                   ),
  //               child: Column(
  //                 children: List.generate(
  //                   4,
  //                   (index) {
  //                     return _customListTile(
  //                         icon: items[index]['icon'],
  //                         title: items[index]['title']);
  //                   },
  //                 ),
  //               ),
  //             ),
  //             crossFadeState: _isExpanded
  //                 ? CrossFadeState.showSecond
  //                 : CrossFadeState.showFirst,
  //             duration: Duration(milliseconds: 300),
  //           ),
  //         ],
  //       ),
  //     );