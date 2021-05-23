import 'package:flutter/material.dart';
import 'location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:clima/services/weather.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double latitude;
  double longitude;

  void getLocationData() async {
    WeatherModel weathermodel = WeatherModel();
    try {
      var weatherData = await weathermodel
          .getLocationWeather()
          .timeout(const Duration(seconds: 7));
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return LocationScreen(locationWeather: weatherData);
      }));
    } catch (e) {
      print(e);
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return LocationScreen(locationWeather: null);
      }));
    }
  }

  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(color: Colors.white, size: 100),
      ),
    );
  }
}
