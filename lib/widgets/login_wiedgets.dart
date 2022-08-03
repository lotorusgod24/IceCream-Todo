// ignore_for_file: prefer_const_constructors

import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_app/settings/color.dart';
import 'package:flutter_firebase_app/main.dart';
import 'package:flutter_firebase_app/utils/utils_registration.dart';

class LoginWidget extends StatefulWidget {
  final VoidCallback toogleRegAuthPage;
  const LoginWidget({Key? key, required this.toogleRegAuthPage})
      : super(key: key);

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();

    _passwordController.dispose();
    _emailController.dispose();
  }

  Future sigIn() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

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

      Utils.showSnackBar(e.message!);
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
          child: Form(
            key: formKey,
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
                  'Welcome back in my IceCream Todo! ',
                  style: TextStyle(color: activeText),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  cursorColor: activeText,
                  controller: _emailController,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    errorStyle: TextStyle(color: textFieldBackgroudColor),
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
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (email) =>
                      email != null && !EmailValidator.validate(email)
                          ? 'Email is invalid'
                          : null,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  cursorColor: activeText,
                  obscureText: true,
                  controller: _passwordController,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    errorStyle: TextStyle(color: textFieldBackgroudColor),
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
                  //autovalidateMode: AutovalidateMode.onUserInteraction,
                  //validator: (value) =>
                  //value != null ? 'Enter valid password' : null,
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
                        'Sign In',
                        style: TextStyle(color: activeText),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                RichText(
                  text: TextSpan(
                    text: 'Can\'t Sign In?',
                    style: TextStyle(color: activeText, fontSize: 16),
                    children: [
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = widget.toogleRegAuthPage,
                        text: ' Create account!',
                        style: TextStyle(
                            color: textFieldBackgroudColor, fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
