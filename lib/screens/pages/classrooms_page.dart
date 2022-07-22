import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../models/subject.dart';
import '../../widgets/classroom_timetable_widget.dart';

class ClassroomsPage extends StatefulWidget {
  const ClassroomsPage({Key? key}) : super(key: key);

  @override
  State<ClassroomsPage> createState() => _ClassroomsPageState();
}

class _ClassroomsPageState extends State<ClassroomsPage> {
  List<String> allClasses = [];
  List<Subject> allSubjects = [];
  List<String> names = [];
  List<DataRow> rows = [];
  @override
  void initState() {
    loadSubjects();
    getAllClassrooms();
    super.initState();
    setState(() {});
  }

  void getAllClassrooms() {
    List<String> classRooms = [];
    allSubjects.forEach((element) {
      classRooms.add(element.assignedClassroom);
    });
    //

    allClasses = classRooms.toSet().toList();
  }

  Future loadSubjects() async {
    final jsonString = await rootBundle.loadString('assets/iug_output1.json');

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
    getAllClassrooms();
    return ListView.builder(
        shrinkWrap: true,
        itemCount: allClasses.length,
        itemBuilder: (context, i) {
          return ListTile(
              title: Text(allClasses[i].toString()),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ClassRoomsTimeTable(
                    classroom: allClasses[i].toString(),
                    allsubjects: allSubjects,
                  );
                  // return ClassroomsTableScreen(
                  //   name: allClasses[i].toString(),
                  //   allSubjects: allSubjects,
                  // );
                }));
              });
        });
  }
}
