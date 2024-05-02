import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth_cubit.dart';

class FirebaseServiceLogin {
  GoogleSignIn googleSignIn = GoogleSignIn();

  void signInWithGoogle(BuildContext context) async {
    // Clear previous user session
    await googleSignIn.signOut();

    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    if (googleUser == null) {
      return;
    }

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    final SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('email', googleUser.email);

    BlocProvider.of<AuthCubit>(context).googleLogin(
      email: googleUser.email,
      userName: googleUser.displayName,
    );

    // Once signed in, return the UserCredential
    await FirebaseAuth.instance.signInWithCredential(credential);
  }

  signOut() async {
    await FirebaseAuth.instance.signOut();
    await googleSignIn.disconnect();
  }
}
