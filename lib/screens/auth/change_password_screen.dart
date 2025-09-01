import 'package:bill_sync_app/constants/color_constants.dart';
import 'package:bill_sync_app/constants/svg_constants.dart';
import 'package:bill_sync_app/customs/custom_appbar.dart';
import 'package:bill_sync_app/customs/custom_button.dart';
import 'package:bill_sync_app/customs/custom_field.dart';
import 'package:bill_sync_app/extensions/extension.dart';
import 'package:bill_sync_app/services/auth_service.dart';
import 'package:bill_sync_app/utils/app_spaces.dart';
import 'package:bill_sync_app/utils/text_utility.dart';
import 'package:bill_sync_app/validations/basic_validation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class ChangePasswordScreen extends ConsumerStatefulWidget {
  final String userEmail;
  const ChangePasswordScreen({super.key, required this.userEmail});

  @override
  ConsumerState<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends ConsumerState<ChangePasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final AuthService _authService = AuthService();

  bool passwordVisible = false;
  bool confirmpasswordVisible = false;

  void togglePasswordVisibility() {
    passwordVisible = !passwordVisible;
    setState(() {});
  }

  void toggleConfirmPasswordVisibility() {
    confirmpasswordVisible = !confirmpasswordVisible;
    setState(() {});
  }

  void _changePassword() async {
    await _authService.changePassword(
      body: {
        "email": widget.userEmail,
        "newPassword": _passwordController,
        "conformPassword": _confirmPasswordController,
        "type": "1"
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
        onBack: (){
          context.pop();
        }
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // SizedBox(
                //   height: 330,
                //   child: SvgPicture.asset('assets/svg/svg6.svg'),
                //   // child: SvgPicture.asset('assets/svg/svg3.svg', fit: BoxFit.contain),
                // ),
                // appSpaces.spaceForHeight30,
                AppText(
                  text: 'New Password',
                  fontsize: 26,
                  fontWeight: FontWeight.w600,
                  textColor: AppColor.textBlack,
                  fontfamily: GoogleFonts.inter().fontFamily,
                  height: 1.5,
                ),
                AppText(
                  text: 'Enter new password',
                  fontsize: 16,
                  fontWeight: FontWeight.w500,
                  textColor: AppColor.textGrey,
                  fontfamily: GoogleFonts.inter().fontFamily,
                ),
                // appSpaces.spaceForHeight25,
                SizedBox(height: 45),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
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
                            icon: SvgPicture.asset(passwordVisible ? SvgConstants.visibilitySvg : SvgConstants.visibilityOffSvg, width: 22, height: 22),
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
                            icon: SvgPicture.asset(confirmpasswordVisible ? SvgConstants.visibilitySvg : SvgConstants.visibilityOffSvg, width: 22, height: 22),
                            onPressed: toggleConfirmPasswordVisibility,
                          ),
                        ),
                        obscureText: !confirmpasswordVisible,
                        validator: validatePassword,
                      ),
                      appSpaces.spaceForHeight40,
                      CustomButton(
                        text: 'Submit',
                        fontsize: 16,
                        onPressed: (){
                          if(_formKey.currentState!.validate()) {
                            _changePassword();
                          } 
                          // context.pushNamed(RoutePath.loginScreen); 
                        }
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
