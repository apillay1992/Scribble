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
    apiKey: 'AIzaSyCC-H3IXRgNIYidSuzm15Z8idiRVc6rpDc',
    appId: '1:88179746201:web:22c7dc90305c5d768e1f08',
    messagingSenderId: '88179746201',
    projectId: 'notes-app-4ac96',
    authDomain: 'notes-app-4ac96.firebaseapp.com',
    storageBucket: 'notes-app-4ac96.firebasestorage.app',
    measurementId: 'G-ZTV0B5R53H',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDfpjgZ6JJ3d7_8JXZiTqWe0JCHqsYOtxo',
    appId: '1:88179746201:android:d22290148ba8c4d28e1f08',
    messagingSenderId: '88179746201',
    projectId: 'notes-app-4ac96',
    storageBucket: 'notes-app-4ac96.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAM-bVp9CEOh273hqXqgJddsaEpvL6n2SQ',
    appId: '1:88179746201:ios:909185249a694ae08e1f08',
    messagingSenderId: '88179746201',
    projectId: 'notes-app-4ac96',
    storageBucket: 'notes-app-4ac96.firebasestorage.app',
    iosBundleId: 'com.example.wtcNotesAppExercise',
  );
}
