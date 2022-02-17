import 'package:flutter/material.dart';
import 'package:recase/recase.dart';

class AnimatedCustomButton extends StatelessWidget {
  final String name;
  final Function(BuildContext context) onTap;

  const AnimatedCustomButton({
    Key? key,
    required this.name,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(context),
      child: Container(
        height: 70,
        width: MediaQuery.of(context).size.width / 1.2,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100.0),
            boxShadow: const [
              BoxShadow(
                color: Color(0x80000000),
                blurRadius: 12.0,
                offset: Offset(0.0, 5.0),
              ),
            ],
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xff33ccff),
                Color(0xffff99cc),
              ],
            )),
        child: Center(
          child: Text(
            name.titleCase,
            style: const TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'RobotoSlab',
            ),
          ),
        ),
      ),
    );
  }
}
