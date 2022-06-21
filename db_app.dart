import 'package:flutter/material.dart';
import 'db_home.dart';

void main() => runApp(StudentRegApp());

class StudentRegApp extends StatelessWidget {
// This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'DB APP',
        home: StudentPage()
    );
  }
}
