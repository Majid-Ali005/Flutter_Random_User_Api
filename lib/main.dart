


import 'package:flutter/material.dart';
import 'package:flutter_app/screens/home_page.dart';
import 'package:flutter_app/screens/weather_api.dart';

void main()
{
 runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      // ye home page ko call krne k liye
      // home: WeatherApiPage(), this is for weather api
    );
  }
}