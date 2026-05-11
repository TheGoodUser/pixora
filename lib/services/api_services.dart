import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:pixora/models/request_model.dart';

class APIService {
  APIService._();
  static const String _baseUrl = "http://localhost:8000";
  static final _client = http.Client();

  static Future<List<RequestModel>> getHistory() async {
    final res = await _client.get(Uri.parse('$_baseUrl/history'));
    if (res.statusCode == 200) {
      return (jsonDecode(res.body) as List)
          .map((requests) =>
              RequestModel.fromJson(requests as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception("An error occurred");
    }
  }

  static Future<void> uploadImage(File image) async {
    final req = http.MultipartRequest('POST', Uri.parse('$_baseUrl/upload'));

    req.files.add(await http.MultipartFile.fromPath('file', image.path));

    final res = await req.send();
    final body = await res.stream.bytesToString();
    if (res.statusCode == 200) {
      return jsonDecode(body);
    } else {
      throw Exception(body);
    }
  }
}
