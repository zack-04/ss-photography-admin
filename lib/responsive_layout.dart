import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget mobileScaffold;
  final Widget tabScaffold;
  final Widget desktopScaffold;


  const ResponsiveLayout({super.key , required this.desktopScaffold , required this.mobileScaffold , required this.tabScaffold});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context , Constraints) { 
      if(Constraints.maxWidth < 500){
        return mobileScaffold;
      }
      else if(Constraints.maxWidth < 1100){
        return tabScaffold;
      }
      else{
        return desktopScaffold;
      }
    }
    );
  }
}