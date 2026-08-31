import 'package:firebase_auth/firebase_auth.dart';

class EmailAuthService {
  EmailAuthService._();

  static final EmailAuthService instance = EmailAuthService._();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Register
  Future<UserCredential?> register({
    required String email,
    required String password,
  }) async {
    try {
      final UserCredential userCredential =
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      return userCredential;
    } on FirebaseAuthException catch (e) {
      print("Register Error: ${e.code}");
      return null;
    }
  }

  // Login
  Future<UserCredential?> login({
    required String email,
    required String password,
  }) async {
    try {
      final UserCredential userCredential =
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return userCredential;
    } on FirebaseAuthException catch (e) {
      print("Login Error: ${e.code}");
      return null;
    }
  }

  // Logout
  Future<void> logout() async {
    await _auth.signOut();
  }
}