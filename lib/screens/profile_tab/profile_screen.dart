// ignore_for_file: use_build_context_synchronously

import 'package:bill_sync_app/constants/app_constant.dart';
import 'package:bill_sync_app/constants/color_constants.dart';
import 'package:bill_sync_app/constants/image_constants.dart';
import 'package:bill_sync_app/constants/svg_constants.dart';
import 'package:bill_sync_app/screens/auth/login_screen.dart';
import 'package:bill_sync_app/screens/profile_tab/change_logo_screen.dart';
import 'package:bill_sync_app/screens/profile_tab/edit_profile_screen.dart';
import 'package:bill_sync_app/screens/profile_tab/faq_and_query_screen.dart';
import 'package:bill_sync_app/screens/profile_tab/help_and_support_screen.dart';
import 'package:bill_sync_app/screens/profile_tab/privacy_policy_screen.dart';
import 'package:bill_sync_app/screens/profile_tab/terms_and_condition_screen.dart';
import 'package:bill_sync_app/services/get_request_service.dart';
import 'package:bill_sync_app/utils/local_storage.dart';
import 'package:bill_sync_app/utils/text_utility.dart';
import 'package:bill_sync_app/widgets/accordian_tile.dart';
import 'package:bill_sync_app/widgets/logout_dialog.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bill_sync_app/customs/custom_appbar.dart';
import 'package:bill_sync_app/extensions/extension.dart';
import 'package:bill_sync_app/utils/app_spaces.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}
 dynamic userDetail = {};
 String? userName;

class _ProfileScreenState extends State<ProfileScreen> {
  void _getUserDetails() async {
    // setState(() {
    //   _isLoading = true;
    // });
    final response = await GetRequestServices().getUserDetails(
      context: context,
    );
    if (response != null && response.statusCode == 200) {
      userDetail = response.data['data'];
      userName = userDetail["fullName"] ?? "";
    }
    // setState(() {
    //   _isLoading = false;
    // });
  }

  @override
  void initState() {
    _getUserDetails();
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: "Profile"),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Container(
                        height: 100,
                        width: 100,
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColor.primary, width: 2),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: CircleAvatar(
                          backgroundImage: AssetImage(ImageConstant.menAvatar4),
                        ),
                      ),
                    ),
                  ],
                ),
                appSpaces.spaceForHeight20,
                Center(
                  child: AppText(
                    text: userName ?? "User",
                    // text: "Yashwant Soni",
                    fontsize: 19,
                    fontWeight: FontWeight.w600,
                    textColor: AppColor.textBlack,
                    fontfamily: GoogleFonts.sora().fontFamily,
                  ),
                ),
                appSpaces.spaceForHeight50,
                AccordianTile(
                  onTap: () {
                    context.push(EditProfileScreen());
                  },
                  icon: SvgConstants.editProfileIcon,
                  title: "Edit Profile",
                ),
                // appSpaces.spaceForHeight15,
                SizedBox(height: 13),
                AccordianTile(
                  onTap: () {
                    context.push(HelpAndSupportScreen());
                  },
                  icon: SvgConstants.helpAndSupportIcon,
                  title: "Help and Support",
                ),
                // appSpaces.spaceForHeight15,
                SizedBox(height: 13),
                AccordianTile(
                  onTap: () {
                    context.push(FaqAndQueryScreen());
                  },
                  icon: SvgConstants.faqIcon,
                  title: "FAQ's and Query",
                ),
                // appSpaces.spaceForHeight15,
                SizedBox(height: 13),
                AccordianTile(
                  onTap: () {
                    context.push(TermsAndConditionScreen());
                  },
                  icon: SvgConstants.faqIcon,
                  title: "Terms & Conditions",
                ),
                // appSpaces.spaceForHeight15,
                SizedBox(height: 13),
                AccordianTile(
                  onTap: () {
                    context.push(ChangeLogoScreen());
                  },
                  icon: SvgConstants.faqIcon,
                  title: "Change Logo",
                ),
                // appSpaces.spaceForHeight15,
                SizedBox(height: 13),
                AccordianTile(
                  onTap: () {
                    context.push(PrivacyPolicyScreen());
                  },
                  icon: SvgConstants.privacyPolicyIcon,
                  title: "Privacy Policy",
                ),
                SizedBox(height: 13),
                // appSpaces.spaceForHeight15,
                _buildLogoutButton(),
                appSpaces.spaceForHeight30,
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogoutButton() {
    return GestureDetector(
      onTap: () {
        showLogoutDialog(
          context,
          titleLineOne: "Are you sure you want to Logout the app?",
          onConfirmPressed: () async {
            context.pop();
            AppConst.setAccessToken(null);
            await LocalStorage.removeToken("access_token");
            context.pushReplaceAndRemoveUntil(LoginScreen());
          },
        );
      },
      child: Container(
        padding: EdgeInsets.all(17),
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Icon(Icons.logout_outlined, size: 21, color: Colors.red.shade600),
            appSpaces.spaceForWidth15,
            AppText(
              text: "Logout",
              fontsize: 15,
              fontWeight: FontWeight.w400,
              textColor: Colors.red.shade600,
            ),
          ],
        ),
      ),
    );
  }
}
