import 'package:flutter/material.dart';

class Obscure extends ChangeNotifier {
  bool _suffixIcon = true;
  bool get suffixIcon => _suffixIcon;

  void changeSuffixIcon() {
    if (_suffixIcon) {
      _suffixIcon = false;
    } else
      _suffixIcon = true;
    notifyListeners();
  }
}
