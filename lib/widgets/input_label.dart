import 'package:bill_sync_app/constants/color_constants.dart';
import 'package:bill_sync_app/utils/text_utility.dart';
import 'package:flutter/material.dart';

class InputLabel extends StatelessWidget {
  final String labelText;
  const InputLabel({
    super.key,
    required this.labelText
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 3),
      child: AppText(
        text: labelText,
        fontsize: 14,
        textColor: AppColor.textBlack,
        // textColor: AppColor.darkBlue,
      ),
    );
  }
}