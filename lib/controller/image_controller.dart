import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_app/model/image_model.dart';

// Replace with your Pexels API key
const String pexelsapiKey =
    "gBDFUYlZTPfor2kOO7P6QWhUiCbq4OgXqPizLj3ncpA2dQLtqBRznAjO";

class ImageController {
  Future<ImageModel> fetchPhotos(String query) async {
    const baseUrl = "https://api.pexels.com/v1/search";
    final url = Uri.parse("$baseUrl?query=$query town&per_page=1");
    final headers = {"Authorization": pexelsapiKey};

    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return ImageModel(image: data["photos"][0]["src"]["large2x"]);
    } else {
      throw Exception('Failed to load photos');
    }
  }
}
