import 'package:app_marketing_version_2/view_models/authenticator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ElevatedButton(
            onPressed: () => context.read<Authenicator>().signOut(),
            child: Text('Sign Out'),
          ),
        ),
      ),
    );
  }
}
