// ignore_for_file: use_build_context_synchronously

import 'package:bill_sync_app/screens/home_tab/bottom_bar_screen.dart';
import 'package:bill_sync_app/screens/auth/change_password_screen.dart';
import 'package:bill_sync_app/screens/auth/login_screen.dart';
import 'package:bill_sync_app/screens/auth/otp_screen.dart';
import 'package:bill_sync_app/services/base_url.dart';
import 'package:bill_sync_app/services/request.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bill_sync_app/extensions/extension.dart';

import '../constants/app_constant.dart';
import '../utils/common_utils.dart';
import '../utils/local_storage.dart';

class AuthService {
  // Login Function
  Future<ApiResponse?> login({
    required Map<String, dynamic> body,
    required BuildContext context,
    required WidgetRef ref,
  }) async {
    try {
      setLoader(ref, true);

      final response = await RequestUtils().postRequest(
        url: ServiceUrl.loginUrl,
        body: body,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final token = response.data["data"]["accessToken"];
        AppConst.setAccessToken(token);

        await LocalStorage.saveToken(token: token, key: "access_token");
        context.pushReplace(BottomBarScreen());
        // context.pushNamed(RoutePath.homeScreen);
        Utils.snackBar(response.data['message'] ?? "", context);
      } else {
        Utils.errorSnackBar(
          response.error ?? "Something went wrong!",
          context,
        );
      }

      setLoader(ref, false);
      return response;
    } catch (e) {
      setLoader(ref, false);
      Utils.errorSnackBar('Something Went Wrong', context);
      AppConst.showConsoleLog("Error in login: $e");
      return null;
    }
  }

  // Verify otp Function
  Future<ApiResponse?> verifyOtp({
    required Map<String, dynamic> body,
    required String email,
    required BuildContext context,
    required WidgetRef ref,
  }) async {
    try {
      setLoader(ref, true);

      final response = await RequestUtils().postRequest(
        url: ServiceUrl.otpVerifyUrl,
        body: body,
      );

      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 202 ||
          response.statusCode == 203) {
        context.push(ChangePasswordScreen(userEmail: email));
        Utils.snackBar(response.data['message'] ?? "", context);
      } else {
        Utils.errorSnackBar(response.error ?? "Something went wrong!", context);
      }

      setLoader(ref, false);
      return response;
    } catch (e) {
      setLoader(ref, false);
      Utils.errorSnackBar('Something Went Wrong', context);
      AppConst.showConsoleLog("Error in otp varification: $e");
      return null;
    }
  }

  // Signup Function
  Future<ApiResponse?> signUp({
    required Map<String, dynamic> body,
    required BuildContext context,
    required WidgetRef ref,
  }) async {
    try {
      setLoader(ref, true);
      final response = await RequestUtils().postRequest(
        url: ServiceUrl.singupUrl,
        body: body,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        context.pop();
        Utils.snackBar(response.data['message'], context);
      } else {
        Utils.errorSnackBar(response.error ?? "Something went wrong!", context);
      }

      setLoader(ref, false);

      return response;
    } catch (e) {
      setLoader(ref, false);
      AppConst.showConsoleLog("Error in signUp: $e");
      return null;
    }
  }

  // Forgot Password Function
  Future<ApiResponse?> forgetPassword({
    required Map<String, dynamic> body,
    required String email,
    required BuildContext context,
    required WidgetRef ref,
  }) async {
    try {
      setLoader(ref, true);

      final response = await RequestUtils().postRequest(
        url: ServiceUrl.forgetPasswordUrl,
        body: body,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final otp = response.data['data'];
        context.push(OtpScreen(userEmail: email, otp: otp));
        Utils.snackBar(response.data['message'] ?? "", context);
      } else {
        Utils.errorSnackBar(response.error ?? "Something went wrong!", context);
      }

      setLoader(ref, false);
      return response;
    } catch (e) {
      setLoader(ref, false);
      Utils.errorSnackBar('Something Went Wrong', context);
      AppConst.showConsoleLog("Error in sending otp: $e");
      return null;
    }
  }

  // Change Password Function
  Future<ApiResponse?> changePassword({
    required Map<String, dynamic> body,
    required BuildContext context,
    required WidgetRef ref,
  }) async {
    try {
      setLoader(ref, true);

      final response = await RequestUtils().postRequest(
        url: ServiceUrl.changePasswordUrl,
        body: body,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        context.push(LoginScreen());
        Utils.snackBar(response.data['message'] ?? "", context);
      } else {
        Utils.errorSnackBar(response.error ?? "Something went wrong!", context);
      }

      setLoader(ref, false);
      return response;
    } catch (e) {
      setLoader(ref, false);
      Utils.errorSnackBar('Something Went Wrong', context);
      AppConst.showConsoleLog("Error in changing password: $e");
      return null;
    }
  }

  // Forgot Password Function
  // Future<bool> forgotPassword(String email) async {
  //   try {
  //     final response = await http.post(
  //       Uri.parse("${ServiceUrl.baseUrl}/v1/auth/send-resend-otp"),
  //       headers: {"Content-Type": "application/json"},
  //       body: jsonEncode({
  //         "email": email,
  //         "type": "0",
  //       }),
  //     );

  //     return response.statusCode == 200;
  //   } catch (e) {
  //     print("Error in forgotPassword: $e");
  //     return false;
  //   }
  // }
}
