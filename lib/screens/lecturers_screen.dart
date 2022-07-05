import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:timetabling/widgets/lecturer_timetable_widget.dart';

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
    setState(() {});
  }

  void getAllLecturers() {
    List<String> names = [];
    allSubjects.forEach((element) {
      names.addAll(element.lecturer);
    });
    names.sort(
      (a, b) {
        return a.toLowerCase().compareTo(b.toLowerCase());
      },
    );

    allNames = names.toSet().toList();
  }

  Future loadSubjects() async {
    //final jsonString = await rootBundle.loadString('assets/iug_output1.json');

    final response = await http.get(
      Uri.parse('http://127.0.0.1:5000/output'),
    );
    List<dynamic> subjectsJson = jsonDecode(response.body);

    Subject y = Subject.fromJson(subjectsJson[0]);

    setState(() {
      // List<dynamic> subjectsList = jsonDecode(jsonString);
      //List<dynamic> subjectsList = jsonDecode(subjectsJson);
      var x = {
        "Subject": "Introduction to computer science M",
        "Type": "P",
        "Level": "1",
        "for": ["Gm"],
        "Lecturer": ["salim jamil alyazji"],
        "Classroom": [
          "K203",
          "K204",
          "K216",
          "K403",
          "K316",
          "K217",
          "K303",
          "K304",
          "K317",
          "K404"
        ],
        "Duration": "3",
        "Capacity": 80,
        "For_Group": ["Gm 101", "Gm 102", "Gm 103", "Gm 104"],
        "Group": "101",
        "assigned_classroom": "K303",
        "assigned_time": [5, 37, 69]
      };

      allSubjects = subjectsJson
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
      appBar: AppBar(title: const Text('Classroom Screen')),
      body: ListView.builder(
          itemCount: allNames.length,
          itemBuilder: (context, i) {
            return ListTile(
                title: Text(allNames[i]),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    print('lec ${allNames[i]}');
                    return LecturersTimeTable(lecturer: allNames[i]);
                    // return LecturereTableScreen(
                    //   lecturer: allNames[i],
                    //   allSubjects: allSubjects,
                    // );
                  }));
                });
          }),
    );
  }
}
