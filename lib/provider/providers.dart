import 'package:flutter/material.dart';
import 'package:simple_weather_app/data/weather.dart';

class UserLocation with ChangeNotifier {
  double _longitude = 0.0;
  double _latitude = 0.0;

  double get longitude => _longitude;
  double get latitude => _latitude;

  void setLocation(long, lati) {
    _longitude = long;
    _latitude = lati;
    notifyListeners();
  }
}

class UserAddress with ChangeNotifier {
  String _address = '위치정보를 업데이트 하세요';

  String get address => _address;

  void setAddress(address) {
    _address = address;
    notifyListeners();
  }
}

class WeatherList with ChangeNotifier {
  List<Item> _weatherList = [];

  List<Item> get weatherList => _weatherList;

  void setWeatherList(value) {
    _weatherList = value;
    notifyListeners();
  }
}
