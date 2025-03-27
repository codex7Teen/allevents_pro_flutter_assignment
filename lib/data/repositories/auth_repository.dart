// Auth Repository - Handles authentication logic
import 'package:allevents_pro/data/services/auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  final AuthServices _authServices =
      AuthServices(); // Instance of authentication service

  /// Logs in the user via Google authentication
  Future<UserCredential?> loginWithGoogle() async {
    return await _authServices.loginWithGoogle();
  }

  /// Signs out the current user
  Future<void> signOut() async {
    await _authServices.signOut();
  }
}
