import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_app/settings/color.dart';

import '../widgets/dilaog_for_data.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,

      //appBar
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          user.email!,
          style: const TextStyle(color: activeText),
        ),
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            icon: const Icon(
              Icons.logout,
              color: activeText,
            ),
          ),
        ],
      ),

      //body: ,

      //Form For data
      floatingActionButton: FloatingActionButton(
        backgroundColor: colorIcon,
        onPressed: _showFormUsersInfo,
        child: const Icon(Icons.add_task_sharp, color: activeText),
      ),
    );
  }

  void _showFormUsersInfo() {
    showDialog(
      context: context,
      builder: (_) => const AlertDialog(
        backgroundColor: backgroundColor,
        content: AlertWidget(),
      ),
    );
  }
}
