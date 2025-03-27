import 'package:allevents_pro/data/services/auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  final AuthServices _authServices = AuthServices();

  Future<UserCredential?> loginWithGoogle() async {
    return await _authServices.loginWithGoogle();
  }

  Future<void> signOut() async {
    await _authServices.signOut();
  }
}
