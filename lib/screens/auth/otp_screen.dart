import 'package:bill_sync_app/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import 'package:bill_sync_app/customs/custom_appbar.dart';
import 'package:bill_sync_app/customs/custom_button.dart';
import 'package:bill_sync_app/extensions/extension.dart';
import 'package:bill_sync_app/services/auth_service.dart';
import 'package:bill_sync_app/utils/app_spaces.dart';
import 'package:bill_sync_app/utils/text_utility.dart';

class OtpScreen extends ConsumerStatefulWidget {
  final int otp;
  final String userEmail;
  const OtpScreen({super.key, required this.otp, required this.userEmail});

  @override
  ConsumerState<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends ConsumerState<OtpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _otpController = TextEditingController();
  final AuthService _authService = AuthService();

  void _verifyOtp() async {
    await _authService.verifyOtp(
      body: {
        "email": widget.userEmail,
        "otp": widget.otp.toString(),
        "type": "1",
      },
      email: widget.userEmail,
      context: context,
      ref: ref,
    );
  }

  // void _resendOtp() async {
  //   try {
  //     final response = await _authService.forgetPassword(
  //       body: {
  //         "email": widget.userEmail,
  //         "type": "0",
  //       },
  //       email: widget.userEmail,
  //       context: context,
  //       ref: ref,
  //     );

  //     if (response != null && response.statusCode == 200) {
  //       final newOtp = response.data['data'];
  //       setState(() {
  //         _otpController.text = newOtp.toString();
  //       });
  //       Utils.snackBar("OTP resent successfully", context);
  //     }
  //   } catch (e) {
  //     print("Error in resending OTP: $e");
  //   }
  // }

  @override
  void initState() {
    super.initState();
    _otpController.text = widget.otp.toString();
  }

  @override
  Widget build(BuildContext context) {
    final userEmailAddress = widget.userEmail;
    return Scaffold(
      appBar: customAppBar(
        showLeading: true,
        onBack: () {
          context.pop();
        },
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 40),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // appSpaces.spaceForHeight20,
                // SizedBox(
                //   height: 350,
                //   child: SvgPicture.asset('assets/svg/svg7.svg'),
                //   // child: SvgPicture.asset('assets/svg/svg1.svg', fit: BoxFit.contain),
                // ),
                // appSpaces.spaceForHeight40,
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      appSpaces.spaceForHeight20,
                      AppText(
                        text: 'Enter Confirmation Code',
                        fontsize: 26,
                        fontWeight: FontWeight.w600,
                        textColor: AppColor.textBlack,
                        fontfamily: GoogleFonts.inter().fontFamily,
                        height: 1.5,
                      ),
                      AppText(
                        text: 'A 4-digit code was sent to\n $userEmailAddress',
                        fontsize: 16,
                        fontWeight: FontWeight.w500,
                        textColor: AppColor.textGrey,
                        fontfamily: GoogleFonts.inter().fontFamily,
                      ),
                      appSpaces.spaceForHeight35,
                      Center(
                        child: Pinput(
                          keyboardType: TextInputType.number,
                          controller: _otpController,
                          length: 4,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter OTP';
                            }
                            if (value.length < 4) {
                              return 'OTP must be 4 digits';
                            }
                            return null;
                          },
                          defaultPinTheme: PinTheme(
                            height: 50,
                            width: 50,
                            textStyle: const TextStyle(
                              color: AppColor.secondary,
                              fontSize: 20,
                            ),
                            decoration: BoxDecoration(
                              border: const Border.fromBorderSide(
                                BorderSide(
                                  width: 0.7,
                                  color: AppColor.lightGreyColor,
                                ),
                              ),
                              borderRadius: BorderRadius.circular(8),
                              color: AppColor.white,
                            ),
                          ),
                        ),
                      ),
                      appSpaces.spaceForHeight40,
                      CustomButton(
                        text: 'Verify',
                        fontsize: 16,
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _verifyOtp();
                          }
                          // context.push(ChangePasswordScreen());
                        },
                      ),
                      appSpaces.spaceForHeight20,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AppText(text: "Didn't received otp?"),
                          appSpaces.spaceForWidth5,
                          GestureDetector(
                            // onTap: _resendOtp,
                            child: AppText(
                              text: "RESEND",
                              fontsize: 14,
                              fontWeight: FontWeight.w700,
                              textColor: AppColor.primary,
                            ),
                          ),
                        ],
                      ),

                      //            _ _ _ _ _ _ _ _ _         
                      //           //////////////////|
                      //          //////////////////||
                      //          |HIHIHIHIHIHIHIHI|||
                      //          |HIHIHIHIHIHIHIHI|||
                      //          |HIHIHIHIHIHIHIHI|/
                      //          |HIHIHIHIHIHIHIHI/
                      //          



                      // 5 Kg dumbells :
                      //
                      //
                      // (|===|)    (|===|)



                      // Van on a road-trip:
                      //
                      //                    _______
                      //           --------/_| [] [|------------
                      //              ==  "--O---O-' ==    ==
                      //           -----------------------------



                      // Pencil colors
                      //
                      //  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _
                      // | || || || || || || || || || || || || || || || |
                      // | || || || || || || || || || || || || || || || |
                      // | || || || || || || || || || || || || || || || |
                      // \_/\_/\_/\_/\_/\_/\_/\_/\_/\_/\_/\_/\_/\_/\_/\_/
                      //  v  V  V  V  V  V  V  V  v  V  V  V  V  V  V  V
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
