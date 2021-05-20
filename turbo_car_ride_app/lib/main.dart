import 'package:flutter/material.dart';
import 'package:turbo_car_ride_app/screens/login_screen.dart';
// import 'package:turbo_car_ride_app/screens/main_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Turbo Car ride app',
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Bolt-regular'),
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}
