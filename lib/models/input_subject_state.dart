import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'classes.dart';
import 'classrooms.dart';

class InputSubjectsState with ChangeNotifier {
  // List<Subject> _data = [];
  List<Classes> _allClasses = [];
  List<Classes> _filteredClasses = [];
  Classrooms? classrooms;
  String selectedLevel = 'All';
  String selectedDepartment = 'All';
  bool noMatch = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController subjectController = TextEditingController();
  TextEditingController lecturerController = TextEditingController();
  TextEditingController capacityController = TextEditingController();
  TextEditingController durationController = TextEditingController();
  TextEditingController departmentsController = TextEditingController();
  String selectedLevelForm = '1';
  String selectedType = 'V';
  String selectedDepartmentForm = '';
  String selectedClassroom = 'k';
  List<Classes> get allClasses {
    return [..._allClasses];
  }

  List<Classes> get filteredClasses {
    return [..._filteredClasses];
  }

  InputSubjectsState() {
    loadAllClasses();
  }

  Future loadAllClasses() async {
    final jsonString = await rootBundle.loadString('assets/iug_input1.json');
    var classesJson = jsonDecode(jsonString);
   // classrooms = Classrooms.fromJson(classesJson['Classrooms']);
    List jsonClasses = classesJson['Classes'];
    //print(jsonClasses[0]);
    var x = {
      'Subject': 'Introduction to computer science M',
      'Type': 'P',
      'Level': '1',
      'for': ['Gm'],
      'Lecturer': 'salim jamil alyazji',
      'Classroom': 'k',
      'Duration': '3',
      'Capacity': 80,
    };
    var y = Classes.fromJson(x);
    print(y.toJson());
    Classes.fromJson(jsonClasses[1]);
    List<Classes> classesList =
        jsonClasses.map((json) => Classes.fromJson(json)).toList();
    _allClasses = classesList;
    _filteredClasses = [...allClasses];
    notifyListeners();
  }

  void deleteClass(int index, Classes classes) {
    bool y = _allClasses.remove(classes);
    _filteredClasses = _allClasses;
    print('$y in delete');
    notifyListeners();
  }

  void addClass(Classes classes) {
    _allClasses.add(classes);
    _filteredClasses = _allClasses;
    notifyListeners();
  }

  void deleteAll() {
    _allClasses.clear();
    _filteredClasses.clear();
    // _allClasses.add(Classes.emptyClass());
    // _filteredClasses = _allClasses;
    notifyListeners();
  }

  void filterList() {
    if (selectedDepartment == 'All' && selectedLevel == 'All') {
      _filteredClasses = _allClasses;
      filteredClasses.isEmpty ? noMatch == true : false;
      notifyListeners();
      print("selectedDepartment == 'All' && selectedLevel == 'All'");
    } else if (selectedLevel != 'All' && selectedDepartment != 'All') {
      _filteredClasses = _allClasses
          .where((element) =>
              element.level == selectedLevel &&
              element.getDepartment().contains(selectedDepartment))
          .toList();
      filteredClasses.isEmpty ? noMatch == true : false;
      print("selectedLevel != 'All' && selectedDepartment != 'All''");
      notifyListeners();
    } else if (selectedDepartment != 'All' && selectedLevel == 'All') {
      _filteredClasses = _allClasses
          .where(
              (element) => element.getDepartment().contains(selectedDepartment))
          .toList();
      filteredClasses.isEmpty ? noMatch == true : false;
      print("selectedDepartment != 'All' && selectedLevel == 'All'");
      notifyListeners();
    } else if (selectedDepartment == 'All' && selectedLevel != 'All') {
      _filteredClasses = _allClasses
          .where((element) => element.level == selectedLevel)
          .toList();
      filteredClasses.isEmpty ? noMatch == true : false;

      notifyListeners();
      print("selectedDepartment == 'All' && selectedLevel != 'All'");
    }
    notifyListeners();
  }
}
