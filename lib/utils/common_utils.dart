import 'package:bill_sync_app/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icon_snackbar/flutter_icon_snackbar.dart';
import 'package:intl/intl.dart';

class Utils {
  static void fieldFocusChange(BuildContext context, FocusNode current, FocusNode nextFocus) {
    current.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  // static snackBar(
  //   String message,
  //   BuildContext context, {
  //   backgroundColor = AppColor.primary,
  //   int duration = 2,
  // }) {
  //   return ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //       backgroundColor: backgroundColor,
  //       content: Text(message),
  //       duration: Duration(seconds: duration),
  //     ),
  //   );
  // }

  static snackBar(
    String message,
    BuildContext context, {
    Color? textColor,
    Color? backgroundColor,
    Color? iconColor,
    SnackBarType? snackbarType,
    int duration = 2,
  }) {
    IconSnackBar.show(
      context,
      snackBarType: snackbarType ?? SnackBarType.success,
      label: message,
      labelTextStyle: TextStyle(color: textColor ?? AppColor.black),
      backgroundColor: backgroundColor ?? Colors.green.shade100,
      iconColor: iconColor ?? Colors.green.shade600,
      duration: Duration(seconds: duration),
    );
  }

  static errorSnackBar(
    String message,
    BuildContext context, {
    int duration = 2,
  }) {
    IconSnackBar.show(
      context,
      snackBarType: SnackBarType.fail,
      label: message,
      labelTextStyle: TextStyle(color: AppColor.black),
      backgroundColor: Colors.red.shade100,
      iconColor: Colors.red.shade700,
      duration: Duration(seconds: duration),
    );
  }

  static Future<void> selectDate(
    BuildContext context,
    TextEditingController controller, {
    String? dateFormat,
  }) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      String formattedDate = DateFormat(
        dateFormat ?? 'yyyy-MM-dd',
      ).format(picked);
      controller.text = formattedDate;
    }
  }
}


