import 'package:bill_sync_app/constants/color_constants.dart';
import 'package:bill_sync_app/constants/svg_constants.dart';
import 'package:bill_sync_app/customs/custom_appbar.dart';
import 'package:bill_sync_app/extensions/extension.dart';
import 'package:bill_sync_app/utils/app_spaces.dart';
import 'package:bill_sync_app/utils/text_utility.dart';
import 'package:bill_sync_app/widgets/accordian_tile.dart';
import 'package:flutter/material.dart';

class FaqAndQueryScreen extends StatefulWidget {
  const FaqAndQueryScreen({super.key});

  @override
  State<FaqAndQueryScreen> createState() => _FaqAndQueryScreenState();
}

class _FaqAndQueryScreenState extends State<FaqAndQueryScreen> {
  List<Map<String, dynamic>> faqList = [
    {
      "question": "How to create an invoice?",
      "answer":
          "In the bottom navigation bar tap on the second option named 'Invoice' then click on the add button at the bottom right side, you will see a create invoice form, fill in the required details and click on 'Create Invoice' button.",
    },
    {
      "question": "How to download an invoice?",
      "answer":
          "Once you were done creating an invoice you will be navigate to list screen there you can see all your created invoices, then click on download button on invoice detail card and your invoice will be downloaded inside you system's download folder",
    },
    {
      "question": "Can I edit or delete an invoice?",
      "answer":
          "No, you can not edit or delete any invoice once you have done creating an invoice. As your invoice contain critical and useful information we have not provided any option to change or delete an invoice's data.",
    },
    {
      "question": "How to add inventory?",
      "answer":
          "In the bottom navigation bar tap on the third option named 'Inventory' then tap on any one inventory item you would like to add then you will be navigate to 'Track Inventory' screen there you will see '+ Add' button on top right corner, tap on it - a model will open, fill up the correct information and press 'Confirm' button.",
    },
    {
      "question": "Can I edit or delete any inventory?",
      "answer":
          "No, you can not edit or delete any inventory stock once you done adding, instead your stock will automatically deducted if you use any inventory while creating invoice.",
    },
    {
      "question": "Can I edit my number or email?",
      "answer":
          "No, you can not edit your mobile number or email as your account depend on both and you will not be able to login to your account",
    },
    {
      "question": "How to change logo on invoice?",
      "answer":
          "Initially you will see 'BillSync' logo on your invoice, to change it go to profile tab and tap on 'Change Logo' option, then you will be navigate to 'Change Logo' screen there you can upload your logo image from your device and then click on 'Update' button to change your logo.",
    },
    {
      "question": "How to change terms & conditions for invoice?",
      "answer":
          "Initially you will see a previously added terms and conditions on your invoice, you can change this text by going to the profile tab and tapping on the 'Terms & Conditions' option, then you will be navigated to the 'Terms & Conditions' screen where you can update the text and click on the 'Update' button to save your changes.",
    },
    {
      "question": "What is help and support?",
      "answer":
          "Help and support refers to the assistance provided to users who may have questions or issues while using the application. This can include FAQs, contact information for customer support, and resources for troubleshooting common problems.",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        title: "FAQ's and Query",
        icon: SvgConstants.arrowLeftIcon,
        showLeading: true,
        titleSpacing: 5,
        onBack: () {
          context.pop();
        },
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: faqList.length,
                  itemBuilder: (context, index) {
                    final faq = faqList[index];
                    return Column(
                      children: [
                        ExpandableAccordianTile(
                          isInitiallyExpanded: index == 0,
                          title: faq['question'],
                          childContent: _buildChildContent(
                            description: faq['answer'],
                          ),
                        ),
                        appSpaces.spaceForHeight15,
                      ],
                    );
                  },
                ),
                appSpaces.spaceForHeight15,
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildChildContent({String? description}) {
    return Column(
      children: [
        Divider(height: 0, color: Colors.white38),
        appSpaces.spaceForHeight15,
        AppText(
          text: description ?? "",
          // text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor.",
          fontsize: 14,
          fontWeight: FontWeight.w400,
          textColor: AppColor.white,
        ),
      ],
    );
  }
}


// "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. ",