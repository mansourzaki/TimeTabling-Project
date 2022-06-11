import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/subject.dart';
import 'lecturer_tabel_screen.dart';

class LecturersScreen extends StatefulWidget {
  const LecturersScreen({Key? key}) : super(key: key);

  @override
  State<LecturersScreen> createState() => _LecturersScreenState();
}

class _LecturersScreenState extends State<LecturersScreen> {
  List<String> allNames = [];
  List<Subject> allSubjects = [];
  List<String> names = [];
  List<DataRow> rows = [];
  @override
  void initState() {
    loadSubjects();
    getAllLecturers();
    super.initState();
    setState(() {
      
    });
  }

  void getAllLecturers() {
    List<String> names = [];
    allSubjects.forEach((element) {
      names.add(element.lecturer);
    });
    names.sort((a, b) {
      return a.toLowerCase().compareTo(b.toLowerCase());
    },);

    allNames = names.toSet().toList();
  }

  Future loadSubjects() async {
    final jsonString = await rootBundle.loadString('assets/iug_output.json');
    setState(() {
      List<dynamic> subjectsList = jsonDecode(jsonString);
      allSubjects = subjectsList
          .map(
            (json) => Subject.fromJson(json),
          )
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    getAllLecturers();
    return Scaffold(
      appBar: AppBar(title: const Text('Lecturer Table')),
      body: Container(
        child: ListView.builder(
            itemCount: allNames.length,
            itemBuilder: (context, i) {
              return ListTile(
                  title: Text(allNames[i]),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return LecturereTableScreen(
                        lecturer: allNames[i],
                        allSubjects: allSubjects,
                      );
                    }));
                  });
            }),
      ),
    );
  }
}
