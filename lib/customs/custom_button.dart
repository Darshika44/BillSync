import 'package:bill_sync_app/constants/color_constants.dart';
import 'package:flutter/material.dart';

import '../utils/text_utility.dart';

class CustomButton extends StatefulWidget {
  final String text;
  final bool? isBorder;
  final double? width;
  final bool titleLeft;
  final VoidCallback onPressed;
  final Color? buttonColor;
  final Color? textColor;
  final Widget? leftIcon;
  final IconData? rightIcon;
  final Color lefticonColor;
  final Color righticonColor;
  final double opacity;
  final double? fontsize;
  final double height;
  final TextStyle? textStyle;
  final Color? borderColor;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final FontWeight fontWeight;
  final double letterSpacing;
  final TextAlign textAlign;
  final bool? isAttachments;
  final bool isGradientTrue;
  final double? borderRadius;
  final bool isLoader;
  final Widget? iconBetweenText;

  const CustomButton({
    super.key,
    required this.text,
    this.isBorder = false,
    this.width,
    this.titleLeft = false,
    required this.onPressed,
    this.buttonColor = AppColor.primary,
    this.textColor = Colors.white,
    this.leftIcon,
    this.rightIcon,
    this.lefticonColor = Colors.white,
    this.righticonColor = Colors.white,
    this.opacity = 1,
    this.fontsize = 14,
    this.height = 50.0,
    this.textStyle,
    this.borderColor = Colors.black,
    this.padding = const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
    this.fontWeight = FontWeight.w700,
    this.letterSpacing = 0,
    this.textAlign = TextAlign.center,
    this.isAttachments = false,
    this.borderRadius = 10,
    this.isGradientTrue = false,
    this.isLoader = false,
    this.margin = const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
    this.iconBetweenText,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool isPressed = false;
  @override
  Widget build(BuildContext context) {
    // widget.isLoader ? () {} :
    return InkWell(
      onTap: widget.onPressed,
      child: Opacity(
        opacity: widget.opacity,
        child: Container(
          alignment: Alignment.center,
          height: widget.height,
          width: widget.width,
          margin: widget.margin,
          padding: widget.padding,
          decoration: BoxDecoration(
            border: widget.isBorder! ? Border.all(color: widget.borderColor!) : null,
            color: widget.buttonColor,
            // color: widget.buttonColor.withOpacity(isPressed ? 0.8 : 1.0),
            borderRadius: BorderRadius.circular(widget.borderRadius!),
          ),
          child: widget.iconBetweenText ??
              Row(
                mainAxisAlignment: widget.titleLeft ? MainAxisAlignment.start : MainAxisAlignment.center,
                children: [
                  if (widget.leftIcon != null)
                    Padding(
                      padding: const EdgeInsets.only(right: 4.0),
                      child: widget.leftIcon,
                    ),
                  AppText(
                    textAlign: TextAlign.center,
                    text: widget.text,
                    textColor: widget.textColor,
                    fontsize: widget.fontsize!,
                    letterspacing: widget.letterSpacing,
                    fontWeight: widget.fontWeight,
                  ),
                  // appSpaces.spaceForWidth10,
                  if (widget.titleLeft)
                    const SizedBox(
                      width: 10,
                    ),
                  if (widget.rightIcon != null)
                    Icon(
                      widget.rightIcon,
                      color: widget.righticonColor,
                      size: 28,
                      // size: 18,
                    ),
                ],
              ),
        ),
      ),
    );
  }
}
