import 'package:app_marketing_version_2/root_page.dart';
import 'package:app_marketing_version_2/screens/login_screen.dart';
import 'package:app_marketing_version_2/screens/main_screen.dart';
import 'package:app_marketing_version_2/screens/welcome_screen.dart';
import 'package:app_marketing_version_2/view_models/authenticator.dart';
import 'package:app_marketing_version_2/view_models/cloud_firestore.dart';
import 'package:app_marketing_version_2/view_models/obscure.dart';
import 'package:app_marketing_version_2/view_models/share_preference.dart';
import 'package:app_marketing_version_2/widgets/loading_spinkit.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      Provider<SharePreference>(
        create: (context) => SharePreference(),
      ),
      StreamProvider<User?>(
        create: (context) => context.read<Authenicator>().authStateChanges,
        initialData: null,
      ),
      Provider<CloudFirestore>(
        create: (_) => CloudFirestore(FirebaseFirestore.instance),
      ),
      ChangeNotifierProvider<Obscure>(
        create: (_) => Obscure(),
      ),
      Provider<Authenicator>(
        create: (_) => Authenicator(FirebaseAuth.instance),
      ),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.delayed(Duration(seconds: 5)),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return MaterialApp(home: SplashScreen());
          return FutureBuilder(
            future: context.read<SharePreference>().read('key'),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final user = context.read<User?>();
                if (user != null)
                  return MaterialApp(home: MainScreen());
                else
                  return MaterialApp(home: LoginScreen());
              }
              return MaterialApp(home: WelcomeScreen());
            },
          );
        });
    // return StreamBuilder<User?>(
    //   stream: context.read<Authenicator>().authStateChanges,
    //   builder: (context, snapshot) {
    //     if (snapshot.connectionState == ConnectionState.waiting) {
    //       return MaterialApp(home: SplashScreen());
    //     }

    //     if (snapshot.hasData) {
    //       return MaterialApp(
    //         home: MainScreen(),
    //       );
    //     } else
    //       return MaterialApp(
    //         home: RootPage(),
    //       );
    //   },
    // );
  }
}
