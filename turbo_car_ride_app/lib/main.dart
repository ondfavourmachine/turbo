import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:turbo_car_ride_app/constants/routes.dart';
import 'package:turbo_car_ride_app/screens/login_screen.dart';
import 'package:turbo_car_ride_app/screens/main_screen.dart';
import 'package:turbo_car_ride_app/screens/registration_screen.dart';
// import 'package:turbo_car_ride_app/screens/main_screen.dart';

void main() async {
  // initialize firebase or it will throw error;
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

// set global firebase db instance

DatabaseReference userRef =
    FirebaseDatabase.instance.reference().child('users');

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Turbo Car ride app',
        theme:
            ThemeData(primarySwatch: Colors.blue, fontFamily: 'Bolt-regular'),
        debugShowCheckedModeBanner: false,
        initialRoute: LoginScreen.loginScreen,
        routes: <String, WidgetBuilder>{
          RoutesConstants.loginScreen: (context) => LoginScreen(),
          RoutesConstants.registrationScreen: (context) => RegistrationScreen(),
          RoutesConstants.mainScreen: (context) => MainScreen()
        });
  }
}
