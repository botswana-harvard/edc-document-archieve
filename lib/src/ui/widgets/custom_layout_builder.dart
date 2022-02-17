import 'package:flutter/material.dart';

class CustomLayoutBuilder extends StatelessWidget {
  final Widget child;
  const CustomLayoutBuilder({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double parentHeight = constraints.maxHeight;
        double parentWidth = constraints.maxWidth;
        return child;
      },
    );
  }
}
