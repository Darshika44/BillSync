import 'package:bill_sync_app/constants/app_constant.dart';
import 'package:bill_sync_app/services/base_url.dart';
import 'package:bill_sync_app/services/request.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../utils/common_utils.dart';

class PostRequestServices {
  Future<ApiResponse?> createInvoice({
    required BuildContext context,
    required WidgetRef ref,
    required Map<String, dynamic> body,
    required Map<String, dynamic> imageMap,
  }) async {
    setLoader(ref, true);
    try {
      final response = await RequestUtils().formDataPostRequest(
        url: ServiceUrl.createInvoiceUrl,
        method: "POST",
        fields: body,
        imageMap: imageMap,
      );
      AppConst.showConsoleLog(response);
      setLoader(ref, false);
      return response;
    } catch (e) {
      setLoader(ref, false);
      Utils.errorSnackBar('Something Went Wrong', context);
      AppConst.showConsoleLog("Error in creating training: $e");
      return null;
    }
  } 

  Future<ApiResponse?> addInventory({
    required BuildContext context,
    required WidgetRef ref,
    required String url,
    required Map<String, dynamic> body,
  }) async {
    setLoader(ref, true);
    try {
      final response = await RequestUtils().postRequest(
        url: url,
        method: "POST",
        body: body,
      );
      AppConst.showConsoleLog(response);
      setLoader(ref, false);
      return response;
    } catch (e) {
      setLoader(ref, false);
      Utils.errorSnackBar('Something Went Wrong', context);
      AppConst.showConsoleLog("Error in adding inventory: $e");
      return null;
    }
  }

  Future<ApiResponse?> updateProfile({
    required BuildContext context,
    required WidgetRef ref,
    required Map<String, dynamic> body,
    required Map<String, dynamic> imageMap,
  }) async {
    setLoader(ref, true);
    try {
      final response = await RequestUtils().formDataPostRequest(
        url: ServiceUrl.updateUserProfileUrl,
        method: "POST",
        fields: body,
        imageMap: imageMap,
      );
      AppConst.showConsoleLog(response);
      setLoader(ref, false);
      return response;
    } catch (e) {
      setLoader(ref, false);
      Utils.errorSnackBar('Something Went Wrong', context);
      AppConst.showConsoleLog("Error in creating training: $e");
      return null;
    }
  }
}
