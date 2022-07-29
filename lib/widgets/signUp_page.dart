import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_app/main.dart';

import '../settings/color.dart';
import '../utils/utils_registration.dart';

class SignUpPage extends StatefulWidget {
  final Function() onClickedSignIn;
  SignUpPage({Key? key, required this.onClickedSignIn}) : super(key: key);

  @override
  State<SignUpPage> createState() => SignUpPageState();
}

class SignUpPageState extends State<SignUpPage> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
  }

  Future signUp() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    showDialog(
      context: context,
      builder: (context) => Center(
        child: CircularProgressIndicator(
          color: colorIcon,
        ),
      ),
    );

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
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
                const SizedBox(height: 80),
                Text(
                  'Hello there, Welcome in my IceCream Todo! ',
                  style: TextStyle(color: activeText),
                ),
                const SizedBox(
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
                          ? 'Enter a valid email'
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
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) => value != null && value.length < 6
                      ? 'Invalid password'
                      : null,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  cursorColor: activeText,
                  obscureText: true,
                  controller: _confirmPasswordController,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    errorStyle: TextStyle(color: textFieldBackgroudColor),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: activeText),
                    ),
                    hintText: 'Confirm Password',
                    filled: true,
                    fillColor: textFieldBackgroudColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (text) =>
                      text != null && text != _passwordController.text
                          ? 'Can\'t confirm password'
                          : null,
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: signUp,
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: colorIcon,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        'Sign Up',
                        style: TextStyle(color: activeText),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                RichText(
                  text: TextSpan(
                    text: 'Already have account?',
                    style: TextStyle(color: activeText, fontSize: 16),
                    children: [
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = widget.onClickedSignIn,
                        text: ' Sign In!',
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
