import 'package:satyameds/utils/constants/colors.dart';

import 'package:flutter/material.dart';
class TcircularContainer extends StatelessWidget {
  const TcircularContainer({
    super.key,
    this.width = 400,
    this.height = 400,
    this.padding = 0,
    this.radius = 400,
    this.backgroundcolor = TColors.white,
    this.child,
    this.margin,
  });

  final double width;
  final double height;
  final double padding;
  final double radius;
  final Color backgroundcolor;
  final Widget? child;
  final EdgeInsets? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: backgroundcolor,
      ),
      child: child,
    );
  }
}