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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyBdheU166QDql8-qfvDlR6B8IXEZcpsuOQ',
    appId: '1:381373100918:web:6ba799f543c405e7094057',
    messagingSenderId: '381373100918',
    projectId: 'sales-app-1cc5b',
    authDomain: 'sales-app-1cc5b.firebaseapp.com',
    storageBucket: 'sales-app-1cc5b.firebasestorage.app',
    measurementId: 'G-PM61PP15M7',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBw-QZ4FgZk3W7CTDK6ztWeH6rdsy8-ZGg',
    appId: '1:381373100918:android:85e4f8100daaba25094057',
    messagingSenderId: '381373100918',
    projectId: 'sales-app-1cc5b',
    storageBucket: 'sales-app-1cc5b.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDRt-66Dwok61Kl0UjIhYUDV42EEhpPoBg',
    appId: '1:381373100918:ios:e3e310b9eb28e1cc094057',
    messagingSenderId: '381373100918',
    projectId: 'sales-app-1cc5b',
    storageBucket: 'sales-app-1cc5b.firebasestorage.app',
    iosBundleId: 'com.example.salesApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBdheU166QDql8-qfvDlR6B8IXEZcpsuOQ',
    appId: '1:381373100918:web:ceb31b14b9cb9cc2094057',
    messagingSenderId: '381373100918',
    projectId: 'sales-app-1cc5b',
    authDomain: 'sales-app-1cc5b.firebaseapp.com',
    storageBucket: 'sales-app-1cc5b.firebasestorage.app',
    measurementId: 'G-EN39BLTL8N',
  );
}
