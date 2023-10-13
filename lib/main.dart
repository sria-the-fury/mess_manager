import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mess_manager/Widgets/Route/authenticated.dart';
import 'package:mess_manager/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mess Manager',
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ButtonStyle(
                  textStyle: MaterialStateProperty.resolveWith(
                      (states) => const TextStyle(fontWeight: FontWeight.bold)),
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
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            backgroundColor: Colors.black,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white38,
          ),
          colorScheme: const ColorScheme.dark(),
          useMaterial3: true),
      theme: ThemeData(
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
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.teal[600],
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white54,
        ),
        useMaterial3: true,
      ),
      home: const Authenticated(),
    );
  }
}
