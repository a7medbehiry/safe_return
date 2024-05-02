import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:safe_return/Features/auth/presentation/manager/auth_cubit/auth_cubit.dart';

class FirebaseServiceLogin {
  void signInWithGoogle(BuildContext context) async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

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

    // await GoogleLoginService(Dio()).googleLogin(
    //   email: googleUser.email,
    //   userName: googleUser.displayName,
    // );

    BlocProvider.of<AuthCubit>(context).googleLogin(
      email: googleUser.email,
      userName: googleUser.displayName,
    );

    // Once signed in, return the UserCredential
    await FirebaseAuth.instance.signInWithCredential(credential);

    // if (userCredential.user != null) {
    //   GoRouter.of(context).push('/homeView');
    // }
  }

  // void signInWithGoogle() async {
  //   // Trigger the authentication flow
  //   final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  //   // Obtain the auth details from the request
  //   final GoogleSignInAuthentication? googleAuth =
  //       await googleUser?.authentication;

  //   if (googleUser == null) {
  //     return;
  //   }

  //   // Create a new credential
  //   final credential = GoogleAuthProvider.credential(
  //     accessToken: googleAuth?.accessToken,
  //     idToken: googleAuth?.idToken,
  //   );

  //   // Once signed in, return the UserCredential
  //   // await FirebaseAuth.instance.signInWithCredential(credential);
  //   try {
  //     // Once signed in, return the UserCredential
  //     UserCredential userCredential =
  //         await FirebaseAuth.instance.signInWithCredential(credential);

  //     // Retrieve the provider data from the user credential
  //     final providerData = userCredential.user!.providerData;

  //     // Loop through the provider data to get the provider ID
  //     for (var userInfo in providerData) {
  //       print('Provider ID: ${userInfo.providerId}');
  //     }
  //   } catch (e) {
  //     print('Sign-in with Google failed: $e');
  //   }
  // }

  // Future<UserCredential> signInWithGoogle() async {
  //   // Trigger the authentication flow
  //   final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  //   // Obtain the auth details from the request
  //   final GoogleSignInAuthentication? googleAuth =
  //       await googleUser?.authentication;

  //   // Create a new credential
  //   final credential = GoogleAuthProvider.credential(
  //     accessToken: googleAuth?.accessToken,
  //     idToken: googleAuth?.idToken,
  //   );

  //   await GoogleLoginService(Dio()).googleLogin(
  //     email: googleUser!.email,
  //     userName: googleUser.displayName,
  //   );

  //   // Once signed in, return the UserCredential
  //   return await FirebaseAuth.instance.signInWithCredential(credential);
  // }

  signOut() async {
    GoogleSignIn googleLogin = GoogleSignIn();

    if (googleLogin.currentUser != null) {
      googleLogin.disconnect();
    }
  }
}
