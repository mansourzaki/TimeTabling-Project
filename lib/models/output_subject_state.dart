import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:timetabling/models/subject.dart';

class OutputSubjectsState with ChangeNotifier {
  // List<Subject> _data = [];
  List<Subject> _allSubjects = [];
  List<Subject> _filteredSubjects = [];
  bool isLoading = true;
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
    print('in loading all');
    final jsonString = await rootBundle.loadString('assets/iug_output1.json');
    // var subjectsList = jsonDecode(jsonString);
    List<dynamic> subjectsList = jsonDecode(jsonString);
    _allSubjects = subjectsList
        .map(
          (json) => Subject.fromJson(json),
        )
        .toList();
    // _allSubjects = subjectsList
    //     .map(
    //       (json) => Subject.fromJson(json),
    //     )
    //     .toList();
    //  _allSubjects = subjectsList;

    _filteredSubjects = [...allSubjects];
    print('finished subjects');
    isLoading = false;
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

  List<List<Subject>> getSubjects(Department department) {
    List<String> groups = [];
    List<List<Subject>> subs = [];
    List<Subject> subjects = allSubjects
        .where((element) => element.department.contains(department))
        .toList();
    subjects.forEach((e) {
      groups.add(e.group);
    });
    List<String> groupNames = [...groups.toSet()];
    for (int i = 0; i < groupNames.length; i++) {
      subs.add(
          subjects.where((element) => element.group == groupNames[i]).toList());
    }
    return subs;
  }
}
