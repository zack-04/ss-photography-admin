import 'dart:ui';

List<Map<String, dynamic>> clients = [
  {'id': '1', 'name': 'Downloads', 'address': '', 'mobile': '9876543210'},
  {'id': '2', 'name': 'Bob Smith', 'address': '', 'mobile': '1212121212'},
  {'id': '3', 'name': 'Charlie Brown', 'address': '', 'mobile': '2345678901'},
  {'id': '4', 'name': 'Diana Prince', 'address': '', 'mobile': '7698765234'},
];

List<Map<String, dynamic>> albums = [
  {'id': '5', 'name': 'Downloads'},
  {'id': '6', 'name': 'Sports'},
  {'id': '7', 'name': 'Music'},
  {'id': '8', 'name': 'Screenshots'},
];

String encKey = '985LP05RMwPA5AKoI9X40TnyHXY1nDZx';

Map<String, Color> statusColor = {
  'Pending': const Color.fromARGB(246, 197, 155, 17),
  'Completed': const Color.fromRGBO(86, 156, 0, 10),
  'Processing': const Color(0xFF2196F3),
};
