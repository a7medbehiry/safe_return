import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
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
    if (googleSignIn.currentUser != null) {
      await FirebaseAuth.instance.signOut();
      await googleSignIn.disconnect();
    }
  }
}


Future<UserCredential> signInWithFacebook() async {
  // Trigger the sign-in flow
  final LoginResult loginResult = await FacebookAuth.instance.login();

  if (loginResult.status == LoginStatus.success) {
    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.tokenString);

    // Once signed in, return the UserCredential
    UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);

    // Get the user profile from Facebook Graph API
    final graphResponse = await Dio().get(
      'https://graph.facebook.com/v2.12/me',
      queryParameters: {
        'fields': 'name,email,picture',
        'access_token': loginResult.accessToken!.tokenString,
      },
    );

    final profile = json.decode(graphResponse.data);

    
    String userId = profile['id'];
    String userName = profile['name'];
    print('Facebook user ID: $userId');
    print('Facebook user name: $userName');

    return userCredential;
  } else {
    throw Exception('Failed to sign in with Facebook: ${loginResult.message}');
  }
}