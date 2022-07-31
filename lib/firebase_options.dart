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
        return macos;
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
    apiKey: 'AIzaSyDKR3Om2pgnbSdpIyjG3JQS1b_bMMFUGxk',
    appId: '1:704955233349:web:b51e0bc059bbd8d766df2c',
    messagingSenderId: '704955233349',
    projectId: 'timetabling-project',
    authDomain: 'timetabling-project.firebaseapp.com',
    storageBucket: 'timetabling-project.appspot.com',
    measurementId: 'G-BBLD1EDBB0',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDMqfT83JDRlX7AvLqk63EdHwgTEM6Fc9Q',
    appId: '1:704955233349:android:11ab1e2c46d7e1d066df2c',
    messagingSenderId: '704955233349',
    projectId: 'timetabling-project',
    storageBucket: 'timetabling-project.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAXsWc2DxKuugR49SVadOe8BmoO-3YVelc',
    appId: '1:704955233349:ios:d3314591510ae60266df2c',
    messagingSenderId: '704955233349',
    projectId: 'timetabling-project',
    storageBucket: 'timetabling-project.appspot.com',
    iosClientId: '704955233349-uc5dcvagg9tsa92onvf4n3n0t59tpruj.apps.googleusercontent.com',
    iosBundleId: 'com.example.timetabling',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAXsWc2DxKuugR49SVadOe8BmoO-3YVelc',
    appId: '1:704955233349:ios:d3314591510ae60266df2c',
    messagingSenderId: '704955233349',
    projectId: 'timetabling-project',
    storageBucket: 'timetabling-project.appspot.com',
    iosClientId: '704955233349-uc5dcvagg9tsa92onvf4n3n0t59tpruj.apps.googleusercontent.com',
    iosBundleId: 'com.example.timetabling',
  );
}