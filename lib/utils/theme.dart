import 'package:bill_sync_app/constants/color_constants.dart';
import 'package:bill_sync_app/utils/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TAppTheme {
  TAppTheme._();
  static Gradient primaryGradient = const LinearGradient(
    colors: [AppColor.secondary, AppColor.primary],
    stops: [0, 1],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: GoogleFonts.poppins().fontFamily,
    pageTransitionsTheme: const PageTransitionsTheme(builders: {
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      TargetPlatform.android: CupertinoPageTransitionsBuilder(),
    }),
    brightness: Brightness.dark,
    primaryColor: AppColor.primary,
    appBarTheme: const AppBarTheme(backgroundColor: Colors.black, iconTheme: IconThemeData(size: 20)),
    scaffoldBackgroundColor: Colors.black,
    dividerColor: Colors.white,
    iconTheme: const IconThemeData(color: Colors.white),
    // cardColor: AppColor.socialWallCard,
    textTheme: TTextTheme.dartTextTheme,
  );

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: GoogleFonts.poppins().fontFamily,
    pageTransitionsTheme: const PageTransitionsTheme(builders: {
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      TargetPlatform.android: CupertinoPageTransitionsBuilder(),
    }),
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    brightness: Brightness.light,
    primaryColor: AppColor.primary,
    appBarTheme: const AppBarTheme(backgroundColor: Colors.white, iconTheme: IconThemeData(size: 20)),
    scaffoldBackgroundColor: AppColor.scaffoldBackground,
    dividerColor: Colors.black,
    iconTheme: const IconThemeData(color: Colors.black),
    // cardColor: AppColor.lightModeCardColor,
    textTheme: TTextTheme.lightTextTheme,
    colorScheme: ColorScheme.fromSwatch().copyWith(
      primary: AppColor.primary,
      onPrimary: Colors.white,
      surface: AppColor.textGrey,
    ),
  );
}
