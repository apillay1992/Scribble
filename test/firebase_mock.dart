// test/firebase_mock.dart
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void setupFirebaseCoreMocks() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const MethodChannel channel = MethodChannel('plugins.flutter.io/firebase_core');

  channel.setMockMethodCallHandler((MethodCall methodCall) async {
    switch (methodCall.method) {
      case 'Firebase#initializeCore':
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
      case 'Firebase#initializeApp':
        return {
          'name': methodCall.arguments['appName'],
          'options': methodCall.arguments['options'],
          'pluginConstants': {},
        };
      default:
        return null;
    }
  });
}