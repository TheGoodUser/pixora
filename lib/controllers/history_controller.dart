import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pixora/models/request_model.dart';
import 'package:pixora/services/api_services.dart';

class HistoryController extends ChangeNotifier {
  bool _loading = false;
  bool get loading => _loading;
  String get error => _error!;

  String? _error;
  bool get hasError => _error != null;

  List<RequestModel>? _history;

  bool get hasHistory => _history != null && _history!.isNotEmpty;

  List<RequestModel>? get history => _history;

  Future<void> refresh() async {}

  /// [getHistory] manages both network fetch and cache management
  Future<void> getHistory() async {
    _clearError();
    _setLoading(true);

    try {
      // Fetch from network
      _history = await APIService.getHistory();
    } catch (e, st) {
      _setError(e: e, stacktrace: st);
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
    _history = null;
    _error = null;
    _loading = false;
  }
}
