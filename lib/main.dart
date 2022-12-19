import 'package:flutter/material.dart';
import 'students_list.dart';
import 'student_detail.dart';
import 'dart:async';

getfilecontent() async {
  String filecontent = await downloadfile();
  print(filecontent);
}

void main() {
  runApp(MyApp());
}

Future<String> downloadfile() {
  Future<String> content = Future.delayed(Duration(seconds: 6), () {
    return "enter";
  });
  return content;
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: "Students List",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          // يغير في كل صفحات التطبيق

          primaryColor: Colors.blue,
          buttonColor: Colors.blue,
          textTheme: TextTheme(
              headline6: TextStyle(fontSize: 20, color: Colors.white))),
      home: StudentsList(),
    );
  }
}
