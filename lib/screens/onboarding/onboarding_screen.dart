import 'dart:async';

import 'package:bill_sync_app/constants/color_constants.dart';
import 'package:bill_sync_app/constants/image_constants.dart';
import 'package:bill_sync_app/customs/custom_button.dart';
import 'package:bill_sync_app/extensions/extension.dart';
import 'package:bill_sync_app/routes/route_path.dart';
import 'package:bill_sync_app/utils/app_spaces.dart';
import 'package:bill_sync_app/utils/text_utility.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int currentIndex = 0;

  final List<Map<String, String>> onboardingData = [
    {
      "image": ImageConstant.onboard1,
      // "image": SvgConstants.add1Svg,
      "headingText": "Say Goodbye to\nPaper Invoices",
      "text": "Create professional digital invoices in seconds. Save time, reduce errors, and go completely paperless with our easy-to-use invoicing system.",
    },
    {
      "image": ImageConstant.onboard2,
      // "image": SvgConstants.add2Svg,
      "headingText": "Smart Inventory\nManagement",
      "text": "Track and manage your jewellery stock with ease. Stay updated on inventory levels and make informed decisions to run your business smoothly.",
    },
    {
      "image": ImageConstant.onboard3,
      // "image": SvgConstants.add3Svg,
      "headingText": "Built for Jewellery\nManufacturers",
      "text": "Specially designed for gold jewellery businesses. From production to billing, manage everything in one place—secure, simple, and efficient.",
    },
  ];

  Timer? _autoScrollTimer;

  @override
  void initState() {
    // _startAutoScroll();
    super.initState();
  }

  // void _resetAndStartTimer() {
  //   _autoScrollTimer?.cancel();
  //   _startAutoScroll();
  // }

  // void _startAutoScroll() {
  //   _autoScrollTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
  //     if (currentIndex < onboardingData.length - 1) {
  //       _pageController.nextPage(
  //         duration: const Duration(milliseconds: 300),
  //         curve: Curves.easeInOut,
  //       );
  //     } else {
  //       _pageController.animateToPage(
  //         0,
  //         duration: const Duration(milliseconds: 300),
  //         curve: Curves.easeInOut,
  //       );
  //     }
  //   });
  // }

  @override
  void dispose() {
    _autoScrollTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  allowImplicitScrolling: false,
                  controller: _pageController,
                  itemCount: onboardingData.length,
                  onPageChanged: (index) {
                    // _resetAndStartTimer();
                    setState(() {
                      currentIndex = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    final data = onboardingData[index];
                    return Column(
                      children: [
                        AppText(
                          text: "billsync",
                          textColor: AppColor.blueTextColor,
                          fontsize: 28,
                          fontWeight: FontWeight.w500,
                          fontfamily: GoogleFonts.megrim().fontFamily,
                        ),
                        appSpaces.spaceForHeight50,
                        Image.asset(
                          data["image"]!,
                          fit: BoxFit.cover,
                          height: 235,
                          width: 500,
                        ),
                        // Center(
                        //   child: SvgPicture.asset(
                        //     data["image"]!,
                        //     fit: BoxFit.contain,
                        //     height: 300
                        //   ),
                        // ),
                        Spacer(),
                        Column(
                          children: [
                            AppText(
                              text: data["headingText"]!,
                              textColor: AppColor.textBlack,
                              fontsize: 26,
                              fontWeight: FontWeight.bold,
                              textAlign: TextAlign.center,
                              height: 1.2,
                              fontfamily: GoogleFonts.inter().fontFamily,
                            ),
                            appSpaces.spaceForHeight10,
                            AppText(
                              text: data["text"]!,
                              textColor: AppColor.textGrey,
                              fontsize: 17,
                              fontWeight: FontWeight.w400,
                              textAlign: TextAlign.center,
                              height: 1.4,
                              fontfamily: GoogleFonts.inter().fontFamily,
                            ),
                            appSpaces.spaceForHeight20,
                            appSpaces.spaceForHeight20,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(
                                onboardingData.length,
                                (index) => AnimatedContainer(
                                  duration: const Duration(milliseconds: 300),
                                  margin: const EdgeInsets.symmetric(horizontal: 5),
                                  width: currentIndex == index ? 14 : 8,
                                  height: currentIndex == index ? 14 : 8,
                                  decoration: BoxDecoration(
                                    color: currentIndex == index ? AppColor.primary : AppColor.lightGrey,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                              ),
                            ),
                            appSpaces.spaceForHeight20,
                            appSpaces.spaceForHeight20,
                            CustomButton(
                              width: 130,
                              // width: index == onboardingData.length - 1 ? 150 : 110,
                              text: index == onboardingData.length - 1 ? 'Get Started' : 'Next',
                              // rightIcon: Icons.arrow_circle_right_outlined,
                              onPressed: () {
                                if (index < onboardingData.length - 1) {
                                  _pageController.nextPage(
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                  );
                                } else {
                                  context.pushReplacementNamed(RoutePath.loginScreen);
                                }
                              },
                            ),
                            appSpaces.spaceForHeight20,
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
