import 'dart:io';

import 'package:flutter/material.dart';

class ImagePreviewController extends ChangeNotifier {
  File? _image;
  bool get hasImage => _image != null;
  File get image => _image!;

  void updateImage(File image) {
    _image = image;
    notifyListeners();
  }

  void removeImage() {
    _image = null;
    notifyListeners();
  }
}
