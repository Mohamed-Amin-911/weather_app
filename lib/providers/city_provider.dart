import 'package:flutter/material.dart';

class CityProvider extends ChangeNotifier {
  String _city = "cairo";
  String get getCity => _city;
  set setCity(String city) {
    _city = city;
  }
}
