import 'package:flutter_weather/services/location.dart';
import 'package:flutter_weather/services/networking.dart';

class Weather {
  String getIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time in ';
    } else if (temp > 20) {
      return 'Time for shorts and 👕 in ';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤 in ';
    } else {
      return 'Bring a 🧥 just in case in ';
    }
  }

  Future<dynamic> getCurrentLocation() async {
    Location location = Location();
    await location.getCurrentLocation();

    Network network = Network();

    return await network.getWeatherByCoordinates(
        location.latitude, location.longitude);
  }

  Future<dynamic> getCurrentLocationByCity(String city) async {
    Location location = Location();
    await location.getCurrentLocation();

    Network network = Network();

    return await network.getWeatherByCity(city);
  }
}
