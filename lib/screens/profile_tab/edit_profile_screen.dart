// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:bill_sync_app/constants/svg_constants.dart';
import 'package:bill_sync_app/customs/custom_button.dart';
import 'package:bill_sync_app/services/base_url.dart';
import 'package:bill_sync_app/services/post_request_service.dart';
import 'package:bill_sync_app/utils/common_utils.dart';
import 'package:bill_sync_app/utils/formatter.dart';
import 'package:bill_sync_app/utils/text_utility.dart';
import 'package:bill_sync_app/validations/basic_validation.dart';
import 'package:flutter/material.dart';
import 'package:bill_sync_app/constants/color_constants.dart';
import 'package:bill_sync_app/constants/image_constants.dart';
import 'package:bill_sync_app/services/get_request_service.dart';
import 'package:bill_sync_app/widgets/input_label.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:bill_sync_app/customs/custom_appbar.dart';
import 'package:bill_sync_app/customs/custom_field.dart';
import 'package:bill_sync_app/extensions/extension.dart';
import 'package:bill_sync_app/utils/app_spaces.dart';

class EditProfileScreen extends ConsumerStatefulWidget {
  final Function? onRefreshProfile;
  const EditProfileScreen({super.key, this.onRefreshProfile});

  @override
  ConsumerState<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _contactNumberController =
      TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  dynamic userDetail = {};
  bool isLoading = false;
  File? selectedProfileImage;
  String? profileFromServer;

  void _getUserDetails() async {
    setState(() {
      isLoading = true;
    });
    final response = await GetRequestServices().getUserDetails(
      context: context,
    );
    if (response != null && response.statusCode == 200) {
      userDetail = response.data['data'];
      _nameController.text = userDetail["fullName"] ?? "";
      _emailController.text = userDetail["email"] ?? "";
      _contactNumberController.text =
          userDetail["contact"] != null ? userDetail["contact"].toString() : "";
      _addressController.text = userDetail["address"] ?? "";
      profileFromServer = userDetail["profilePhoto"];
    }
    setState(() {
      isLoading = false;
    });
  }

  void _updateProfile() async {
    final response = await PostRequestServices().updateProfile(
      context: context,
      ref: ref,
      body: {
        "fullName": _nameController.text,
        "address": _addressController.text,
      },
      imageMap:
          selectedProfileImage != null
              ? {"profilePhoto": selectedProfileImage}
              : {},
    );
    if (response?.statusCode == 203) {
      widget.onRefreshProfile?.call();
      Utils.snackBar("Profile updated successfully", context);
      // _getUserDetails();
      context.pop();
    } else {
      Utils.errorSnackBar("Failed to update profile", context);
    }
  }

  void _removeProfilePhoto() async {
    final response = await PostRequestServices().updateProfile(
      context: context,
      ref: ref,
      body: {},
      imageMap: {"profilePhoto": null},
    );
    if (response?.statusCode == 203) {
      Utils.snackBar("Profile photo removed.", context);
      context.pop();
    } else {
      Utils.errorSnackBar("Failed to remove profile photo", context);
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() {
        selectedProfileImage = File(pickedFile.path);
      });
    }
  }

  @override
  void initState() {
    _getUserDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        title: "Edit Profile",
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
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child:
            // isLoading
            //   ? SizedBox(
            //       height: 500,
            //       child: Center(child: Loader()),
            //     )
            //   :
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Stack(
                        children: [
                          Container(
                            height: 100,
                            width: 100,
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: AppColor.primary,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: CircleAvatar(
                              backgroundImage:
                                  selectedProfileImage != null
                                      ? FileImage(selectedProfileImage!)
                                      : profileFromServer != null
                                      ? NetworkImage(
                                        "${ServiceUrl.baseUrl}/v1/$profileFromServer",
                                      )
                                      : AssetImage(ImageConstant.menAvatar4),
                            ),
                          ),
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: GestureDetector(
                              onTap: () {
                                _pickImage();
                              },
                              child: Container(
                                padding: EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: AppColor.primary,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.camera_alt_outlined,
                                  color: AppColor.white,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                appSpaces.spaceForHeight25,
                InkWell(
                  onTap: () {
                    _removeProfilePhoto();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.delete_forever_outlined, color: Colors.red),
                      AppText(
                        text: "Remove photo",
                        textColor: Colors.red,
                        fontWeight: FontWeight.w500,
                        fontsize: 15,
                      ),
                    ],
                  ),
                ),
                appSpaces.spaceForHeight30,
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InputLabel(labelText: "Name"),
                      appSpaces.spaceForHeight5,
                      customField(
                        hintText: "Enter your name",
                        controller: _nameController,
                        filled: true,
                        // contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 13),
                        keyboardType: TextInputType.text,
                        maxLength: 30,
                        textCapitalization: TextCapitalization.words,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp(r'[a-zA-Z\s]'),
                          ),
                          CapitalizeWordsFormatter(),
                        ],
                        validator: (value) {
                          return validateForNameField(
                            value: value,
                            props: "name",
                          );
                        },
                      ),
                      appSpaces.spaceForHeight10,
                      InputLabel(labelText: "Email"),
                      appSpaces.spaceForHeight5,
                      customField(
                        hintText: "Enter your email",
                        controller: _emailController,
                        filled: true,
                        readonly: true,
                        onTap: () {
                          Utils.errorSnackBar(
                            "you can not edit email",
                            context,
                          );
                        },
                        // contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 13),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      appSpaces.spaceForHeight10,
                      InputLabel(labelText: "Contact Number"),
                      appSpaces.spaceForHeight5,
                      customField(
                        hintText: "Enter your contact no.",
                        controller: _contactNumberController,
                        filled: true,
                        readonly: true,
                        onTap: () {
                          Utils.errorSnackBar(
                            "you can not edit contact info",
                            context,
                          );
                        },
                        // contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        keyboardType: TextInputType.phone,
                      ),
                      appSpaces.spaceForHeight10,
                      InputLabel(labelText: "Address"),
                      appSpaces.spaceForHeight5,
                      customField(
                        hintText: "Enter your address",
                        controller: _addressController,
                        maxLines: 4,
                        filled: true,
                        // contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 13),
                        keyboardType: TextInputType.text,
                        maxLength: 100,
                      ),
                    ],
                  ),
                ),
                appSpaces.spaceForHeight40,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: CustomButton(
                    text: 'Update',
                    fontsize: 16,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _updateProfile();
                      }
                    },
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
