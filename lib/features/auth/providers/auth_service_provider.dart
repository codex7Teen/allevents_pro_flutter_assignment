import 'package:allevents_pro/core/config/app_router.dart';
import 'package:allevents_pro/data/services/auth_services.dart';
import 'package:allevents_pro/shared/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthServiceProvider extends ChangeNotifier {
  final AuthServices _authServices = AuthServices();

  // Loading state for Google login
  bool _isGoogleLoginLoading = false;
  bool get isGoogleLoginLoading => _isGoogleLoginLoading;

  // Current user
  User? _currentUser;
  User? get currentUser => _currentUser;

  // Google Login Method
  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      // Set loading state to true
      _isGoogleLoginLoading = true;
      notifyListeners();

      // Attempt Google login
      final UserCredential? userCredential =
          await _authServices.loginWithGoogle();

      if (userCredential != null) {
        _currentUser = userCredential.user;

        // Navigate to home screen or next page
        router.goNamed('home_screen');
      } else {
        // Show error if login failed
        CustomSnackbar.show(
          context,
          message: 'Google Sign-In failed',
          type: SnackBarType.error,
        );
      }
    } catch (e) {
      // Handle any errors
      CustomSnackbar.show(
        context,
        message: 'An error occurred: ${e.toString()}',
        type: SnackBarType.error,
      );
    } finally {
      // Set loading state to false
      _isGoogleLoginLoading = false;
      notifyListeners();
    }
  }

  // Sign out method
  Future<void> signOut() async {
    await _authServices.signOut();
    _currentUser = null;
    // Navigate back to login screen after sign out
    router.goNamed('login_screen');
    notifyListeners();
  }
}
