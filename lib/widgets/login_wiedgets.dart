// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_firebase_app/settings/color.dart';
import 'package:flutter_firebase_app/main.dart';

class LoginWidget extends StatefulWidget {
  LoginWidget({Key? key}) : super(key: key);

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void dispose() {
    super.dispose();

    _passwordController.dispose();
    _emailController.dispose();
  }

  Future sigIn() async {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => Center(
        child: CircularProgressIndicator(
          color: colorIcon,
        ),
      ),
    );

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      print(e);
    }

    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.icecream,
                color: colorIcon,
                size: 100,
              ),
              SizedBox(height: 80),
              Text(
                'Hello there, Welcome in my IceCream Todo! ',
                style: TextStyle(color: activeText),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                cursorColor: activeText,
                //autofocus: true,
                controller: _emailController,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  hintText: 'Email',
                  filled: true,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: activeText),
                  ),
                  fillColor: textFieldBackgroudColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                cursorColor: activeText,
                obscureText: true,
                controller: _passwordController,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: activeText),
                  ),
                  hintText: 'Password',
                  filled: true,
                  fillColor: textFieldBackgroudColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: sigIn,
                child: Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: colorIcon,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      'Sign in',
                      style: TextStyle(color: activeText),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
