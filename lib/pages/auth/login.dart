import 'package:employee/app/services/auth.service.dart';
import 'package:employee/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final _email = TextEditingController();
  final _password = TextEditingController();

  AuthService _authService = AuthService();

  void handleLogin() async {

    var payload = {
      "email": _email.text,
      "password": _password.text
    };

    try {
     var response = await _authService.login(payload);
      Get.off(Home());
    } catch (e) {
      Get.defaultDialog(
        content: Text(e.toString(),),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Login'),
            SizedBox(height: 20),
            TextField(
              controller: _email,
              decoration: const InputDecoration(
                labelText: 'Username',
              ),
            ),
            TextField(
              controller: _password,
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
              obscureText: true,
              keyboardType: TextInputType.visiblePassword,
            ),
            ElevatedButton(
              child: Text('Login'),
              onPressed: handleLogin,
            )
          ],
        ),
      ),
    );
  }
}
