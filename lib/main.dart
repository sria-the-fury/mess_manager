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
      themeMode: ThemeMode.light,
      darkTheme: ThemeData(
          inputDecorationTheme: const InputDecorationTheme(
              contentPadding:
              EdgeInsets.only(top: 15, bottom: 15),
              focusedBorder: OutlineInputBorder(
                  borderRadius:
                  BorderRadius.all(Radius.circular(25.0)),
                  borderSide: BorderSide(color: Colors.white)),
              border: OutlineInputBorder(
                  borderRadius:
                  BorderRadius.all(Radius.circular(25.0)),
                  borderSide: BorderSide.none)
          ),
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(color: Colors.white),
            backgroundColor: Colors.black,
            titleTextStyle: TextStyle(color: Colors.white, fontSize: 20)
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.black,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white38,
        ),
        colorScheme: const ColorScheme.dark(),
        useMaterial3: true
      ),
      theme: ThemeData(
        inputDecorationTheme: const InputDecorationTheme(
            contentPadding:
            EdgeInsets.only(top: 15, bottom: 15),
            focusedBorder: OutlineInputBorder(
                borderRadius:
                BorderRadius.all(Radius.circular(25.0)),
                borderSide: BorderSide(color: Colors.white)),
            border: OutlineInputBorder(
                borderRadius:
                BorderRadius.all(Radius.circular(25.0)),
                borderSide: BorderSide.none)
        ),
        appBarTheme: AppBarTheme(
            iconTheme: const IconThemeData(color: Colors.white),
            backgroundColor: Colors.teal[600],
            titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20)
        ),
        colorScheme: const ColorScheme.light(
          background: Colors.white
        ) ,
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