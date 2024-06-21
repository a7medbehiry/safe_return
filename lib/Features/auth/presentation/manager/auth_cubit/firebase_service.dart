import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth_cubit.dart';

class FirebaseGoogleServiceLogin {
  GoogleSignIn googleSignIn = GoogleSignIn();

  void signInWithGoogle(BuildContext context) async {
    // Clear previous user session
    await googleSignIn.signOut();

    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Check if user canceled the login
    if (googleUser == null) {
      return;
    }

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Obtain shared preferences and store the email
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('email', googleUser.email);

    // Sign in to Firebase with the credential
    await FirebaseAuth.instance.signInWithCredential(credential);

    // Ensure that the context is still valid before using it
    if (!context.mounted) {
      return;
    }

    // Perform context-dependent operations
    BlocProvider.of<AuthCubit>(context).googleLogin(
      email: googleUser.email,
      userName: googleUser.displayName,
    );
  }

  Future<void> signOut() async {
    if (googleSignIn.currentUser != null) {
      await FirebaseAuth.instance.signOut();
      await googleSignIn.disconnect();
    }
  }
}

class FirebaseFaceBookServiceLogin {
  Future<UserCredential?> signInWithFacebook(BuildContext context) async {
    // Log out from Facebook and Firebase to clear cached credentials
    await signOut();

    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    // Check the status of the login result
    if (loginResult.status == LoginStatus.success) {
      // Create a credential from the access token
      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.tokenString);

      // Once signed in, return the UserCredential
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithCredential(facebookAuthCredential);

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
      log('Facebook user ID: $userId');
      log('Facebook user name: $userName');

      // Obtain shared preferences and store the email
      final SharedPreferences preferences =
          await SharedPreferences.getInstance();
      preferences.setString('id', userId);

      // Ensure that the context is still valid before using it
      if (!context.mounted) {
        return null;
      }

      // Perform context-dependent operations
      BlocProvider.of<AuthCubit>(context).facebookLogin(
        accountId: userId,
        userName: userName,
      );

      return userCredential;
    } else {
      return null;
    }
  }

  Future<void> signOut() async {
    // Sign out from Firebase
    await FirebaseAuth.instance.signOut();
    // Sign out from Facebook
    await FacebookAuth.instance.logOut();
  }
}
