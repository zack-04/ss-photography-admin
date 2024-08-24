import 'package:admin_console/core/constants/app_themes.dart';
import 'package:admin_console/features/home/desktop_screen.dart';
import 'package:admin_console/features/home/mobile_screen.dart';
import 'package:admin_console/features/home/tab_screen.dart';
import 'package:admin_console/responsive_layout.dart';
import 'package:admin_console/route/custom_navigator.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Admin Console',
      initialRoute: '/',
      onGenerateRoute: CustomNavigator.controller,
      themeMode: ThemeMode.light,
      theme: AppThemes.light,
      home: const ResponsiveLayout(
        desktopScaffold: DesktopScreen(),
        mobileScaffold: MobileScreen(),
        tabScaffold: TabScreen(),
      ),
    );
  }
}
