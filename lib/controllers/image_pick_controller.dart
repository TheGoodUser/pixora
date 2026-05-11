import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pixora/services/image_services.dart';

class ImagePickController extends ChangeNotifier {
  bool _loading = false;
  bool get loading => _loading;
  String get error => _error!;

  String? _error;
  bool get hasError => _error != null;

  Future<File?> pickImage() async {
    _clearError();
    _setLoading(true);

    try {
      return await ImageServices.pickFromGallery();
    } catch (e, st) {
      _setError(e: e, stacktrace: st);
      return null;
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  void _setError({dynamic e, StackTrace? stacktrace}) {
    _error = e.toString();
    log(
      "Caused error in agents_mgmt_controller",
      stackTrace: stacktrace,
      name: 'agents_remove_controller',
    );
  }

  void _clearError() {
    _error = null;
  }

  void reset() {
    _error = null;
    _loading = false;
  }
}
