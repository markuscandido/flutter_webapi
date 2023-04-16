import 'package:flutter/material.dart';
import 'package:flutter_webapi_first_course/helpers/share_preferences_util.dart';
import 'package:flutter_webapi_first_course/screens/common/confirmation_dialog.dart';
import 'package:flutter_webapi_first_course/screens/login_screen/login_screen.dart';

logout(BuildContext context) {
  showConfirmationDialog(
    context,
    title: "Sair",
    content: "Deseja mesmo sair?",
    affirmativeActionTitle: "Sair",
  ).then((confirm) {
    if (confirm == null || confirm == false) {
      return;
    }
    SharedPrefsUtils.setLogout();
    Navigator.pushReplacementNamed(context, LoginScreen.routeName);
  });
}
