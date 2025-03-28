// Auth Service Provider - Manages authentication state and user sessions
// ignore_for_file: use_build_context_synchronously

import 'package:allevents_pro/core/config/app_router.dart';
import 'package:allevents_pro/data/repositories/auth_repository.dart';
import 'package:allevents_pro/shared/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthServiceProvider extends ChangeNotifier {
  final AuthRepository _authRepository =
      AuthRepository(); // Instance of authentication repository

  bool _isGoogleLoginLoading = false;
  bool get isGoogleLoginLoading => _isGoogleLoginLoading;

  User? _currentUser;
  User? get currentUser => _currentUser;

  /// Handles Google Sign-In process
  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      _isGoogleLoginLoading = true;
      notifyListeners();

      final UserCredential? userCredential =
          await _authRepository.loginWithGoogle();

      if (userCredential != null) {
        _currentUser = userCredential.user;
        CustomSnackbar.show(
          context,
          message: 'Google Sign-In success...🎉',
          type: SnackBarType.success,
          duration: Duration(seconds: 3),
        );
        router.goNamed('home_screen');
      } else {
        CustomSnackbar.show(
          context,
          message: 'Google Sign-In failed',
          type: SnackBarType.error,
        );
      }
    } catch (e) {
      CustomSnackbar.show(
        context,
        message: 'An error occurred: ${e.toString()}',
        type: SnackBarType.error,
      );
    } finally {
      _isGoogleLoginLoading = false;
      notifyListeners();
    }
  }

  /// Signs out the user and navigates to the login screen
  Future<void> signOut() async {
    await _authRepository.signOut();
    _currentUser = null;
    router.goNamed('login_screen');
    notifyListeners();
  }
}
