import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weather_apps/Repo.dart';



class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  double? temp;
  double? tempMin;
  double? tempMax;
  int? humidity;
  double? speed;
  int? all;
  String? country;
  String? city;
  String? description;
  String? icon;
  String? main;
  bool isLoading = true;

  void startApp(String? city) async {
    Repo instance = Repo();
    await instance.getWeather(city);
    temp = instance.temp;
    humidity = instance.humidity;
    tempMax = instance.tempMax;
    tempMin = instance.tempMin;
    speed = instance.speed;
    all = instance.all;
    country = instance.country;
    main = instance.main;
    icon = instance.icon;
    description = instance.description;

    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(
        context,
        'home',
        arguments: {
          'temperatureCelsius': temp,
          'humidity': humidity,
          'speed': speed,
          'temperatureMax': tempMax,
          'temperatureMin': tempMin,
          'clouds': all,
          'country': country,
          'description': description,
          'main': main,
          'icon': icon,
        },
      );
    });
  }

  @override
  void initState() {
    startApp(city);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Map? info = ModalRoute.of(context)?.settings.arguments as Map?;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              "images/mlogo.png",
              height: 240,
              width: 240,
            ),
            Text(
              "Weather App",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w900,
                color: Colors.black,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Made By Muhammad Amanat",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w900,
                color: Colors.black,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            SpinKitWave(
              color: Colors.red,
              size: 50.0,
            ),
          ],
        ),
      ),
      backgroundColor: Colors.blue[300],
    );
  }
}
