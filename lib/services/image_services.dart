import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class ImageServices {
  ImageServices._();
  static final _picker = ImagePicker();

  static Future<File?> pickFromGallery() async {
    final status = await Permission.photos.request();
    if (!status.isGranted) return null;

    final picked = await _picker.pickImage(source: ImageSource.gallery);
    return picked != null ? File(picked.path) : null;
  }
}
