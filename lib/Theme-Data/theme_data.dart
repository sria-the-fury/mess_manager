import 'package:flutter/material.dart';

final lightThemeData = ThemeData(
  primaryColor: Colors.teal[600],
  elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
          textStyle: MaterialStateProperty.resolveWith(
                  (states) => const TextStyle(fontWeight: FontWeight.bold)),
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.disabled)) {
              return Colors.grey;
            }
            if (states.contains(MaterialState.hovered)) {
              return Colors.teal[800];
            }
            return Colors.teal[500];
          }),
          foregroundColor: MaterialStateProperty.resolveWith((states) {
            return Colors.white;
          }))),
  floatingActionButtonTheme:
  FloatingActionButtonThemeData(backgroundColor: Colors.teal[600]),
  inputDecorationTheme: const InputDecorationTheme(
      floatingLabelStyle: TextStyle(color: Colors.teal),
      labelStyle: TextStyle(color: Colors.black54),
      contentPadding:
      EdgeInsets.only(top: 15, bottom: 15, left: 10, right: 10),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
          borderSide: BorderSide(color: Colors.teal)),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.teal),
          borderRadius: BorderRadius.all(Radius.circular(25.0)))),
  appBarTheme: AppBarTheme(
      iconTheme: const IconThemeData(color: Colors.white),
      backgroundColor: Colors.teal[600],
      titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20)),
  colorScheme: const ColorScheme.light(background: Colors.white),
  navigationBarTheme: NavigationBarThemeData(
    indicatorColor: Colors.teal.shade600,
    backgroundColor: Colors.teal.shade100,
  ),
  useMaterial3: true,
);
final darkThemeData = ThemeData(
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            textStyle: MaterialStateProperty.resolveWith(
                    (states){
                      if(states.contains(MaterialState.disabled)){
                        return const TextStyle(fontWeight: FontWeight.bold, color: Colors.grey);
                      }
                      return const TextStyle(fontWeight: FontWeight.bold, color: Colors.white);
                    }),
            backgroundColor: MaterialStateProperty.resolveWith((states) {
              if (states.contains(MaterialState.disabled)) {
                return Colors.grey;
              }
              if (states.contains(MaterialState.hovered)) {
                return Colors.teal[600];
              }
              return Colors.teal[400];
            }),
            foregroundColor: MaterialStateProperty.resolveWith((states) {
              return Colors.white;
            }))),
    textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
            textStyle: MaterialStateProperty.resolveWith(
                    (states) => const TextStyle(fontWeight: FontWeight.bold)),
            foregroundColor: MaterialStateProperty.resolveWith((states) {
              return Colors.white;
            }))),
    inputDecorationTheme: const InputDecorationTheme(
        floatingLabelStyle: TextStyle(color: Colors.teal),
        labelStyle: TextStyle(color: Colors.white54),
        contentPadding:
        EdgeInsets.only(top: 15, bottom: 15, left: 10, right: 10),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
            borderSide: BorderSide(color: Colors.teal)),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.teal),
            borderRadius: BorderRadius.all(Radius.circular(25.0)))),
    floatingActionButtonTheme:
    FloatingActionButtonThemeData(backgroundColor: Colors.teal[400]),
    appBarTheme: const AppBarTheme(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 20)),
    navigationBarTheme:  NavigationBarThemeData(
      indicatorColor: Colors.teal.shade600,
      backgroundColor: Colors.black,
    ),
    colorScheme: const ColorScheme.dark(),
    useMaterial3: true);