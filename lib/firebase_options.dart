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
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDF0Vt_g7Vv5yFAPhZU3V0rd3q1WI6PbGk',
    appId: '1:406476839565:web:7d93f902f2f4ab9762e0c4',
    messagingSenderId: '406476839565',
    projectId: 'zehrakaya-ae4bf',
    authDomain: 'zehrakaya-ae4bf.firebaseapp.com',
    storageBucket: 'zehrakaya-ae4bf.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBUd3vp5fr2QVYOX13Gf0qoMigNx0UhsEA',
    appId: '1:406476839565:android:93ba3c8bc760552e62e0c4',
    messagingSenderId: '406476839565',
    projectId: 'zehrakaya-ae4bf',
    storageBucket: 'zehrakaya-ae4bf.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAOnBHSF02EQMCvHb96OpxZe5hlqoOyBVg',
    appId: '1:406476839565:ios:bf2e6190f7e4040562e0c4',
    messagingSenderId: '406476839565',
    projectId: 'zehrakaya-ae4bf',
    storageBucket: 'zehrakaya-ae4bf.appspot.com',
    iosClientId: '406476839565-dhlqc05ru4m6bctprsrhdsh77kn7sr91.apps.googleusercontent.com',
    iosBundleId: 'zehra',
  );
}
