// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return macos;
      case TargetPlatform.windows:
        return windows;
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
    apiKey: 'AIzaSyCD0Lr5sfZ2jCLmjlCkEln5RyZjhH5vcq0',
    appId: '1:892818427496:web:9e9b0a0f8201d03acab5dd',
    messagingSenderId: '892818427496',
    projectId: 'chologhuri-f5a49',
    authDomain: 'chologhuri-f5a49.firebaseapp.com',
    storageBucket: 'chologhuri-f5a49.appspot.com',
    measurementId: 'G-M6Z5GZ0S99',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBGaMF7kjjP2rkQGDGTHn2M5qWlm_zm_nI',
    appId: '1:892818427496:android:a48c22ea4358146ccab5dd',
    messagingSenderId: '892818427496',
    projectId: 'chologhuri-f5a49',
    storageBucket: 'chologhuri-f5a49.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC0h_KxRD3ebZmFPyLRULIQDK7S0cYufaM',
    appId: '1:892818427496:ios:43e083b5d5e9c2aecab5dd',
    messagingSenderId: '892818427496',
    projectId: 'chologhuri-f5a49',
    storageBucket: 'chologhuri-f5a49.appspot.com',
    iosBundleId: 'com.example.rideApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC0h_KxRD3ebZmFPyLRULIQDK7S0cYufaM',
    appId: '1:892818427496:ios:43e083b5d5e9c2aecab5dd',
    messagingSenderId: '892818427496',
    projectId: 'chologhuri-f5a49',
    storageBucket: 'chologhuri-f5a49.appspot.com',
    iosBundleId: 'com.example.rideApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCD0Lr5sfZ2jCLmjlCkEln5RyZjhH5vcq0',
    appId: '1:892818427496:web:9e6f3ca4d97725e1cab5dd',
    messagingSenderId: '892818427496',
    projectId: 'chologhuri-f5a49',
    authDomain: 'chologhuri-f5a49.firebaseapp.com',
    storageBucket: 'chologhuri-f5a49.appspot.com',
    measurementId: 'G-PN04TKPTWN',
  );
}
