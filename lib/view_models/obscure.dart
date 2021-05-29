import 'package:flutter/material.dart';

class Obscure extends ChangeNotifier {
  bool _obscureLogin = true;
  bool _obscureSigup = true;
  bool get obscureLogin => _obscureLogin;
  bool get obscureSignup => _obscureSigup;

  void changeObscureSignup() {
    _obscureSigup = !_obscureSigup;
    notifyListeners();
  }

  void changeObscureLogin() {
    _obscureLogin = !_obscureLogin;
    notifyListeners();
  }
}
