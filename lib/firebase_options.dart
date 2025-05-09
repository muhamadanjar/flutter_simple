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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBRGDa6h5upPtTcHRskrh8Aq17rEbiIL1U',
    appId: '1:448652889990:android:c160b21d15afb7302aa607',
    messagingSenderId: '448652889990',
    projectId: 'simple-56cab',
    storageBucket: 'simple-56cab.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBoJxCnth-ZC_0nM-KIUk85fXPob5zq3wg',
    appId: '1:448652889990:ios:70917e761a872a0e2aa607',
    messagingSenderId: '448652889990',
    projectId: 'simple-56cab',
    storageBucket: 'simple-56cab.firebasestorage.app',
    androidClientId: '448652889990-937k4gtbd1cnfvqjgeij2qq8gdnuefop.apps.googleusercontent.com',
    iosClientId: '448652889990-s6u6mbafo5j19r0f6fo5g7ab7nrb7nkr.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterSimple',
  );

}