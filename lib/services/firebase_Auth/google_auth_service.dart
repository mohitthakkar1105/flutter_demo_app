import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthService {
  GoogleAuthService._();

  static final GoogleAuthService instance = GoogleAuthService._();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  Future<UserCredential?> signInWithGoogle() async {
    try {
      // Initialize Google Sign-In
      await _googleSignIn.initialize();

      // Open Google account picker
      final GoogleSignInAccount googleUser = await _googleSignIn.authenticate();

      // Get Google authentication details
      final GoogleSignInAuthentication googleAuth = googleUser.authentication;

      // Create Firebase credential
      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase
      final UserCredential userCredential = await _auth.signInWithCredential(
        credential,
      );

      return userCredential;
    } catch (e) {
      print("Google Sign-In Error: $e");
      return null;
    }
  }
}

// useage:->
// ElevatedButton(
// onPressed: () async {
// final userCredential = await GoogleAuthService.instance
//     .signInWithGoogle();
//
// final String? idToken = await userCredential?.user
//     ?.getIdToken();
//
// print(idToken);
//
// if (userCredential != null) {
// print("Login Success");
// print(userCredential.user?.uid);
// print(userCredential.user?.displayName);
// print(
// userCredential.user?.displayName,
// );
// print(
// userCredential.user?.email,
// );
// print(
// "  id token hai ye backend me dena ke liye :-> $idToken",
// );
// }
// },
// child: const Text("Continue with Google"),
// ),
