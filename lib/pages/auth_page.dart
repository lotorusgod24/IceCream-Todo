import 'package:flutter/material.dart';
import 'package:flutter_firebase_app/widgets/login_wiedgets.dart';

import '../widgets/signUp_page.dart';

class AuthPage extends StatefulWidget {
  AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin = true;

  @override
  Widget build(BuildContext context) {
    return isLogin
        ? LoginWidget(toogleRegAuthPage: toggle)
        : SignUpPage(onClickedSignIn: toggle);
  }

  void toggle() {
    setState(() {
      isLogin = !isLogin;
    });
  }
}
