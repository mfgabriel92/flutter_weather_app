import 'dart:convert';

import 'package:flutter_weather/utils/constants.dart';
import 'package:http/http.dart' as http;

class Network {
  Future getWeatherByCoordinates(double lat, double lon) async {
    http.Response res = await http.get('$baseUrl&lat=$lat&lon=$lon');

    if (res.statusCode == 200) {
      return jsonDecode(res.body);
    } else {
      print(res.body);
    }
  }

  Future getWeatherByCity(String city) async {
    http.Response res = await http.get('$baseUrl&q=$city');

    if (res.statusCode == 200) {
      return jsonDecode(res.body);
    } else {
      print(res.body);
    }
  }
}
