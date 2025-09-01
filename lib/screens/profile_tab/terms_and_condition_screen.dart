import 'package:bill_sync_app/constants/color_constants.dart';
import 'package:bill_sync_app/constants/svg_constants.dart';
import 'package:bill_sync_app/customs/custom_appbar.dart';
import 'package:bill_sync_app/customs/custom_button.dart';
import 'package:bill_sync_app/customs/custom_field.dart';
import 'package:bill_sync_app/extensions/extension.dart';
import 'package:bill_sync_app/utils/app_spaces.dart';
import 'package:bill_sync_app/utils/text_utility.dart';
import 'package:bill_sync_app/validations/basic_validation.dart';
import 'package:flutter/material.dart';

class TermsAndConditionScreen extends StatefulWidget {
  const TermsAndConditionScreen({super.key});

  @override
  State<TermsAndConditionScreen> createState() =>
      _TermsAndConditionScreenState();
}

class _TermsAndConditionScreenState extends State<TermsAndConditionScreen> {
  final TextEditingController _termAndConditionController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        title: "Terms & Conditions",
        icon: SvgConstants.arrowLeftIcon,
        showLeading: true,
        titleSpacing: 5,
        onBack: () {
          context.pop();
        },
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 20),
            decoration: BoxDecoration(
              color: AppColor.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                AppText(
                  text: "Enter your terms & conditions",
                  fontsize: 15,
                  fontWeight: FontWeight.w400,
                ),
                appSpaces.spaceForHeight6,
                TextAreaField(
                  inputController: _termAndConditionController,
                  hintText: "Start typing...",
                  validator: (value) {
                    return validateForNormalFeild(value: value, props: "query");
                  },
                ),
                appSpaces.spaceForHeight30,
                CustomButton(text: "Update", onPressed: (){}),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
