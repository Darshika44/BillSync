import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  final Widget child;
  final double marginTop;
  final double marginbottom;
  final double marginLeft;
  final double margiRight;
  final double paddingTop;
  final double paddingBottom;
  final double paddingLeft;
  final double paddingRight;
  final AlignmentGeometry? alignment;
  final double? width;
  final double? height;
  final Decoration boxDecoration;

  const CustomContainer(this.child,
      {super.key,
      this.margiRight = 0,
      this.marginbottom = 0,
      this.marginLeft = 0,
      this.marginTop = 0,
      this.paddingTop = 0,
      this.width,
      this.height,
      this.paddingLeft = 0,
      this.paddingBottom = 0,
      this.paddingRight = 0,
      this.alignment,
      this.boxDecoration = const BoxDecoration()});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      alignment: alignment,
      decoration: boxDecoration,
      margin: EdgeInsets.only(
        top: marginTop,
        bottom: marginbottom,
        left: marginLeft,
        right: margiRight,
      ),
      padding: EdgeInsets.only(
        top: paddingTop,
        bottom: paddingBottom,
        left: paddingLeft,
        right: paddingRight,
      ),
      child: child,
    );
  }
}
