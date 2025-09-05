// ignore_for_file: use_build_context_synchronously
import 'dart:io';

import 'package:bill_sync_app/constants/color_constants.dart';
import 'package:bill_sync_app/constants/svg_constants.dart';
import 'package:bill_sync_app/customs/custom_appbar.dart';
import 'package:bill_sync_app/customs/custom_button.dart';
import 'package:bill_sync_app/extensions/extension.dart';
import 'package:bill_sync_app/services/base_url.dart';
import 'package:bill_sync_app/services/get_request_service.dart';
import 'package:bill_sync_app/services/post_request_service.dart';
import 'package:bill_sync_app/utils/app_spaces.dart';
import 'package:bill_sync_app/utils/common_utils.dart';
import 'package:bill_sync_app/utils/image_helper.dart';
import 'package:bill_sync_app/utils/text_utility.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:image_cropper/image_cropper.dart';

class ChangeLogoScreen extends ConsumerStatefulWidget {
  const ChangeLogoScreen({super.key});

  @override
  ConsumerState<ChangeLogoScreen> createState() => _ChangeLogoScreenState();
}

class _ChangeLogoScreenState extends ConsumerState<ChangeLogoScreen> {
  File? selectedLogoImage;
  bool isLoading = false;
  String? logoId;
  String? logoImageUrl;

  Future<void> _changeLogoImage() async {
    File? image = await ImageHelper.pickImageFromGallery();
    if (image != null) {
      setState(() {
        selectedLogoImage = image;
      });
    }
  }

  void _fetchLogo() async {
    setState(() {
      isLoading = true;
    });
    final response = await GetRequestServices().getLogo(context: context);
    if (response != null && response.statusCode == 200) {
      if (response.data['data'] != null) {
        final responseData = response.data['data'];
        setState(() {
          logoId = responseData['id'];
          logoImageUrl = responseData['logo'];
          isLoading = false;
        });
      }
    } else {
      setState(() {
        isLoading = false;
      });
      Utils.errorSnackBar('Something Went Wrong', context);
    }
  }

  void _updateLogoImage() async {
    final response = await PostRequestServices().updateLogo(
      context: context,
      ref: ref,
      url: ServiceUrl.createLogoUrl,
      // url: "${ServiceUrl.createLogoUrl}/$logoId",
      imageMap: selectedLogoImage != null ? {"logo": selectedLogoImage} : {},
    );
    if (response?.statusCode == 201 || response?.statusCode == 203) {
      Utils.snackBar("Logo image updated successfully", context);
      setState(() {
        selectedLogoImage = null;
      });
      _fetchLogo();
    } else {
      Utils.errorSnackBar("Failed to update logo image", context);
    }
  }

  @override
  void initState() {
    _fetchLogo();
    super.initState();
  }

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
                                      fit: BoxFit.cover,
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
                                : logoImageUrl != null
                                ? Image.network(
                                  "${ServiceUrl.baseUrl}/v1/$logoImageUrl",
                                  width: double.maxFinite,
                                  fit: BoxFit.cover,
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
                CustomButton(
                  text: "Change",
                  onPressed: () {
                    _updateLogoImage();
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
