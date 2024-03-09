import 'dart:convert';
import 'package:http/http.dart' as http;

class Networking {
  Future<Map<String, dynamic>> fetchData(String url) async {
    final response = await http.get(
      Uri.parse(url),
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
