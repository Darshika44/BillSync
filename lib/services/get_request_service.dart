// ignore_for_file: avoid_print

import 'package:bill_sync_app/constants/app_constant.dart';
import 'package:bill_sync_app/services/base_url.dart';
import 'package:bill_sync_app/services/request.dart';
import 'package:bill_sync_app/utils/common_utils.dart';
import 'package:flutter/material.dart';

class GetRequestServices {
  Future<dynamic> getDashboardData({required BuildContext context}) async {
    dynamic dashboardData = {};
    try {
      final response = await RequestUtils().getRequest(
        url: ServiceUrl.getDashboardData,
      );

      if (response.statusCode == 200) {
        dashboardData = response.data['data'];
      }

      return dashboardData;
    } catch (e) {
      Utils.errorSnackBar('Something Went Wrong', context);
      print("Error in fetching dashboard data: $e");
      return null;
    }
  }

  Future<ApiResponse?> getUserDetails({required BuildContext context}) async {
    try {
      final response = await RequestUtils().getRequest(
        url: ServiceUrl.getUserDetailsUrl,
      );
      return response;
    } catch (e) {
      Utils.errorSnackBar('Something Went Wrong', context);
      AppConst.showConsoleLog("Error in fetching user details: $e");
      return null;
    }
  }

  Future<List<dynamic>> getInvoicesList({required BuildContext context}) async {
    try {
      List<dynamic> list = [];

      final response = await RequestUtils().getRequest(
        url: ServiceUrl.getAllInvoicesUrl,
      );

      if (response.statusCode == 200) {
        list = response.data['data']["invoices"];
      }

      return list;
    } catch (e) {
      Utils.errorSnackBar('Something Went Wrong', context);
      print("Error in fetching invoices: $e");
      return [];
    }
  }

  Future<List<dynamic>> getInventoryList({
    required BuildContext context,
  }) async {
    try {
      List<dynamic> list = [];

      final response = await RequestUtils().getRequest(
        url: ServiceUrl.getAllInventoryUrl,
      );

      if (response.statusCode == 200) {
        list = response.data['data'];
      }

      return list;
    } catch (e) {
      Utils.errorSnackBar('Something Went Wrong', context);
      print("Error in fetching inventory: $e");
      return [];
    }
  }

  Future<List<dynamic>> getInventoryHistory({
    required BuildContext context,
    required String url,
  }) async {
    try {
      List<dynamic> list = [];

      final response = await RequestUtils().getRequest(url: url);

      if (response.statusCode == 200) {
        list = response.data['data']['histores'];
      }

      return list;
    } catch (e) {
      Utils.errorSnackBar('Something Went Wrong', context);
      print("Error in fetching inventory history: $e");
      return [];
    }
  }

  Future<dynamic> getVendorDetailById({
    required BuildContext context,
    required String url,
  }) async {
    dynamic vendorData = {};
    try {
      final response = await RequestUtils().getRequest(
        url: url,
        // url: ServiceUrl.getVendorDetailstUrl,
      );

      if (response.statusCode == 200) {
        vendorData = response.data['data'];
      }

      return vendorData;
    } catch (e) {
      Utils.errorSnackBar('Something Went Wrong', context);
      print("Error in fetching vendor data: $e");
      return null;
    }
  }

  Future<ApiResponse?> getVendorStatus({
    required BuildContext context,
    required String url,
  }) async {
    try {
      final response = await RequestUtils().getRequest(
        url: url,
        // url: ServiceUrl.getVendorDetailstUrl,
      );

      return response;
    } catch (e) {
      Utils.errorSnackBar('Something Went Wrong', context);
      print("Error in fetching vendor data: $e");
      return null;
    }
  }
}
