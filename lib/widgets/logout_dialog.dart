

import 'package:bill_sync_app/constants/color_constants.dart';
import 'package:bill_sync_app/customs/custom_button.dart';
import 'package:bill_sync_app/extensions/extension.dart';
import 'package:bill_sync_app/utils/app_spaces.dart';
import 'package:bill_sync_app/utils/text_utility.dart';
import 'package:flutter/material.dart';

void showLogoutDialog(BuildContext context,{
  Widget? icon,
  String? titleLineOne,
  String? titleLineTwo,
  required Function() onConfirmPressed,
}) {
  showDialog(
    context: context, 
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        // backgroundColor: AppColor.primary,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.red.shade50, width: 5),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.red.shade100,
                    // color: Color(0XFFFFB2B2),
                    shape: BoxShape.circle,
                  ),
                  child: icon ?? Icon(Icons.logout, color: Colors.red, size: 34),
                  // child: Icon(Icons.logout, color: Colors.red, size: 35),
                ),
              ),
              SizedBox(height: 20),
              AppText(
                text: titleLineOne ?? "",
                // text: titleLineOne ?? "Are you sure you want to Logout app?",
                fontsize: 14,
                fontWeight: FontWeight.w600,
                textAlign: TextAlign.center,
                textColor: AppColor.textDarkGreyColor,
              ),
              // appSpaces.spaceForHeight10,
              // AppText(
              //   text: titleLineTwo ?? "Note: Your data will be deleted and can’t be recovered.",
              //   fontsize: 12,
              //   fontWeight: FontWeight.w400,
              //   textAlign: TextAlign.center,
              //   // textColor: AppColor.lightBorderColor,
              // ),
              appSpaces.spaceForHeight20,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: CustomButton(
                      text: "No",
                      textColor: AppColor.textGreyColor,
                      borderColor: AppColor.textGreyColor,
                      isBorder: true,
                      buttonColor: Colors.transparent,
                      onPressed: () {
                        context.pop();
                      },
                    ),
                  ),
                  appSpaces.spaceForWidth15,
                  Expanded(
                    child: CustomButton(
                      text: "Yes",
                      buttonColor: AppColor.primary,
                      onPressed: onConfirmPressed,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}