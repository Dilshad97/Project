import 'package:flutter/cupertino.dart';

class CustomContainer extends StatelessWidget {
  final Widget child;
  final double hight;
  final double width;
  final Color color;

  CustomContainer({
    this.child,
    this.hight,
    this.width,
    this.color,
  }); //you can pass key to

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: hight,
      transform: Matrix4.translationValues(0.0, 30, 0.0),
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(20)),
      child: child,
    );
  }
}
