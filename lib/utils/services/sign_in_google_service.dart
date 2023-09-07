import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignInGoogleService extends GetxService{
  SignInGoogleService._();

  static final SignInGoogleService googleService = SignInGoogleService._();

  factory SignInGoogleService() {
    return googleService;
  }
  /// login dengan Google
  Future<void> signInGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        // Pengguna membatalkan login
        return;
      }
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
      await GoogleSignIn().signOut();
    } catch(e, stack) {
      await Sentry.captureException(
        e,
        stackTrace : stack
      );
    }
  }
}