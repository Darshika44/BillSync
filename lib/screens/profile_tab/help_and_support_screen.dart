import 'package:bill_sync_app/constants/color_constants.dart';
import 'package:bill_sync_app/constants/image_constants.dart';
import 'package:bill_sync_app/constants/svg_constants.dart';
import 'package:bill_sync_app/customs/custom_appbar.dart';
import 'package:bill_sync_app/customs/custom_button.dart';
import 'package:bill_sync_app/customs/custom_field.dart';
import 'package:bill_sync_app/extensions/extension.dart';
import 'package:bill_sync_app/utils/app_spaces.dart';
import 'package:bill_sync_app/utils/text_utility.dart';
import 'package:bill_sync_app/validations/basic_validation.dart';
import 'package:bill_sync_app/widgets/input_label.dart';
import 'package:flutter/material.dart';

class HelpAndSupportScreen extends StatefulWidget {
  const HelpAndSupportScreen({super.key});

  @override
  State<HelpAndSupportScreen> createState() => _HelpAndSupportScreenState();
}

class _HelpAndSupportScreenState extends State<HelpAndSupportScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _contactNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        title: "Help and Support",
        icon: SvgConstants.arrowLeftIcon,
        showLeading: true,
        titleSpacing: 5,
        onBack: (){
          context.pop();
        }
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  ImageConstant.helpAndSupportImage, 
                  fit: BoxFit.cover, 
                  height: 330
                ),
                // appSpaces.spaceForHeight20,
                AppText(
                  text: 'How can we help you?',
                  fontsize: 24,
                  fontWeight: FontWeight.w600,
                  textColor: AppColor.textBlack,
                  // fontfamily: GoogleFonts.inter().fontFamily,
                  height: 1.5,
                ),
                AppText(
                  text: "We're always happy to help. Send us a message and we'll get back to you shortly.",
                  fontsize: 15,
                  fontWeight: FontWeight.w500,
                  textColor: AppColor.textGrey,
                  // fontfamily: GoogleFonts.inter().fontFamily,
                  textAlign: TextAlign.center,
                  height: 1.3,
                ),
                appSpaces.spaceForHeight30,
                Container(
                  padding: EdgeInsets.fromLTRB(15, 10, 15, 15),
                  // padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey.shade300),
                    // border: Border.all(color: AppColor.textGrey),
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(
                          text: 'Ask Query',
                          fontsize: 15,
                          fontWeight: FontWeight.w600,
                          textColor: AppColor.textBlack,
                          // fontfamily: GoogleFonts.inter().fontFamily,
                        ),
                        appSpaces.spaceForHeight20,
                        InputLabel(labelText: "Name"),
                        appSpaces.spaceForHeight5,
                        customField(
                          hintText: 'Enter your name',
                          controller: _nameController,
                          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                          keyboardType: TextInputType.text,
                          filled: true,
                          validator: (value) {
                            return validateForNameField(value: value, props: "name");
                          },
                        ),
                        appSpaces.spaceForHeight15,
                        InputLabel(labelText: "Email"),
                        appSpaces.spaceForHeight5,
                        customField(
                          hintText: 'Enter you email',
                          controller: _emailController,
                          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                          keyboardType: TextInputType.emailAddress,
                          filled: true,
                          validator: validateEmail,
                        ),
                        appSpaces.spaceForHeight15,
                        InputLabel(labelText: "Contact Number"),
                        appSpaces.spaceForHeight5,
                        customField(
                          hintText: 'Enter your contact no.',
                          controller: _contactNumberController,
                          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                          keyboardType: TextInputType.phone,
                          filled: true,
                          validator: validateForMobileField,
                        ),
                        appSpaces.spaceForHeight15,
                        InputLabel(labelText: "What you want to ask"),
                        appSpaces.spaceForHeight5,
                        customField(
                          hintText: 'Write here...',
                          controller: _messageController,
                          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                          keyboardType: TextInputType.phone,
                          filled: true,
                          maxLines: 3,
                          validator: validateForMobileField,
                        ),
                        appSpaces.spaceForHeight40,
                        CustomButton(
                          text: 'Submit',
                          fontsize: 16,
                          onPressed: (){ 
                            // if(_formKey.currentState!.validate()){
                            //   _signup();
                            // }
                          }
                        ),
                      ],
                    ),
                  ),
                ),
                appSpaces.spaceForHeight40,
              ],
            ),
          ),
        ),
      ),
    );
  }
}