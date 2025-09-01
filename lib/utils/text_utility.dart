import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppText extends StatelessWidget {
  final String text;
  final Color? textColor;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final int? maxLines;
  final double? fontsize;
  final String? fontfamily;
  final double? wordspacing;
  final TextDecoration? textdecoration;
  final TextBaseline? textBaseline;
  final double? letterspacing;
  final FontWeight? fontWeight;
  final bool? softwrap;
  final double? height;

  const AppText({
    super.key,
    required this.text,
    this.fontfamily,
    this.textBaseline,
    this.softwrap,
    this.fontWeight,
    this.wordspacing,
    this.letterspacing,
    this.textColor,
    this.fontsize,
    this.textAlign,
    this.overflow,
    this.maxLines,
    this.textdecoration,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: textColor,
            fontSize: fontsize,
            decoration: textdecoration,
            fontFamily: fontfamily ?? GoogleFonts.poppins().fontFamily,
            wordSpacing: wordspacing,
            textBaseline: textBaseline,
            letterSpacing: letterspacing ?? 0.5,
            fontWeight: fontWeight ?? FontWeight.w500,
            height: height ?? 0,
          ),
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
      softWrap: softwrap,
    );
  }
}
