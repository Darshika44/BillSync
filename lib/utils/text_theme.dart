import 'package:bill_sync_app/constants/color_constants.dart';
import 'package:flutter/material.dart';

class TTextTheme {
  TTextTheme._();
  static TextTheme lightTextTheme = TextTheme(
    headlineLarge: const TextStyle().copyWith(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black),
    headlineMedium: const TextStyle().copyWith(fontSize: 24, fontWeight: FontWeight.w600, color: Colors.black),
    headlineSmall: const TextStyle().copyWith(fontSize: 18, fontWeight: FontWeight.w400, color: Colors.black),
    titleLarge: const TextStyle().copyWith(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.black),
    titleMedium: const TextStyle().copyWith(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
    titleSmall: const TextStyle().copyWith(fontSize: 16, fontWeight: FontWeight.w400, color: AppColor.textGrey),
    bodyLarge: const TextStyle().copyWith(fontSize: 14, fontWeight: FontWeight.w800, color: Colors.black),
    bodyMedium: const TextStyle().copyWith(fontSize: 14, fontWeight: FontWeight.w400, color: AppColor.textGrey),
    bodySmall: const TextStyle().copyWith(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.grey),
    labelLarge: const TextStyle().copyWith(fontSize: 13, fontWeight: FontWeight.w400, color: AppColor.textGrey),
    labelMedium: const TextStyle().copyWith(fontSize: 12, fontWeight: FontWeight.w700, color: AppColor.textGrey),
    labelSmall: const TextStyle().copyWith(fontSize: 10, fontWeight: FontWeight.normal, color: Colors.grey),
  );

  static TextTheme dartTextTheme = TextTheme(
    headlineLarge: const TextStyle().copyWith(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
    headlineMedium: const TextStyle().copyWith(fontSize: 24, fontWeight: FontWeight.w600, color: Colors.white),
    headlineSmall: const TextStyle().copyWith(fontSize: 18, fontWeight: FontWeight.w400, color: Colors.white),
    titleLarge: const TextStyle().copyWith(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white),
    titleMedium: const TextStyle().copyWith(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),
    titleSmall: const TextStyle().copyWith(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.white),
    bodyLarge: const TextStyle().copyWith(fontSize: 14, fontWeight: FontWeight.w800, color: Colors.white),
    bodyMedium: const TextStyle().copyWith(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.white),
    bodySmall: const TextStyle().copyWith(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white),
    labelLarge: const TextStyle().copyWith(fontSize: 13, fontWeight: FontWeight.w400, color: Colors.white),
    labelMedium: const TextStyle().copyWith(fontSize: 12, fontWeight: FontWeight.w700, color: Colors.white),
    labelSmall: const TextStyle().copyWith(fontSize: 12, fontWeight: FontWeight.normal, color: Colors.grey),
  );
}