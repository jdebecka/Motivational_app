import 'package:core_values_app/ui/quotes/quotes_screen.dart';
import 'package:core_values_app/ui/screen_wrapper.dart';
import 'package:core_values_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'global_provider.dart';

void main() {
  runApp(GlobalProvider());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          iconTheme: IconThemeData(color: Colors.white),
          bottomAppBarColor: primary_green,
          brightness: Brightness.light,
          primarySwatch: Colors.green,
          appBarTheme: AppBarTheme(color: primary_green),
          accentColor: Colors.white,
          fontFamily: "Montserrat",
          focusColor: primary_green,
          backgroundColor: Colors.grey[50],
          textTheme: TextTheme(
              bodyText1: TextStyle(
                  color: Colors.grey[900],
                  fontSize: 25,
                  fontWeight: FontWeight.w600),
              caption: TextStyle(
                  fontSize: 14.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w400)),
        ),
        darkTheme: ThemeData(
          iconTheme: IconThemeData(color: primary_green),
          textTheme: TextTheme(
              bodyText1: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.w600),
              caption: TextStyle(
                  fontSize: 14.0,
                  color: primary_green,
                  fontWeight: FontWeight.w400)),
          bottomAppBarColor: Colors.grey[900],
          appBarTheme: AppBarTheme(color: Colors.grey[900]),
          brightness: Brightness.dark,
          primarySwatch: Colors.grey,
          accentColor: primary_green,
        ),
        home: ScreenWrapper());
  }
}
