import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_app/pages/auth_page.dart';
import 'package:flutter_firebase_app/settings/color.dart';
import 'package:flutter_firebase_app/widgets/login_wiedgets.dart';

import 'HomePage.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              color: colorIcon,
            ),
          );
        } else if (snapshot.hasError) {
          return const Text('error');
        } else if (snapshot.hasData) {
          return HomePage();
        } else {
          return AuthPage();
        }
      },
    );
  }
}
