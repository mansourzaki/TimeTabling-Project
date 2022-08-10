import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:timetabling/constants.dart';

import 'package:timetabling/models/subject.dart';

import '../helpers/file_helper.dart';
import '../helpers/shell_helper.dart';

class OutputSubjectsState with ChangeNotifier {
  // List<Subject> _data = [];
  bool mutationWait = false;
  Stream<List<ProcessResult>>? stream;
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
  changeMutation() async {
    mutationWait = !mutationWait;
    notifyListeners();
  }

  runFirstSolution() async {
    changeMutation();
    await ShellHelper.shellHelper.runFirstSolution();
    await runMutation();
    changeMutation();
    notifyListeners();
  }

  runMutation() async {
    await ShellHelper.shellHelper.runMutation();
    loadAllSubjects();

    notifyListeners();
  }

  Future loadAllSubjects() async {
    String map =
        await FileHelper.fileHelper.readMapFromFile(finalOutputAfterMutation);
    print('in loading all');
    //final jsonString = await rootBundle.loadString(finalOutput);
    //  var subjectsList = jsonDecode(map);
    var subFromList = jsonDecode(map)[0];
    List<dynamic> subjectsList = subFromList;
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

  int getLecturerTotalLoad(String name) {
    int x = 0;
    List<Subject> ls =
        _allSubjects.where((element) => element.lecturer[0] == name).toList();
    ls.forEach((element) {
      x += int.parse(element.duration);
    });
    return x;
  }

  int getClassRoomsClasses(String name) {
    int x = 0;
    List<Subject> ls = _allSubjects
        .where((element) => element.assignedClassroom == name)
        .toList();
    ls.forEach((element) {
      x += 1;
    });
    return x;
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
