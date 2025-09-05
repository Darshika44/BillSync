import 'package:bill_sync_app/constants/color_constants.dart';
import 'package:bill_sync_app/utils/text_utility.dart';
import 'package:bill_sync_app/widgets/status_button.dart';
import 'package:flutter/material.dart';


class VendorListTile extends StatelessWidget {
  final String? userName;
  final String? userEmail;
  final String userStatus;
  final Function()? onTap;
  const VendorListTile({
    super.key, 
    this.userName, 
    this.userEmail, 
    required this.userStatus, 
    this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 22),
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            VendorProfilePlaceholder(),
            SizedBox(width: 17),
            // appSpaces.spaceForWidth20,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  text: userName ?? "",
                  // text: "John Smith",
                  fontsize: 13,
                  fontWeight: FontWeight.w500,
                ),
                AppText(
                  text: userEmail ?? "",
                  // text: "johnsmith@test.com",
                  fontsize: 11,
                  fontWeight: FontWeight.w400,
                ),
              ],
            ),
            Spacer(),
            StatusButton(status: userStatus),
          ],
        ),
      ),
    );
  }
}

class VendorProfilePlaceholder extends StatelessWidget {
  const VendorProfilePlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: AppColor.scaffoldBackground,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: AppColor.black.withValues(alpha: 0.15),
            blurRadius: 5,
            spreadRadius: 0,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Icon(
        Icons.person_2_rounded, 
        color: AppColor.blue.withValues(alpha: 0.5)
      ),
    );
  }
}