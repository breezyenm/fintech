import 'package:flutter/material.dart';

class SettingsData extends ChangeNotifier {
  TextEditingController currentPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  TextEditingController code = TextEditingController();

  clear() {
    confirmPassword.clear();
    currentPassword.clear();
    newPassword.clear();
    code.clear();
  }
}
