import 'dart:convert';

import 'package:http/http.dart' as http;

import '../domain/translation_data_model.dart';

class ApiService {
  Future<TranslationDataModel?> getTranslationData() async {
    const url =
        'https://my-json-server.typicode.com/ujjwaldeydeveloper/translation_data/db';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return TranslationDataModel.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>);
    }
    return null;
  }
}
