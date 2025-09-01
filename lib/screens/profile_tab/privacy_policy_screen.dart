import 'package:bill_sync_app/constants/color_constants.dart';
import 'package:bill_sync_app/constants/svg_constants.dart';
import 'package:bill_sync_app/customs/custom_appbar.dart';
import 'package:bill_sync_app/extensions/extension.dart';
import 'package:bill_sync_app/utils/app_spaces.dart';
import 'package:bill_sync_app/utils/text_utility.dart';
import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        title: "Privacy Policy",
        icon: SvgConstants.arrowLeftIcon,
        showLeading: true,
        titleSpacing: 5,
        onBack: () {
          context.pop();
        },
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(
              text: 'Privacy Policy',
              fontsize: 24,
              fontWeight: FontWeight.bold,
              textColor: AppColor.secondary,
            ),
            appSpaces.spaceForHeight15,
            AppText(
              text:
                  'This Privacy Policy describes how BillSync ("we", "our", or "us") collects, uses, and protects your information when you use our mobile application to generate digital invoices and manage jewellery inventory.',
              fontsize: 15,
              textColor: AppColor.textGrey,
            ),
            appSpaces.spaceForHeight25,
            AppText(
              text: '1. Information We Collect',
              fontsize: 18,
              fontWeight: FontWeight.bold,
              textColor: AppColor.secondary,
            ),
            appSpaces.spaceForHeight8,
            AppText(
              text:
                  '- User name, email, phone number, address\n'
                  '- Customer and business information for invoices\n'
                  '- Jewellery inventory details (e.g., pearls, rubies, emeralds, diamonds)\n'
                  '- Device and app usage data (for analytics, if enabled)',
              fontsize: 15,
              textColor: AppColor.textGrey,
            ),
            appSpaces.spaceForHeight25,
            AppText(
              text: '2. How We Use Your Information',
              fontsize: 18,
              fontWeight: FontWeight.bold,
              textColor: AppColor.secondary,
            ),
            appSpaces.spaceForHeight8,
            AppText(
              text:
                  'We use your data to:\n'
                  '- Generate and manage invoices\n'
                  '- Maintain jewellery inventory records\n'
                  '- Provide customer support\n'
                  '- Improve our application and fix issues',
              fontsize: 15,
              textColor: AppColor.textGrey,
            ),
            appSpaces.spaceForHeight25,
            AppText(
              text: '3. Data Sharing',
              fontsize: 18,
              fontWeight: FontWeight.bold,
              textColor: AppColor.secondary,
            ),
            appSpaces.spaceForHeight8,
            AppText(
              text:
                  'We do not sell or share your personal data with third parties, except as required by law or to operate our app functionalities.',
              fontsize: 15,
              textColor: AppColor.textGrey,
            ),
            appSpaces.spaceForHeight25,
            AppText(
              text: '4. Data Security',
              fontsize: 18,
              fontWeight: FontWeight.bold,
              textColor: AppColor.secondary,
            ),
            appSpaces.spaceForHeight8,
            AppText(
              text:
                  'We implement industry-standard security measures to protect your information, including encryption and secure servers.',
              fontsize: 15,
              textColor: AppColor.textGrey,
            ),
            appSpaces.spaceForHeight25,
            AppText(
              text: '5. Your Rights',
              fontsize: 18,
              fontWeight: FontWeight.bold,
              textColor: AppColor.secondary,
            ),
            appSpaces.spaceForHeight8,
            AppText(
              text:
                  'You have the right to view, update, or request deletion of your personal information. Please contact us for any requests.',
              fontsize: 15,
              textColor: AppColor.textGrey,
            ),
            appSpaces.spaceForHeight25,
            AppText(
              text: '6. Data Retention',
              fontsize: 18,
              fontWeight: FontWeight.bold,
              textColor: AppColor.secondary,
            ),
            appSpaces.spaceForHeight8,
            AppText(
              text:
                  'We retain your information as long as necessary to provide our services or as required by applicable laws.',
              fontsize: 15,
              textColor: AppColor.textGrey,
            ),
            appSpaces.spaceForHeight25,
            AppText(
              text: '7. Children\'s Privacy',
              fontsize: 18,
              fontWeight: FontWeight.bold,
              textColor: AppColor.secondary,
            ),
            appSpaces.spaceForHeight8,
            AppText(
              text:
                  'Our services are not intended for children under the age of 13. We do not knowingly collect personal information from children.',
              fontsize: 15,
              textColor: AppColor.textGrey,
            ),
            appSpaces.spaceForHeight25,
            AppText(
              text: '8. Changes to This Policy',
              fontsize: 18,
              fontWeight: FontWeight.bold,
              textColor: AppColor.secondary,
            ),
            appSpaces.spaceForHeight8,
            AppText(
              text:
                  'We may update this Privacy Policy from time to time. Any changes will be communicated via the app or email.',
              fontsize: 15,
              textColor: AppColor.textGrey,
            ),
            appSpaces.spaceForHeight25,
            AppText(
              text: '9. Contact Us',
              fontsize: 18,
              fontWeight: FontWeight.bold,
              textColor: AppColor.secondary,
            ),
            appSpaces.spaceForHeight8,
            AppText(
              text:
                  'If you have any questions or concerns about this Privacy Policy, please contact us at: support@yourapp.com',
              fontsize: 15,
              textColor: AppColor.textGrey,
            ),
            appSpaces.spaceForHeight40,
          ],
        ),
      ),
    );
  }
}
