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
    apiKey: 'AIzaSyB41wPvLSaW4hcTXp8APSbelFE2UEJVKO0',
    appId: '1:640666311692:web:0635ff1c659e964e522229',
    messagingSenderId: '640666311692',
    projectId: 'emailandphoneauth-6ab6d',
    authDomain: 'emailandphoneauth-6ab6d.firebaseapp.com',
    storageBucket: 'emailandphoneauth-6ab6d.appspot.com',
    measurementId: 'G-EQXV7QXLLV',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBMJCGAaywbclRT5WUXEDqoe5x-k-BL_c8',
    appId: '1:640666311692:android:d7f53edcbac49e89522229',
    messagingSenderId: '640666311692',
    projectId: 'emailandphoneauth-6ab6d',
    storageBucket: 'emailandphoneauth-6ab6d.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBfA5vDOPfayjN4W0ZsaFPAoh3YpDyFmGI',
    appId: '1:640666311692:ios:3eec2bb69b3705a3522229',
    messagingSenderId: '640666311692',
    projectId: 'emailandphoneauth-6ab6d',
    storageBucket: 'emailandphoneauth-6ab6d.appspot.com',
    androidClientId: '640666311692-rvia0opcert2t42tsdg59l31lqmv1g06.apps.googleusercontent.com',
    iosClientId: '640666311692-utar57hrq1npiucd5ot3ku151nlkmm16.apps.googleusercontent.com',
    iosBundleId: 'com.example.ezFlutter',
  );
}