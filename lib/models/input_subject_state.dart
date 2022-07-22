import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'classes.dart';
import 'classrooms.dart';

class InputSubjectsState with ChangeNotifier {
  Map<String, dynamic> allDepartmentsMap = {
    "departments": {
      "Gm": 120,
      "MM_1m": 80,
      "MO_1m": 90,
      "CS_2m": 40,
      "SD_2m": 70,
      "IT_2m": 20,
      "MM_2m": 70,
      "MO_2m": 80,
      "CS_3m": 35,
      "SD_3m": 60,
      "IT_3m": 15,
      "MM_3m": 60,
      "MO_3m": 70,
      "CS_4m": 25,
      "SD_4m": 55,
      "IT_4m": 10,
      "MM_4m": 60,
      "MO_4m": 65,
      "Gf": 120,
      "MM_1f": 80,
      "MO_1f": 90,
      "CS_2f": 40,
      "SD_2f": 70,
      "IT_2f": 20,
      "MM_2f": 70,
      "MO_2f": 80,
      "CS_3f": 35,
      "SD_3f": 60,
      "IT_3f": 15,
      "MM_3f": 60,
      "MO_3f": 70,
      "CS_4f": 25,
      "SD_4f": 55,
      "IT_4f": 10,
      "MM_4f": 60,
      "MO_4f": 65
    }
  };
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
  List<String> selectedDepartmentForm = [];
  String selectedGenderForm = 'm';
  String selectedClassroom = 'k';
  dynamic get inputFile1 {
    Map<String, dynamic> map = {};
    map.addAll(allDepartmentsMap);
  }

  List<Classes> get allClasses {
    return [..._allClasses];
  }

  List<Classes> get filteredClasses {
    return [..._filteredClasses];
  }

  List<Classes> get multipleLecturers {
    return filteredClasses
        .where((element) => element.lecturer.length > 1)
        .toList();
  }

  InputSubjectsState() {
    loadAllClasses();
  }

  Future loadAllClasses() async {
    final jsonString = await rootBundle.loadString('assets/iug_input1.json');
    // final response = await http.get(
    //   Uri.parse('http://127.0.0.1:5000/getinput1'),
    // );
    var classesJson = jsonDecode(jsonString);
    classrooms = Classrooms.fromJson(classesJson['Classrooms']);
    List jsonClasses = classesJson['Classes'];
    //need to change the classrooms subject
    //print(classesJson);
    // classrooms = Classrooms.fromJson(classesJson['Classrooms']);
    // List jsonClasses = classesJson['Classes'];

    print(classesJson['Classrooms']);
    // var x = {
    //   "Subject": "Introduction to computer science M",
    //   "Type": "P",
    //   "Level": "1",
    //   "for": ["Gm"],
    //   "Lecturer": ["salim jamil alyazji"],
    //   "Classroom": "k",
    //   "Duration": "3",
    //   "Capacity": 80
    // };

    // var y = Classes.fromJson(classesJson['Classes'][0]);
    // print(y.toJson());
    // Classes.fromJson(jsonClasses[1]);
    List<Classes> classesList =
        jsonClasses.map((json) => Classes.fromJson(json)).toList();
    _allClasses = classesList;
    // List<Classes> classesList =
    //     jsonClasses.map((json) => Classes.fromJson(json)).toList();
    // _allClasses = classesList;
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
    _allClasses.insert(0, classes);
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
