// ignore_for_file: unnecessary_null_comparison

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_app/models/model_task.dart';
import 'package:intl/intl.dart';
import '../settings/color.dart';

class AlertWidget extends StatefulWidget {
  const AlertWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<AlertWidget> createState() => _AlertWidgetState();
}

class _AlertWidgetState extends State<AlertWidget> {
  final TextEditingController _taskName = TextEditingController();
  final TextEditingController _taskDescrition = TextEditingController();

  DateTime date = DateTime.now();

  final user = FirebaseAuth.instance.currentUser!.email;
  final userId = FirebaseAuth.instance.currentUser!.uid;

  @override
  void dispose() {
    _taskDescrition.dispose();
    _taskName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextField(
              controller: _taskName,
              cursorColor: activeText,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                errorStyle: const TextStyle(color: textFieldBackgroudColor),
                hintText: 'Enter task name',
                filled: true,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: activeText),
                ),
                fillColor: textFieldBackgroudColor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _taskDescrition,
              cursorColor: activeText,
              maxLines: 5,
              decoration: InputDecoration(
                errorStyle: const TextStyle(color: textFieldBackgroudColor),
                hintText: 'Description',
                filled: true,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: activeText),
                ),
                fillColor: textFieldBackgroudColor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(colorIcon),
              ),
              onPressed: () async {
                DateTime? newDate = await showDatePicker(
                  initialEntryMode: DatePickerEntryMode.input,
                  context: context,
                  initialDate: date,
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2200),
                );
                date == null
                    ? null
                    : setState(() {
                        date = newDate!;
                      });
              },
              child: Text(
                date == DateTime.now()
                    ? 'Select final date your task'
                    : 'Selected date: ${DateFormat('dd.MM.yyyy').format(date)}',
                style: const TextStyle(color: activeText),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(colorIcon),
              ),
              onPressed: () {
                final task = Task(
                  taskName: _taskName.text,
                  date: date,
                  description: _taskDescrition.text,
                );
                createTask(
                  task,
                  user,
                );
                Navigator.pop(context);
              },
              child: const Text(
                'Add task',
                style: TextStyle(color: activeText),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future createTask(Task task, user) async {
    final docTask = FirebaseFirestore.instance
        .collection(user)
        .doc(userId)
        .collection('tasks');
    final json = task.toJson();
    await docTask.add(json);
  }
}
