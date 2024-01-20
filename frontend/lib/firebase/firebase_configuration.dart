import 'package:firebase_core/firebase_core.dart' show Firebase, FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frontend/domain/result.dart';

class FirebaseConfiguration {

  static Future<Result<void>> initialize() async {
    try {
      await dotenv.load(fileName: '.env');
      await Firebase.initializeApp(
        options: _currentPlatform(),
      );
      return Result.voidSuccess();
    } catch (e) {
      return Result.failure(ResultError(message: 'Firebase initialization failed: $e'));
    }
  }
  
  static FirebaseOptions _currentPlatform() {
    if (kIsWeb) {
      return _web();
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return _android();
      case TargetPlatform.iOS:
        return _ios();
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

  static FirebaseOptions _web() => FirebaseOptions(
    apiKey: _getEnvOrEmpty('LB_FRONTEND_FIREBASE_WEB_API_KEY'),
    appId: _getEnvOrEmpty('LB_FRONTEND_FIREBASE_WEB_APP_ID'),
    messagingSenderId: _getEnvOrEmpty('LB_FRONTEND_FIREBASE_MESSAGING_SENDER_ID'),
    projectId: _getEnvOrEmpty('LB_FRONTEND_FIREBASE_PROJECT_ID'),
    authDomain: _getEnvOrEmpty('LB_FRONTEND_FIREBASE_AUTH_DOMAIN'),
    storageBucket: _getEnvOrEmpty('LB_FRONTEND_FIREBASE_STORAGE_BUCKET'),
  );

  static FirebaseOptions _android() => FirebaseOptions(
    apiKey: _getEnvOrEmpty('LB_FRONTEND_FIREBASE_ANDROID_API_KEY'),
    appId: _getEnvOrEmpty('LB_FRONTEND_FIREBASE_ANDROID_APP_ID'),
    messagingSenderId: _getEnvOrEmpty('LB_FRONTEND_FIREBASE_MESSAGING_SENDER_ID'),
    projectId: _getEnvOrEmpty('LB_FRONTEND_FIREBASE_PROJECT_ID'),
    storageBucket: _getEnvOrEmpty('LB_FRONTEND_FIREBASE_STORAGE_BUCKET'),
  );

  static FirebaseOptions _ios() => FirebaseOptions(
    apiKey: _getEnvOrEmpty('LB_FRONTEND_FIREBASE_IOS_API_KEY'),
    appId: _getEnvOrEmpty('LB_FRONTEND_FIREBASE_IOS_APP_ID'),
    messagingSenderId: _getEnvOrEmpty('LB_FRONTEND_FIREBASE_MESSAGING_SENDER_ID'),
    projectId: _getEnvOrEmpty('LB_FRONTEND_FIREBASE_PROJECT_ID'),
    storageBucket: _getEnvOrEmpty('LB_FRONTEND_FIREBASE_STORAGE_BUCKET'),
    iosBundleId: _getEnvOrEmpty('LB_FRONTEND_FIREBASE_IOS_BUNDLE_ID'),
  );

  static String _getEnvOrEmpty(String key) => dotenv.env[key] ?? '';
}
