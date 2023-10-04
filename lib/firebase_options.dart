// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBN-mA5RjpPDwiCUH1t8M-joepe2YBzYLY',
    appId: '1:834583424179:web:585084a91a8c1a492f94c6',
    messagingSenderId: '834583424179',
    projectId: 'mess-manager-23',
    authDomain: 'mess-manager-23.firebaseapp.com',
    storageBucket: 'mess-manager-23.appspot.com',
    measurementId: 'G-2H0WFB5LVJ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAPfStK-Lw58G0QaThU9NduZt-uCJk1zMI',
    appId: '1:834583424179:android:4586f57b36fbef202f94c6',
    messagingSenderId: '834583424179',
    projectId: 'mess-manager-23',
    storageBucket: 'mess-manager-23.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBJ5wBibZg7EACwghJX4hXxPCYAwB9a1k8',
    appId: '1:834583424179:ios:50756f0f263cadb72f94c6',
    messagingSenderId: '834583424179',
    projectId: 'mess-manager-23',
    storageBucket: 'mess-manager-23.appspot.com',
    androidClientId: '834583424179-jl981a35c6pdjlgtgrob2uoevmm1hvq2.apps.googleusercontent.com',
    iosClientId: '834583424179-afm6i5904c059rtnr618et1kgr6mkfsj.apps.googleusercontent.com',
    iosBundleId: 'com.sria.messManager',
  );
}
