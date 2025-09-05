// lib/utils/image_helper.dart

import 'package:bill_sync_app/constants/app_constant.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ImageHelper {
  static final ImagePicker _picker = ImagePicker();

  static Future<File?> pickImageFromGallery() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        return File(pickedFile.path);
      }
    } catch (e) {
      AppConst.showConsoleLog('Error picking image: $e');
    }
    return null;
  }

  static Future<File?> pickImageFromCamera() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        return File(pickedFile.path);
      }
    } catch (e) {
      AppConst.showConsoleLog('Error capturing image: $e');
    }
    return null;
  }
}
