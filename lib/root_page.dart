import 'package:app_marketing_version_2/screens/log_sign_screen.dart';
import 'package:app_marketing_version_2/screens/login_screen.dart';
import 'package:app_marketing_version_2/screens/signup_screen.dart';
import 'package:flutter/material.dart';

class RootPage extends StatefulWidget {
  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  bool _check = false;

  void rootPage() {
    setState(() {
      _check = !_check;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_check)
      return SignupScreen(
        toggle: rootPage,
      );
    else {
      return LoginScreen(
        toggle: rootPage,
      );
    }
  }
}
