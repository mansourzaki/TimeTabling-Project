import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:timetabling/models/subject.dart';

class SubjectsState with ChangeNotifier {
  List<Subject> _data = [];

  List<Subject> get data {
    return [..._data];
  }

  SubjectsState() {
    loadAllSubjects();
    filterSubject();
  }

  Future loadAllSubjects() async {
    final jsonString = await rootBundle.loadString('assets/iug_output.json');

    List<dynamic> subjectsList = jsonDecode(jsonString);
    _data = subjectsList
        .map(
          (json) => Subject.fromJson(json),
        )
        .toList();
    notifyListeners();
  }

  List<Subject> filterSubject() {
    return _data
        .where((subject) =>
            subject.department.contains(Department.G) && subject.level == '1')
        .toList();
  }
}
