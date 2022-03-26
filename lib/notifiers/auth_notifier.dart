import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthNotifier extends ChangeNotifier {
  bool _isUserLoggedIn = false;
  bool _isLoading = false;
  bool get isUserLoggedIn => _isUserLoggedIn;
  bool get isLoading => _isLoading;

  void isUserLoggedInInit() {
    _isUserLoggedIn = FirebaseAuth.instance.currentUser != null;
  }

  Future<void> signInWithGoogle() async {
    _isLoading = true;
    notifyListeners();

    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    await FirebaseAuth.instance.signInWithCredential(credential);

    _isUserLoggedIn = true;
    _isLoading = false;
    notifyListeners();
  }

  void signOut() async {
    await GoogleSignIn().signOut();
    await FirebaseAuth.instance.signOut();
    _isUserLoggedIn = false;
    notifyListeners();
  }
}
