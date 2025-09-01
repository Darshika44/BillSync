import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bill_sync_app/constants/color_constants.dart';
import 'package:bill_sync_app/customs/custom_appbar.dart';
import 'package:bill_sync_app/customs/custom_button.dart';
import 'package:bill_sync_app/customs/custom_field.dart';
import 'package:bill_sync_app/extensions/extension.dart';
import 'package:bill_sync_app/services/auth_service.dart';
import 'package:bill_sync_app/utils/app_spaces.dart';
import 'package:bill_sync_app/utils/text_utility.dart';
import 'package:bill_sync_app/validations/basic_validation.dart';

class ForgetPasswordScreen extends ConsumerStatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  ConsumerState<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends ConsumerState<ForgetPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final AuthService _authService = AuthService();

  void _forgetPassword() async {
    await _authService.forgetPassword(
      body: {
        "email": _emailController.text,
        "type": "1"
      },
      email: _emailController.text,
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
              children: [
                // appSpaces.spaceForHeight20,
                // SizedBox(
                //   height: 350,
                //   child: SvgPicture.asset('assets/svg/svg4.svg'),
                //   // child: SvgPicture.asset('assets/svg/svg2.svg', fit: BoxFit.contain),
                // ),
                // appSpaces.spaceForHeight30,
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      appSpaces.spaceForHeight20,
                      AppText(
                        text: 'Forgot Password',
                        fontsize: 26,
                        fontWeight: FontWeight.w600,
                        textColor: AppColor.textBlack,
                        fontfamily: GoogleFonts.inter().fontFamily,
                        height: 1.5,
                      ),
                      AppText(
                        text: 'Enter you email address',
                        fontsize: 16,
                        fontWeight: FontWeight.w500,
                        textColor: AppColor.textGrey,
                        fontfamily: GoogleFonts.inter().fontFamily,
                      ),
                      SizedBox(height: 45),
                      customField(
                        hintText: 'Email Address',
                        controller: _emailController,
                        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        keyboardType: TextInputType.emailAddress,
                        filled: true,
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Icon(Icons.mail_outlined, color: AppColor.lightGrey, size: 24),
                        ),
                        validator: validateEmail,
                      ),
                      appSpaces.spaceForHeight35,
                      CustomButton(
                        text: 'Get OTP',
                        fontsize: 16,
                        onPressed: (){
                          if(_formKey.currentState!.validate()) {
                            _forgetPassword();
                          }
                          // context.pushNamed(RoutePath.otpScreen); 
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