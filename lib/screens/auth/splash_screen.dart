// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:bill_sync_app/constants/color_constants.dart';
import 'package:bill_sync_app/screens/home_tab/bottom_bar_screen.dart';
import 'package:bill_sync_app/screens/onboarding/onboarding_screen.dart';
import 'package:bill_sync_app/utils/local_storage.dart';
import 'package:bill_sync_app/utils/text_utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bill_sync_app/extensions/extension.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants/app_constant.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 2), autoSignIn);
    super.initState();
  }

  void autoSignIn() async {
    try {
      final token = await LocalStorage.getToken("access_token");
      AppConst.log('local token ========', token);
      if (token == null) {
        AppConst.setAccessToken(null);
        context.pushReplace(const OnboardingScreen());
      } else {
        AppConst.setAccessToken(token);
        context.pushReplace(const BottomBarScreen());
      }
    } catch (e) {
      context.pushReplace(const OnboardingScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    // Future.delayed(
    //   const Duration(seconds: 3), (){
    //   context.pushReplace(LoginScreen());
    // });
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Center(
          child: AppText(
            text: "billSync",
            fontsize: 50,
            fontWeight: FontWeight.w600,
            fontfamily: GoogleFonts.megrim().fontFamily,
            textColor: AppColor.black,
          ),
        ),
      ),
    );
  }
}