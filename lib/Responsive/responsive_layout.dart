import 'package:flutter/material.dart';

class ResponsiveLayout extends StatefulWidget {
  final Widget mobile_responsive;
  final Widget desktop_responsive;
  const ResponsiveLayout({super.key,required this.mobile_responsive,required this.desktop_responsive});

  @override
  State<ResponsiveLayout> createState() => _ResponsiveLayoutState();
}

class _ResponsiveLayoutState extends State<ResponsiveLayout> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if(constraints.maxWidth<600){
        return widget.mobile_responsive;
      }else{
        return widget.desktop_responsive;
      }
    },);
  }
}