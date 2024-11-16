// test/helpers/test_helper.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';

class TestHelper {
  static Future<void> setupFirebaseForTesting() async {
    TestWidgetsFlutterBinding.ensureInitialized();

    // Set up Firebase method channel mock
    const MethodChannel channel = MethodChannel('plugins.flutter.io/firebase_core');

    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
      if (methodCall.method == 'Firebase#initializeCore') {
        return [
          {
            'name': '[DEFAULT]',
            'options': {
              'apiKey': 'test-api-key',
              'appId': 'test-app-id',
              'messagingSenderId': 'test-sender-id',
              'projectId': 'test-project-id',
            },
            'pluginConstants': {},
          }
        ];
      }
      if (methodCall.method == 'Firebase#initializeApp') {
        return {
          'name': methodCall.arguments['appName'],
          'options': methodCall.arguments['options'],
          'pluginConstants': {},
        };
      }
      return null;
    });

    try {
      await Firebase.initializeApp(
        options: const FirebaseOptions(
          apiKey: 'test-api-key',
          appId: 'test-app-id',
          messagingSenderId: 'test-sender-id',
          projectId: 'test-project-id',
        ),
      );
    } catch (e) {
      // Ignore Firebase initialization errors in test
      print('Firebase initialization error in test: $e');
    }
  }
}