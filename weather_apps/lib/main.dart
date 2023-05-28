import 'package:flutter/material.dart';
import 'package:weather_apps/home.dart';
import 'package:weather_apps/loading.dart';




void main(){
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: 'loading',
    routes: {
      'loading':(context)=>Loading(),
      'home':(context)=>Home(temperatureCelsius: 41,),
    },

  ));
}