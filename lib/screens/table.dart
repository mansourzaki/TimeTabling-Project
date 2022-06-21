import 'dart:convert';

import 'package:editable/editable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:timetabling/models/subject.dart';

import '../models/classes.dart';
import '../models/classrooms.dart';

class StudentsTable extends StatefulWidget {
  const StudentsTable({Key? key}) : super(key: key);

  @override
  State<StudentsTable> createState() => _StudentsTableState();
}

class _StudentsTableState extends State<StudentsTable> {
  List<Classes> allClasses = [];
  Classrooms? classrooms;
  List headers = [
    {'title': 'Name', 'index': 1, 'key': 'Subject'},
    {'title': 'Type', 'index': 2, 'key': 'Type'},
    {'title': 'Level', 'index': 3, 'key': 'Level'},
    {'title': 'Department', 'index': 4, 'key': 'for'},
    {'title': 'Lecturer', 'index': 4, 'key': 'Lecturer'},
    {'title': 'Group', 'index': 4, 'key': 'Group'},
    {'title': 'Classroom', 'index': 4, 'key': 'Classroom'},
    {'title': 'Duration', 'index': 4, 'key': 'Duration'},
  ];
  Future loadClasses() async {
    final jsonString = await rootBundle.loadString('assets/iug_input.json');

    var classesJson = jsonDecode(jsonString);
    classrooms = Classrooms.fromJson(classesJson['Classrooms']);
    List jsonClasses = classesJson['Classes'];
    //print(jsonClasses[0]);

    // Classes.fromJson(jsonClasses[1]);
    List<Classes> classesList =
        jsonClasses.map((json) => Classes.fromJson(json)).toList();
    allClasses = classesList;

    setState(() {});
  }

  Future<List<Classes>> getClasses() async {
    return allClasses;
  }

  @override
  void initState() {
    loadClasses();
    super.initState();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Tabel')),
        body: allClasses.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: Editable(
                  columnCount: 8,
                  columnRatio: 0.12,
                  thSize: 16,
                  showCreateButton: true,
                  tdStyle: const TextStyle(fontSize: 14),
                  tdAlignment: TextAlign.center,
                  thAlignment: TextAlign.center,
                  tdEditableMaxLines: 2,
                  columns: headers,
                  rows: [allClasses[0].toJson()],
                  showSaveIcon: true,
                  borderColor: Colors.grey.shade300,
                ),
              ));
  }

  List<dynamic> getAllRows() {
    List rows = [];
    allClasses.forEach((element) {
      rows.add(element.toJson());
    });
    return rows;
    // return filtered.map((e) => e.toJson());
  }
}
