import 'package:flutter/material.dart';
import 'package:students/student_detail.dart';
import 'dart:async';
import 'package:students/models/student.dart';
import 'package:students/utilities/sql_helper.dart';
import 'package:sqflite/sqflite.dart';

class StudentsList extends StatefulWidget {
  const StudentsList({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return StudentsState();
  }
}

class StudentsState extends State<StudentsList> {
  SQL_Helper helper = new SQL_Helper();
  List<Student>? studentsList;
  int count = 0;
  void navigate(String apptitle) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => StudentDetail(apptitle),
        ));
  }

  @override
  Widget build(BuildContext context) {
    if (studentsList == null) {
      var studentsList = <List<Student>>[];
      updateListView();
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text("Students"),
        ),
        body: getStudentsList(), //يعرف ليست اسمها جيت ستيودنت
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            navigate("Add a student");
          },
          tooltip: 'Add Student',
          child: const Icon(Icons.add),
        ));
  }

  ListView getStudentsList() {
    return ListView.builder(
        itemCount: count,
        itemBuilder: (BuildContext context, int position) {
          return Card(
            color: Colors.white,
            elevation: 2.0,
            child: ListTile(
              leading: const CircleAvatar(
                              backgroundColor: isPassed(this.studentsList[position].pass),

 child: getIcon(this.studentsList[position].pass)              ),
                         title: Text(this.studentsList[position].name),
              subtitle: Text(this.studentsList[position].description + " | " + this.studentsList[position].date),
              trailing: const Icon(
                Icons.close,
                color: Colors.grey,
              ),
              onTap: () {
                                  _delete(context, this.studentsList[position]);

              },
            ),
          );
        });
  }

  Color isPassed(int value) {
    switch (value) {
      case 1:
        return Colors.amber;
        break;
      case 2:
        return Colors.red;
        break;
      default:
        return Colors.amber;
    }
  }

  Icon getIcon(int value) {
    switch (value) {
      case 1:
        return Icon(Icons.check);
        break;
      case 2:
        return Icon(Icons.close);
        break;
      default:
        return Icon(Icons.check);
    }
  }

  void _delete(BuildContext context, Student student) async {
    int ressult = await helper.deleteStudent(student.id);
    if (ressult != 0) {
      _showSenckBar(context, "Student has been deleted");
      updateListView();
    }
  }

  void _showSenckBar(BuildContext context, String msg) {
    final snackBar = SnackBar(
      content: Text(msg),
    );
    Scaffold.of(context).showSnackBar(snackBar);
  }

  void updateListView() {
    final Future<Database> db = helper.initializedDatabase();
    db.then((database) {
      Future<List<Student>> students = helper.getStudentList();
      students.then((theList) {
        setState(() {
          this.studentsList = theList;
          this.count = theList.length;
        });
      });
    });
  }
}
