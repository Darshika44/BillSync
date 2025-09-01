import 'dart:io';

import 'package:bill_sync_app/constants/color_constants.dart';
import 'package:bill_sync_app/constants/svg_constants.dart';
import 'package:bill_sync_app/customs/custom_appbar.dart';
import 'package:bill_sync_app/customs/custom_button.dart';
import 'package:bill_sync_app/extensions/extension.dart';
import 'package:bill_sync_app/utils/app_spaces.dart';
import 'package:bill_sync_app/utils/image_helper.dart';
import 'package:bill_sync_app/utils/text_utility.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';

class ChangeLogoScreen extends StatefulWidget {
  const ChangeLogoScreen({super.key});

  @override
  State<ChangeLogoScreen> createState() => _ChangeLogoScreenState();
}

class _ChangeLogoScreenState extends State<ChangeLogoScreen> {
  File? selectedLogoImage;

  Future<void> _changeLogoImage() async {
    File? image = await ImageHelper.pickImageFromGallery();
    if (image != null) {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: image.path,
        // aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Crop Logo',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            hideBottomControls: false,
            aspectRatioPresets: [
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.ratio4x3,
              CropAspectRatioPreset.ratio16x9,
            ],
          ),
          IOSUiSettings(
            title: 'Crop Logo',
            aspectRatioPresets: [
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.ratio4x3,
              CropAspectRatioPreset.ratio16x9,
            ],
          ),
        ],
      );

      if (croppedFile != null) {
        setState(() {
          selectedLogoImage = File(croppedFile.path);
        });
      }
    }
  }

  // Future<void> _changeProfileImage() async {
  //   File? image = await ImageHelper.pickImageFromGallery();
  //   if (image != null) {
  //     setState(() {
  //       selectedLogoImage = image;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        title: "Change Logo",
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
                  text: "Upload logo image",
                  fontsize: 15,
                  fontWeight: FontWeight.w400,
                ),
                appSpaces.spaceForHeight6,
                SizedBox(
                  height: 160,
                  child: DottedBorder(
                    options: RoundedRectDottedBorderOptions(
                      padding: EdgeInsets.all(8),
                      color: AppColor.lightGrey,
                      strokeWidth: 1.2,
                      dashPattern: const [9, 7],
                      radius: const Radius.circular(8),
                    ),
                    child: GestureDetector(
                      onTap: _changeLogoImage,
                      child: Center(
                        child:
                            selectedLogoImage != null
                                ? Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    Image.file(
                                      selectedLogoImage!,
                                      width: double.maxFinite,
                                      fit: BoxFit.fill,
                                    ),
                                    Positioned(
                                      top: -8,
                                      right: -8,
                                      child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            selectedLogoImage = null;
                                          });
                                        },
                                        child: Icon(
                                          Icons.cancel,
                                          color: Colors.red.shade400,
                                          size: 30,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                                : Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.image_outlined,
                                      size: 45,
                                      color: AppColor.lightGreyColor,
                                    ),
                                    AppText(
                                      text: "Tap to upload image",
                                      fontsize: 12,
                                      fontWeight: FontWeight.w400,
                                      textColor: AppColor.textGrey,
                                    ),
                                  ],
                                ),
                      ),
                    ),
                  ),
                ),
                appSpaces.spaceForHeight30,
                CustomButton(text: "Update", onPressed: () {}),
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}
