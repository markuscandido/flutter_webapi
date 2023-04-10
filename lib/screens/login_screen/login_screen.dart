import 'package:flutter/material.dart';
import 'package:flutter_webapi_first_course/screens/common/confirmation_dialog.dart';
import 'package:flutter_webapi_first_course/services/auth/exceptions/user_not_found_exception.dart';
import 'package:flutter_webapi_first_course/services/auth_service.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = 'loginScreen';

  final TextEditingController _emailController =
      TextEditingController(text: "markus.candido@gmail.com");
  final TextEditingController _passwdController =
      TextEditingController(text: "51cf12471C");

  final AuthService _authService = AuthService();

  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.all(32),
        decoration:
            BoxDecoration(border: Border.all(width: 8), color: Colors.white),
        child: Form(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Icon(
                    Icons.bookmark,
                    size: 64,
                    color: Colors.brown,
                  ),
                  const Text(
                    "MVC::Simple Journal",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const Text("por Markus Vinicius Candido",
                      style: TextStyle(fontStyle: FontStyle.italic)),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Divider(thickness: 2),
                  ),
                  const Text("Entre ou Registre-se"),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      label: Text("E-mail"),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  TextFormField(
                    controller: _passwdController,
                    decoration: const InputDecoration(label: Text("Senha")),
                    keyboardType: TextInputType.visiblePassword,
                    validator: (value) {
                      if (value == null) return null;
                      if (value.isEmpty) return "campo obrigatório";
                      if (value.length < 10) return "min 10 caracteres";
                      if (value.length > 18) return "max 18 caracteres";
                      return null;
                    },
                    maxLength: 18,
                    obscureText: true,
                  ),
                  ElevatedButton(
                      onPressed: () => _login(context),
                      child: const Text("Continuar")),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _login(BuildContext context) async {
    String email = _emailController.text;
    String password = _passwdController.text;
    try {
      await _authService.login(email: email, password: password);
    } on UserNotFoundException {
      showConfirmationDialog(
        context,
        content: "O e-mail $email não existe. Deseja cadastrar?",
      ).then(
        (value) {
          if (value != null && value) {
            _authService.register(email: email, password: password);
          }
        },
      );
    }
  }
}
