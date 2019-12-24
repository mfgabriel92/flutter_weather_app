import 'package:flutter/material.dart';
import 'package:flutter_weather/screens/city_screen.dart';
import 'package:flutter_weather/services/weather.dart';

class LocationScreen extends StatefulWidget {
  final weather;

  LocationScreen({this.weather});

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  Weather weather = Weather();
  var condition;
  var temp;
  var city;
  var icon;
  var message;

  @override
  void initState() {
    super.initState();
    updateUI(widget.weather);
  }

  void updateUI(dynamic weatherData) {
    if (weatherData == null) {
      temp = 0;
      city = '';
      icon = 'Error';
      message = 'Unable to fetch data';
      return;
    }

    setState(() {
      condition = weatherData['weather'][0]['id'];
      temp = weatherData['main']['temp'].toInt();
      city = weatherData['name'];
      icon = weather.getIcon(condition);
      message = weather.getMessage(temp);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.white.withOpacity(0.8),
              BlendMode.dstATop,
            ),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () async {
                      var weatherData = await weather.getCurrentLocation();
                      updateUI(weatherData);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 30.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async {
                      var newCity = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return CityScreen();
                          },
                        ),
                      );

                      if (newCity != null) {
                        var weatherData =
                            await weather.getCurrentLocationByCity(newCity);
                        updateUI(weatherData);
                      }
                    },
                    child: Icon(
                      Icons.location_searching,
                      size: 30.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 16.0,
                ),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temp°',
                      style: TextStyle(
                        fontFamily: 'SpartanMB',
                        fontSize: 80,
                      ),
                    ),
                    Text(
                      '$icon',
                      style: TextStyle(
                        fontSize: 60,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  right: 16.0,
                ),
                child: Text(
                  '$message $city!',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontFamily: 'SpartanMB',
                    fontSize: 60,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
