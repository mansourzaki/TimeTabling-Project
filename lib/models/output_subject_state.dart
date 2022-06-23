import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:timetabling/models/subject.dart';

class OutputSubjectsState with ChangeNotifier {
  // List<Subject> _data = [];
  List<Subject> _allSubjects = [];
  List<Subject> _filteredSubjects = [];

  List<Subject> get allSubjects {
    return [..._allSubjects];
  }

  List<Subject> get filteredSubjects {
    return [..._filteredSubjects];
  }

  OutputSubjectsState() {
    loadAllSubjects();
  }

  Future loadAllSubjects() async {
    final jsonString = await rootBundle.loadString('assets/iug_output1.json');
    var subjectsList = jsonDecode(jsonString);
    _allSubjects = subjectsList
        .map(
          (json) => Subject.fromJson(json),
        )
        .toList();
    _allSubjects = subjectsList;
    _filteredSubjects = [...allSubjects];
    notifyListeners();
  }

  void deleteClass(int index, Subject subject) {
    bool y = _allSubjects.remove(subject);
    _filteredSubjects = _allSubjects;
    print('$y in delete');
    notifyListeners();
  }

  void addClass(Subject Subject) {
    _allSubjects.add(Subject);
    _filteredSubjects = _allSubjects;
    notifyListeners();
  }
}
