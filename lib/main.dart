import 'package:app_marketing_version_2/screens/login_screen.dart';
import 'package:app_marketing_version_2/screens/main_screen.dart';
import 'package:app_marketing_version_2/screens/signup_screen.dart';
import 'package:app_marketing_version_2/screens/test_screen.dart';
import 'package:app_marketing_version_2/screens/welcome_screen.dart';
import 'package:app_marketing_version_2/view_models/authenticator.dart';
import 'package:app_marketing_version_2/view_models/cloud_firestore.dart';
import 'package:app_marketing_version_2/view_models/obscure.dart';
import 'package:app_marketing_version_2/view_models/share_preference.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      Provider<Authenicator>(
        create: (_) => Authenicator(FirebaseAuth.instance),
      ),
      Provider<CloudFirestore>(
        create: (_) => CloudFirestore(FirebaseFirestore.instance),
      ),
      Provider<SharePreference>(
        create: (_) => SharePreference(),
      ),
      // StreamProvider<User?>(
      //   create: (context) => context.read<Authenicator>().authStateChanges,
      //   initialData: null,
      // ),
      ChangeNotifierProvider(
        create: (context) => Obscure(),
      )
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //   return FutureBuilder(
    //     future: Future.delayed(Duration(seconds: 5)),
    //     builder: (context, snapshot) {
    //       if (snapshot.connectionState == ConnectionState.waiting) {
    //       return MaterialApp(home: SplashScreen());
    //     } else {
    //       // Loading is done, return the app:
    //       return MaterialApp(
    //         home: WelcomeScreen(),
    //       );
    //     }
    //     }
    // );

    // final firebaseUser = context.watch<User?>();
    // if (firebaseUser != null) {
    //   return MaterialApp(
    //     home: MainScreen(),
    //   );
    // }
    // return MaterialApp(
    //   home: LoginScreen(),
    // );
    return MaterialApp(
      home: TestScreen(),
    );
  }
}
