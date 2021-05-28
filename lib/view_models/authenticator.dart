import 'package:app_marketing_version_2/screens/login_screen.dart';
import 'package:app_marketing_version_2/screens/success_screen.dart';
import 'package:app_marketing_version_2/view_models/cloud_firestore.dart';
import 'package:app_marketing_version_2/widgets/dialog_custom.dart';
import 'package:app_marketing_version_2/widgets/loading_spinkit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Authenicator {
  final FirebaseAuth _firebaseAuth;

  Authenicator(this._firebaseAuth);
  //Stream<User?> get authStateChanges => _firebaseAuth.idTokenChanges();

  //log out
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  //sign up
  Future<void> signUp(
      String email, String password, String name, BuildContext context) async {
    LoadingSpinkit.loadingSpinkit(context);
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      if (userCredential.user != null) {
        context.read<CloudFirestore>().addUser(
            context: context,
            id: userCredential.user!.uid,
            name: name,
            email: userCredential.user!.email);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        Navigator.of(context).pop();
        return DialogCustom.diaglogcustom(
            context, false, 'The account already exists for that email.');
      }
    } catch (e) {
      Navigator.of(context).pop();
      return DialogCustom.diaglogcustom(context, false, e.toString());
    }
  }

  //sign in
  Future signIn(String email, String password, BuildContext context) async {
    //LoadingSpinkit.loadingSpinkit(context);
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);

      //return Navigator.of(context).pop();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        //Navigator.of(context).pop();
        return DialogCustom.diaglogcustom(
            context, false, 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        //Navigator.of(context).pop();
        return DialogCustom.diaglogcustom(
            context, false, 'Wrong password provided for that user.');
      }
    }
  }

  // Future forgotPassword(String email) async {
  //   try {
  //     await _firebaseAuth.sendPasswordResetEmail(email: email);
  //   } catch (e) {}
  // }
}
