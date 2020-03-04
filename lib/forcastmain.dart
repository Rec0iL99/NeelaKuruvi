import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Weather.dart';
import 'WeatherItem.dart';
import 'WeatherData.dart';
import 'ForecastData.dart';

class ForecastScreen extends StatefulWidget {
  static const String id = "ForecastScreen";

  @override
  _ForecastScreenState createState() => _ForecastScreenState();
}

class _ForecastScreenState extends State<ForecastScreen> {
  bool isLoading = false;
  WeatherData weatherData;
  ForecastData forecastData;

  @override
  void initState() {
    super.initState();

    loadWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(
        title: Text('Weather Forecast'),
        elevation: 0.0,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: weatherData != null
                        ? Weather(weather: weatherData)
                        : Container(),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: isLoading
                        ? CircularProgressIndicator(
                      strokeWidth: 2.0,
                      valueColor:
                      new AlwaysStoppedAnimation(Colors.white),
                    )
                        : IconButton(
                      icon: new Icon(Icons.refresh),
                      tooltip: 'Refresh',
                      onPressed: loadWeather,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 200.0,
                  child: forecastData != null
                      ? ListView.builder(
                      itemCount: forecastData.list.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => WeatherItem(
                          weather: forecastData.list.elementAt(index)))
                      : Container(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  loadWeather() async {
    setState(() {
      isLoading = true;
    });

    final lat = 11.0168;
    final lon = 76.9558;
    final weatherResponse = await http.get(
        'https://api.openweathermap.org/data/2.5/weather?APPID=4d39a8f26b36f08935eb398ffdfcb94b&lat=${lat.toString()}&lon=${lon.toString()}');
    final forecastResponse = await http.get(
        'https://api.openweathermap.org/data/2.5/forecast?APPID=4d39a8f26b36f08935eb398ffdfcb94b&lat=${lat.toString()}&lon=${lon.toString()}');

    if (weatherResponse.statusCode == 200 &&
        forecastResponse.statusCode == 200) {
      return setState(() {
        weatherData =
            new WeatherData.fromJson(jsonDecode(weatherResponse.body));
        forecastData =
            new ForecastData.fromJson(jsonDecode(forecastResponse.body));
        isLoading = false;
      });
    }

    setState(() {
      isLoading = false;
    });
  }
}
