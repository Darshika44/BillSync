import 'package:bill_sync_app/constants/color_constants.dart';
import 'package:bill_sync_app/screens/auth/forget_password_screen.dart';
import 'package:bill_sync_app/screens/auth/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bill_sync_app/constants/svg_constants.dart';
import 'package:bill_sync_app/customs/custom_button.dart';
import 'package:bill_sync_app/customs/custom_field.dart';
import 'package:bill_sync_app/extensions/extension.dart';
import 'package:bill_sync_app/services/auth_service.dart';
import 'package:bill_sync_app/utils/app_spaces.dart';
import 'package:bill_sync_app/utils/text_utility.dart';
import 'package:bill_sync_app/validations/basic_validation.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService = AuthService();

  bool passwordVisible = false;
  void togglePasswordVisibility() {
    passwordVisible = !passwordVisible;
    setState(() {});
  }

  void _login() async {
    await _authService.login(
      body: {
        "email": _emailController.text,
        "password": _passwordController.text,
        "type": "1"
    },
      context: context,
      ref: ref,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              appSpaces.spaceForHeight10,
              SvgPicture.asset(
                SvgConstants.loginIllustrationSvg, 
                fit: BoxFit.cover,
                height: 400
              ),
              AppText(
                text: 'Welcome!',
                fontsize: 26,
                  fontWeight: FontWeight.w600,
                  textColor: AppColor.textBlack,
                  fontfamily: GoogleFonts.inter().fontFamily,
                  height: 1.5,
              ),
              AppText(
                text: 'Fill in email and password to continue',
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
                      hintText: 'Email Address',
                      controller: _emailController,
                      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      keyboardType: TextInputType.emailAddress,
                      filled: true,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Icon(Icons.mail_outlined, color: AppColor.textGrey, size: 24),
                      ),
                      validator: validateEmail,
                    ),
                    appSpaces.spaceForHeight20,
                    customField(
                      hintText: 'Password',
                      controller: _passwordController,
                      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      keyboardType: TextInputType.text,
                      filled: true,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Icon(Icons.lock_outlined, color: AppColor.textGrey, size: 24),
                      ),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: IconButton(
                          highlightColor: AppColor.transparent,
                          icon: SvgPicture.asset(
                            passwordVisible ? SvgConstants.visibilitySvg : SvgConstants.visibilityOffSvg, 
                            width: 22, 
                            height: 22
                          ),
                          onPressed: togglePasswordVisibility,
                        ),
                      ),
                      obscureText: !passwordVisible,
                      validator: validatePassword,
                    ),
                    appSpaces.spaceForHeight5,
                    Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: (){ 
                          context.push(ForgetPasswordScreen());
                        },
                        child: AppText(
                          text: 'Forget Password?', 
                          fontsize: 13,
                          fontWeight: FontWeight.w500,
                          textColor: AppColor.primary,
                        ),
                      ),
                    ),
                    appSpaces.spaceForHeight30,
                    CustomButton(
                      text: 'Login',
                      fontsize: 16,
                      onPressed: (){ 
                        if(_formKey.currentState!.validate()){
                          _login();
                        }
                        // context.pushNamed(RoutePath.homeScreen); 
                      }
                    ),
                    appSpaces.spaceForHeight15,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AppText(
                          text: "Don't have an account?",
                          fontsize: 15,
                          fontWeight: FontWeight.w500,
                          textColor: AppColor.textGrey,
                          fontfamily: GoogleFonts.inter().fontFamily,
                        ),
                        InkWell(
                          onTap: (){ 
                            // context.pushNamed(RoutePath.signupScreen); 
                            context.push(SignupScreen());
                          },
                          child: AppText(
                            text: " Sign Up",
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
              appSpaces.spaceForHeight50,
            ],
          ),
        ),
      ),
    );
  }
}
