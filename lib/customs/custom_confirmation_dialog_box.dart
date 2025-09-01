import 'package:bill_sync_app/constants/color_constants.dart';
import 'package:flutter/material.dart';

import '../utils/text_utility.dart';

void showConfirmDialogBox(
  BuildContext context,
  void Function() onConfirmPress,
  String title,
  String content,
  String cofirmText,
) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        title: AppText(
          text: title,
          fontsize: 20,
          fontWeight: FontWeight.w500,
        ),
        content: AppText(
          text: content,
          fontWeight: FontWeight.w400,
          fontsize: 16,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const AppText(
              text: 'Cancel',
              // fontWeight: FontWeight.w500,
              fontsize: 16,
              textColor: AppColor.primary,
            ),
          ),
          TextButton(
            onPressed: onConfirmPress,
            child: AppText(
              text: cofirmText,
              // fontWeight: FontWeight.w500,
              fontsize: 16,
              textColor: AppColor.primary,
            ),
          ),
        ],
      );
    },
  );
}
