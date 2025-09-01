import 'package:bill_sync_app/constants/color_constants.dart';
import 'package:bill_sync_app/customs/custom_appbar.dart';
import 'package:bill_sync_app/extensions/extension.dart';
import 'package:bill_sync_app/screens/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bill_sync_app/constants/svg_constants.dart';
import 'package:bill_sync_app/customs/custom_button.dart';
import 'package:bill_sync_app/customs/custom_field.dart';
import 'package:bill_sync_app/services/auth_service.dart';
import 'package:bill_sync_app/utils/app_spaces.dart';
import 'package:bill_sync_app/utils/text_utility.dart';
import 'package:bill_sync_app/validations/basic_validation.dart';

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({super.key});

  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _contactNumberController =
      TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final AuthService _authService = AuthService();

  bool passwordVisible = false;
  bool confirmPasswordVisible = false;
  void togglePasswordVisibility() {
    passwordVisible = !passwordVisible;
    setState(() {});
  }

  void toggleConfirmPasswordVisibility() {
    confirmPasswordVisible = !confirmPasswordVisible;
    setState(() {});
  }

  void _signup() async {
    await _authService.signUp(
      body: {
        "fullName": _nameController.text,
        "email": _emailController.text,
        "contact": _contactNumberController.text,
        "password": _passwordController.text,
        "address": _addressController.text,
      },
      context: context,
      ref: ref,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        showLeading: true,
        titleSpacing: 5,
        onBack: () {
          context.pop();
        },
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // SvgPicture.asset(
                //   SvgConstants.loginIllustrationSvg,
                //   fit: BoxFit.cover,
                //   height: 400
                // ),
                appSpaces.spaceForHeight20,
                AppText(
                  text: 'Sign Up',
                  fontsize: 26,
                  fontWeight: FontWeight.w600,
                  textColor: AppColor.textBlack,
                  fontfamily: GoogleFonts.inter().fontFamily,
                  height: 1.5,
                ),
                AppText(
                  text: 'Please register with your personal details',
                  fontsize: 16,
                  fontWeight: FontWeight.w500,
                  textColor: AppColor.textGrey,
                  fontfamily: GoogleFonts.inter().fontFamily,
                ),
                appSpaces.spaceForHeight25,
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      customField(
                        hintText: 'Full Name',
                        controller: _nameController,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 15,
                        ),
                        keyboardType: TextInputType.text,
                        filled: true,
                        maxLength: 30,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp(r'[a-zA-Z\s]'),
                          ),
                        ],
                        validator: (value) {
                          return validateForNameField(
                            value: value,
                            props: "name",
                          );
                        },
                      ),
                      appSpaces.spaceForHeight20,
                      customField(
                        hintText: 'Email Address',
                        controller: _emailController,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 15,
                        ),
                        keyboardType: TextInputType.emailAddress,
                        filled: true,
                        validator: validateEmail,
                      ),
                      appSpaces.spaceForHeight20,
                      customField(
                        hintText: 'Contact Number',
                        controller: _contactNumberController,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 15,
                        ),
                        keyboardType: TextInputType.phone,
                        filled: true,
                        maxLength: 10,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                        ],
                        validator: validateForMobileField,
                      ),
                      appSpaces.spaceForHeight20,
                      customField(
                        hintText: 'Address',
                        controller: _addressController,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 15,
                        ),
                        keyboardType: TextInputType.phone,
                        filled: true,
                        maxLength: 100,
                        validator: (value) {
                          return validateForNormalFeild(
                            value: value,
                            props: "address",
                          );
                        },
                      ),
                      appSpaces.spaceForHeight20,
                      customField(
                        hintText: 'Password',
                        controller: _passwordController,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 15,
                        ),
                        keyboardType: TextInputType.text,
                        filled: true,
                        suffixIcon: Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: IconButton(
                            highlightColor: AppColor.transparent,
                            icon: SvgPicture.asset(
                              passwordVisible
                                  ? SvgConstants.visibilitySvg
                                  : SvgConstants.visibilityOffSvg,
                              width: 22,
                              height: 22,
                            ),
                            onPressed: togglePasswordVisibility,
                          ),
                        ),
                        obscureText: !passwordVisible,
                        validator: validatePassword,
                      ),
                      appSpaces.spaceForHeight20,
                      customField(
                        hintText: 'Confirm Password',
                        controller: _confirmPasswordController,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 15,
                        ),
                        keyboardType: TextInputType.text,
                        filled: true,
                        suffixIcon: Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: IconButton(
                            highlightColor: AppColor.transparent,
                            icon: SvgPicture.asset(
                              confirmPasswordVisible
                                  ? SvgConstants.visibilitySvg
                                  : SvgConstants.visibilityOffSvg,
                              width: 22,
                              height: 22,
                            ),
                            onPressed: toggleConfirmPasswordVisibility,
                          ),
                        ),
                        obscureText: !confirmPasswordVisible,
                        validator: validatePassword,
                      ),
                      appSpaces.spaceForHeight40,
                      CustomButton(
                        text: 'Sign Up',
                        fontsize: 16,
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _signup();
                          }
                          // context.pushNamed(RoutePath.homeScreen);
                        },
                      ),
                      appSpaces.spaceForHeight15,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AppText(
                            text: "Already have an account?",
                            fontsize: 15,
                            fontWeight: FontWeight.w500,
                            textColor: AppColor.textGrey,
                            fontfamily: GoogleFonts.inter().fontFamily,
                          ),
                          InkWell(
                            onTap: () {
                              // context.pushNamed(RoutePath.signupScreen);
                              context.push(LoginScreen());
                            },
                            child: AppText(
                              text: " Login",
                              fontsize: 15,
                              fontWeight: FontWeight.w600,
                              textColor: AppColor.primary,
                              fontfamily: GoogleFonts.inter().fontFamily,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
