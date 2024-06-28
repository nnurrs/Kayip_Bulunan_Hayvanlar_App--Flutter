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
    apiKey: 'AIzaSyC9zRg3cC9k0RYVnkIZlWSJlThC3sRKtAI',
    appId: '1:672198378939:web:ef7f8be0267b4d8542b09e',
    messagingSenderId: '672198378939',
    projectId: 'kayip-bulunan-hayvanlar-app',
    authDomain: 'kayip-bulunan-hayvanlar-app.firebaseapp.com',
    storageBucket: 'kayip-bulunan-hayvanlar-app.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDaoX_Yr3LrOBo11fl0nHIKDQbKy7EM0BQ',
    appId: '1:672198378939:android:84812236c00d8cb542b09e',
    messagingSenderId: '672198378939',
    projectId: 'kayip-bulunan-hayvanlar-app',
    storageBucket: 'kayip-bulunan-hayvanlar-app.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDfkNB7s8quKraSMvw4wnLb-InnjUPuA6Q',
    appId: '1:672198378939:ios:9d2eaf745b96db9942b09e',
    messagingSenderId: '672198378939',
    projectId: 'kayip-bulunan-hayvanlar-app',
    storageBucket: 'kayip-bulunan-hayvanlar-app.appspot.com',
    androidClientId: '672198378939-k82e95vj1i4run823gkah96lc4pd2q1h.apps.googleusercontent.com',
    iosClientId: '672198378939-p4bu7r37jqm10ocabhg9fb8dea3k83lr.apps.googleusercontent.com',
    iosBundleId: 'com.example.kayipBulunanHayvanlarApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDfkNB7s8quKraSMvw4wnLb-InnjUPuA6Q',
    appId: '1:672198378939:ios:ecfd2948e7494aba42b09e',
    messagingSenderId: '672198378939',
    projectId: 'kayip-bulunan-hayvanlar-app',
    storageBucket: 'kayip-bulunan-hayvanlar-app.appspot.com',
    androidClientId: '672198378939-k82e95vj1i4run823gkah96lc4pd2q1h.apps.googleusercontent.com',
    iosClientId: '672198378939-mlqukgdvf9ceu8b4ed22k91uel9i85dc.apps.googleusercontent.com',
    iosBundleId: 'com.example.kayipBulunanHayvanlarApp.RunnerTests',
  );
}