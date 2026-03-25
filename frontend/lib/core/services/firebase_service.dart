import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import '../../firebase_options.dart';

class FirebaseService {
  static bool _isInitialized = false;

  static Future<void> initializeFirebase() async {
    if (_isInitialized) {
      if (kDebugMode) {
        print('Firebase already initialized');
      }
      return;
    }

    try {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      _isInitialized = true;
      if (kDebugMode) {
        print('Firebase initialized successfully');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Firebase initialization failed: $e');
      }
      rethrow;
    }
  }

  static bool get isInitialized => _isInitialized;
}
