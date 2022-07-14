// ignore_for_file: unnecessary_const

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/auth_controller.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  AuthController authController = Get.put(AuthController());
  bool _showText = true;
  void onTogle() {
    setState(() {
      _showText = !_showText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [Colors.pinkAccent, Colors.blue, Colors.white],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'Log In',
                    style: TextStyle(
                        color: Color(0xFFFAF8F9),
                        fontWeight: FontWeight.w500,
                        fontSize: 32),
                  )),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 60, bottom: 0),
                //padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextField(
                  obscureText: false,
                  decoration: const InputDecoration(
                      filled: true,
                      fillColor: Color(0xFFFAF8F9),
                      border: const OutlineInputBorder(),
                      // labelText: 'Email',
                      hintText: 'Email'),
                  controller: authController.usernameController,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 40, bottom: 0),
                //padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextField(
                  obscureText: _showText,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0xFFFAF8F9),
                      suffixIcon: TextButton(
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.all(16.0),
                          primary: !_showText ? Colors.grey : Colors.blue,
                          textStyle: const TextStyle(fontSize: 15),
                        ),
                        onPressed: onTogle,
                        child: Text(!_showText ? "hide" : "show"),
                      ),
                      border: const OutlineInputBorder(),
                      // labelText: 'Password',
                      hintText: 'Password'),
                  controller: authController.passwordController,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 100, bottom: 0),
                child: Container(
                  height: 50,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      )),
                    ),
                    onPressed: () {
                      authController.login();
                    },
                    child: Row(
                      children: const <Widget>[
                        Spacer(),
                        Text(
                          "Log In",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        Spacer(),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextButton(
                      child: const Text(
                        'Forgot your password?',
                        style: TextStyle(fontSize: 16),
                      ),
                      onPressed: () {},
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
