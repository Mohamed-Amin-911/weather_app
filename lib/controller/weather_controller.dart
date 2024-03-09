import 'package:weather_app/model/network_model.dart';
import 'package:weather_app/model/weather_model.dart';

const String apiKey = "80918c70755642ec99164102240903";

class WeatherController {
  Future<WeatherModel> getWeather(String cityy) async {
    String city = cityy;
    String url =
        "https://api.weatherapi.com/v1/current.json?q=${city}&key=$apiKey";
    Networking networking = Networking();
    final response = await networking.fetchData(url);
    WeatherModel weatherModel = WeatherModel(
      // humidity: response['current']['humidity'],
      temp: response['current']['temp_c'],
      conditionText: response['current']['condition']['text'],
      icon:
          "http://${response['current']['condition']['icon'].toString().substring(2)}",
      // humidity: response['current']['temp_c'],
    );
    print(response['current']['humidity']);
    return weatherModel;
  }
}
