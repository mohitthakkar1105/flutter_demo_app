import 'dart:io';

import 'package:image_picker/image_picker.dart';

class ImagePickerService {
  ImagePickerService._();

  static final ImagePickerService instance = ImagePickerService._();

  final ImagePicker _picker = ImagePicker();

  // Gallery
  Future<File?> pickFromGallery() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
    );

    if (image == null) {
      return null;
    }

    return File(image.path);
  }

  // Camera
  Future<File?> pickFromCamera() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.camera,
    );

    if (image == null) {
      return null;
    }

    return File(image.path);
  }
}