import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mess_manager/Theme-Data/theme_data.dart';
import 'package:mess_manager/Widgets/Route/authenticated.dart';
import 'package:mess_manager/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
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

    themeMode() {
      final themBox = GetStorage();
      final themeMode = themBox.read('themeMode');
      if(themeMode == null ){
        themBox.write('themeMode', 'LIGHT');
        return themeMode;
      }
      return themeMode;
    }



    return GetMaterialApp(
      title: 'Mess Manager',
      themeMode: themeMode() == 'SYSTEM' ? ThemeMode.system : themeMode() == 'DARK' ? ThemeMode.dark : ThemeMode.light,
      darkTheme: darkThemeData,
      theme: lightThemeData,
      home: const Authenticated(),
    );
  }
}
