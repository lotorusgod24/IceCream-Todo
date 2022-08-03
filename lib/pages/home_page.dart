import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_app/settings/color.dart';
import 'package:intl/intl.dart';

import '../models/model_task.dart';
import '../widgets/dilaog_for_data.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static final user = FirebaseAuth.instance.currentUser!;

  final streamTask = FirebaseFirestore.instance
      .collection(user.email!)
      .doc(user.uid)
      .collection('tasks')
      .snapshots();

  final taskDelete = FirebaseFirestore.instance
      .collection(user.email!)
      .doc(user.uid)
      .collection('tasks');

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

      body: StreamBuilder<QuerySnapshot>(
        stream: streamTask,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('${snapshot.error}'),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (!snapshot.hasData) {
            return const Center(child: Text('no data'));
          } else {
            var docs = snapshot.data!.docs;

            return ListView.builder(
                itemCount: docs.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      clipBehavior: Clip.antiAlias,
                      color: textFieldBackgroudColor,
                      child: ListTile(
                        title: Text('${docs[index]['taskName']}'),
                        subtitle: Text(
                          docs[index]['date']
                              .toDate()
                              .toString()
                              .substring(0, 16),
                        ),
                        trailing: IconButton(
                          onPressed: () {
                            taskDelete;
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: colorIcon,
                          ),
                        ),
                      ),
                    ),
                  );
                });
          }
        },
      ),

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

  Future<void> deleteTask(Task task) async {
    return taskDelete
        .doc(task.taskId)
        .delete()
        .then((value) => print('Task has been delete'))
        .catchError(
          (error) => print('$error'),
        );
  }
}
