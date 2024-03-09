import 'dart:convert';
import 'package:http/http.dart' as http;

const String pexelsapiKey =
    "gBDFUYlZTPfor2kOO7P6QWhUiCbq4OgXqPizLj3ncpA2dQLtqBRznAjO";

class ImageNetworking {
  Future<Map<String, dynamic>> fetchData(String url) async {
    final result = await http
        .get(Uri.parse(url), headers: {'Authorization': pexelsapiKey});
    if (result.statusCode == 200) {
      return jsonDecode(result.body) as Map<String, dynamic>;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
