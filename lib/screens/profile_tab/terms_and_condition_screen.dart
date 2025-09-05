// ignore_for_file: use_build_context_synchronously

import 'package:bill_sync_app/constants/color_constants.dart';
import 'package:bill_sync_app/constants/svg_constants.dart';
import 'package:bill_sync_app/customs/custom_appbar.dart';
import 'package:bill_sync_app/customs/custom_button.dart';
import 'package:bill_sync_app/customs/custom_field.dart';
import 'package:bill_sync_app/extensions/extension.dart';
import 'package:bill_sync_app/services/base_url.dart';
import 'package:bill_sync_app/services/get_request_service.dart';
import 'package:bill_sync_app/services/post_request_service.dart';
import 'package:bill_sync_app/utils/app_spaces.dart';
import 'package:bill_sync_app/utils/common_utils.dart';
import 'package:bill_sync_app/utils/text_utility.dart';
import 'package:bill_sync_app/validations/basic_validation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TermsAndConditionScreen extends ConsumerStatefulWidget {
  const TermsAndConditionScreen({super.key});

  @override
  ConsumerState<TermsAndConditionScreen> createState() =>
      _TermsAndConditionScreenState();
}

class _TermsAndConditionScreenState
    extends ConsumerState<TermsAndConditionScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _termAndConditionController =
      TextEditingController();
  bool isLoading = false;
  String? termsAndConditions;
  String? termsId;

  void _fetchTermsAndConditions() async {
    setState(() {
      isLoading = true;
    });
    final response = await GetRequestServices().getTermsAndConditions(
      context: context,
    );
    if (response != null && response.statusCode == 200) {
      final responseData = response.data['data'];
      setState(() {
        termsId = responseData['id'];
        _termAndConditionController.text =
            responseData['termsAndConditions'] ?? "";
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      Utils.errorSnackBar('Something Went Wrong', context);
    }
  }

  void _updateTermsAndConditions() async {
    final response = await PostRequestServices().updateTermsAndConditions(
      context: context,
      ref: ref,
      url: "${ServiceUrl.updateTermsAndConditionsUrl}/$termsId",
      body: {"termsAndConditions": _termAndConditionController.text},
    );
    if (response?.statusCode == 203) {
      Utils.snackBar("Terms updated successfully", context);
      _fetchTermsAndConditions();
      // context.pop();
    } else {
      Utils.errorSnackBar("Failed to update terms & conditions", context);
    }
  }

  @override
  void initState() {
    _fetchTermsAndConditions();
    super.initState();
  }

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
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 6,
                  spreadRadius: -2,
                  offset: Offset(0, 0),
                ),
              ],
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
                Form(
                  key: _formKey,
                  child: TextAreaField(
                    inputController: _termAndConditionController,
                    hintText: "Start typing...",
                    validator: (value) {
                      return validateForNormalFeild(
                        value: value,
                        props: "terms",
                      );
                    },
                  ),
                ),
                appSpaces.spaceForHeight30,
                CustomButton(
                  text: "Update",
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _updateTermsAndConditions();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
