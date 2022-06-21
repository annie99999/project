import 'package:flutter/material.dart';
import 'student_model.dart';
import 'db_helper.dart';

class StudentPage extends StatefulWidget {

  @override
  _StudentPageState createState() => _StudentPageState();
}

class _StudentPageState extends State<StudentPage> {
  final GlobalKey<FormState> _formStateKey = GlobalKey<FormState>();
  Future<List<Student>>? students;
  int? studentIdForUpdate;
  String?  _studentName;
  bool isUpdate = false;
  DBHelper? dbHelper;
  final _studentNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    dbHelper = DBHelper();
    refreshStudentList();
  }

  refreshStudentList() {
    setState(() {
      students = dbHelper!.getStudents();
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SQLite CRUD'),
      ),
      body: Column(
        children: <Widget>[
          Form(
            key: _formStateKey,
            autovalidateMode: AutovalidateMode.always,
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: TextFormField(
                validator: (value) => value!.isEmpty
                    ?  'Please Enter Student Name'
                    :   null,
                onSaved: (value) => _studentName = value,
                controller: _studentNameController,
                decoration: const InputDecoration(
                    labelText: "Student Name",
                    labelStyle: TextStyle(
                      color: Colors.lightGreen,
                    )),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextButton(
                style: TextButton.styleFrom(backgroundColor: Colors.lightGreen),
                child: Text(
                  (isUpdate ? 'UPDATE' : 'ADD'),
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  if (isUpdate) {
                    if (_formStateKey.currentState!.validate()) {
                      _formStateKey.currentState!.save();
                      dbHelper!
                          .update(Student(studentIdForUpdate!, _studentName!))
                          .then((data) {
                        setState(() {
                          isUpdate = false;
                        });
                      });
                    }
                  } else {
                    if (_formStateKey.currentState!.validate()) {
                      _formStateKey.currentState!.save();
                      dbHelper!.add(Student(null, _studentName!));
                    }
                  }
                  _studentNameController.text = '';
                  refreshStudentList();
                },
              ),
              const Padding(
                padding: EdgeInsets.all(10),
              ),
              TextButton(
                style: TextButton.styleFrom(backgroundColor: Colors.red),
                child: const Text(
                  ("CANCEL"),
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  _studentNameController.text = '';
                  setState(() {
                    //isUpdate = false;
                    studentIdForUpdate = null;
                  });
                },
              ),
            ],
          ),
          const Divider(
            height: 5.0,
          ),
          Expanded(
            child: FutureBuilder(
              future: students,
              builder: (context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.hasData) {
                  return generateList(snapshot.data);
                }
                if (snapshot.data == null || snapshot.data.length == 0) {
                  return Text('No Data Found');
                }
                return CircularProgressIndicator();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget generateList(List<Student>? students) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SizedBox(
        width: double.infinity,
        child: DataTable(
          columns: const [
            DataColumn(
              label: Text('NAME'),
            ),
            DataColumn(
              label: Text('DELETE'),
            )
          ],
          rows: students!.map((student) => DataRow(
            cells: [
              DataCell(
                Text(student.name!),
                onTap: () {
                  setState(() {
                    isUpdate = true;
                    studentIdForUpdate = student.id;
                  });
                  _studentNameController.text = student.name!;
                },
              ),
              DataCell(
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    dbHelper!.delete(student.id!);
                    refreshStudentList();
                  },
                ),
              )
            ],
          ),
          ).toList(),
        ),
      ),
    );
  }
}
