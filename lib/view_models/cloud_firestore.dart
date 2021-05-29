import 'package:app_marketing_version_2/screens/login_screen.dart';
import 'package:app_marketing_version_2/screens/main_screen.dart';
import 'package:app_marketing_version_2/screens/success_screen.dart';
import 'package:app_marketing_version_2/view_models/authenticator.dart';
import 'package:app_marketing_version_2/widgets/dialog_custom.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CloudFirestore {
  final FirebaseFirestore _firebaseFirestore;

  CloudFirestore(this._firebaseFirestore);

  Future<void> addUser(
      {required String? id,
      required String? name,
      required String? email,
      required BuildContext context}) async {
    CollectionReference _user = _firebaseFirestore.collection('users');
    return _user
        .doc(id)
        .set({
          'full_name': name,
          'email': email,
          'createAt': DateFormat('dd/MM/yyyy - H:m:ss').format(DateTime.now())
        })
        .then((value) => print('User Add'))
        .catchError((error) => print('Failed to add user: $error'));
  }
}
