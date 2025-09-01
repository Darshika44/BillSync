import 'package:bill_sync_app/constants/color_constants.dart';
import 'package:bill_sync_app/extensions/extension.dart';
import 'package:flutter/material.dart';

import '../utils/app_spaces.dart';
import '../utils/text_utility.dart';

void showCustomBottomSheet(
  BuildContext context,
  String title,
  Widget child,
) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                height: 5,
                width: 40,
                decoration: BoxDecoration(
                  color: AppColor.lightGreyColor,
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
            ),
            appSpaces.spaceForHeight15,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText(
                  text: title,
                  fontsize: 20,
                  fontWeight: FontWeight.w600,
                ),
                InkWell(
                  onTap: () => context.pop(),
                  child: Icon(Icons.close),
                ),
              ],
            ),
            child,
            appSpaces.spaceForHeight10,
          ],
        ),
      );
    },
  );
}
