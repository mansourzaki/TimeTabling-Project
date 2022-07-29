import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'classes.dart';
import 'classrooms.dart';

class InputSubjectsState with ChangeNotifier {
  Map<String, dynamic> department_groups = {
    'department_groups': [
      "Gm 101",
      "Gm 102",
      "Gm 103",
      "Gm 104",
      "Gm 105",
      "Gm 106",
      "Gm 107",
      "Gm 108",
      "Gm 109",
      "Gm 110",
      "Gm 111",
      "Gm 112",
      "Gm 113",
      "Gm 114",
      "MM_1m 101",
      "MM_1m 102",
      "MM_1m 103",
      "MM_1m 104",
      "MM_1m 105",
      "MM_1m 106",
      "MM_1m 107",
      "MM_1m 108",
      "MM_1m 109",
      "MM_1m 110",
      "MO_1m 101",
      "MO_1m 102",
      "MO_1m 103",
      "MO_1m 104",
      "MO_1m 105",
      "MO_1m 106",
      "MO_1m 107",
      "MO_1m 108",
      "MO_1m 109",
      "MO_1m 110",
      "MO_1m 111",
      "CS_2m 101",
      "CS_2m 102",
      "SD_2m 101",
      "SD_2m 102",
      "SD_2m 103",
      "SD_2m 104",
      "SD_2m 105",
      "SD_2m 106",
      "SD_2m 107",
      "IT_2m 101",
      "MM_2m 101",
      "MM_2m 102",
      "MM_2m 103",
      "MM_2m 104",
      "MM_2m 105",
      "MM_2m 106",
      "MO_2m 101",
      "MO_2m 102",
      "MO_2m 103",
      "MO_2m 104",
      "CS_3m 101",
      "CS_3m 102",
      "SD_3m 101",
      "SD_3m 102",
      "SD_3m 103",
      "SD_3m 104",
      "SD_3m 105",
      "IT_3m 101",
      "MM_3m 101",
      "MM_3m 102",
      "MM_3m 103",
      "MM_3m 104",
      "MM_3m 105",
      "MO_3m 101",
      "MO_3m 102",
      "MO_3m 103",
      "CS_4m 101",
      "CS_4m 102",
      "SD_4m 101",
      "SD_4m 102",
      "IT_4m 101",
      "MM_4m 101",
      "MM_4m 102",
      "MM_4m 103",
      "MO_4m 101",
      "MO_4m 102",
      "MO_4m 103",
      "Gf 201",
      "Gf 202",
      "Gf 203",
      "Gf 204",
      "Gf 205",
      "MM_1f 201",
      "MM_1f 202",
      "MM_1f 203",
      "MM_1f 204",
      "MM_1f 205",
      "MM_1f 206",
      "MM_1f 207",
      "MM_1f 208",
      "MM_1f 209",
      "MM_1f 210",
      "MM_1f 211",
      "MO_1f 201",
      "MO_1f 202",
      "MO_1f 203",
      "MO_1f 204",
      "CS_2f 201",
      "SD_2f 201",
      "SD_2f 202",
      "SD_2f 203",
      "MM_2f 201",
      "MM_2f 202",
      "MM_2f 203",
      "MM_2f 204",
      "MM_2f 205",
      "MM_2f 206",
      "MM_2f 207",
      "MO_2f 201",
      "MO_2f 202",
      "CS_3f 201",
      "SD_3f 201",
      "SD_3f 202",
      "IT_3f 201",
      "MM_3f 201",
      "MM_3f 202",
      "MM_3f 203",
      "MM_3f 204",
      "MM_3f 205",
      "MM_3f 206",
      "MO_3f 201",
      "CS_4f 201",
      "SD_4f 201",
      "SD_4f 202",
      "IT_4f 201",
      "MM_4f 201",
      "MM_4f 202",
      "MM_4f 203",
      "MM_4f 204",
      "MO_4f 201",
      "MO_4f 202"
    ]
  };
  Map<String, dynamic> allDepartmentsMap = {
    '"departments"': {
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
  List<Classes> _secondInput = [];
  List<Classes> _filteredClasses = [];
  List<Classes> finalClassesAfterSelection = [];
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

  List<Classes> get secondInput {
    return [..._secondInput];
  }

  List<Classes> get filteredClasses {
    return [..._filteredClasses];
  }

  List<Classes> get multipleLecturers {
    return _secondInput
        .where((element) => element.lecturer.length > 1)
        .toList();
  }

  InputSubjectsState() {
    loadAllClasses();
  }

  Future loadAllClasses() async {
    final jsonString = await rootBundle.loadString('assets/iug_input1.json');

    // final response = await http.get(
    //   Uri.parse('http://127.0.0.1:5000/getinput2'),
    // );
    var classesJson = jsonDecode(jsonString);

    //classrooms = Classrooms.fromJson(classesJson['Classrooms']);
    List jsonClasses = classesJson['Classes'];
    var x = {
      "Subject": "Introduction to computer science M",
      "Type": "P",
      "Level": "1",
      "for": ["Gm"],
      "Lecturer": ["salim jamil alyazji"],
      "Classroom": "k",
      "Duration": "3",
      "Capacity": 80,
      "For_Group": [
        "Gm 101",
        "Gm 102",
        "Gm 103",
      ],
      "Group": "101"
    };
    var yy = {
      'Subject': 'Introduction to computing M',
      'Type': 'P',
      'Level': '1',
      'for': ['Gm'],
      'Lecturer': ['Tamer Nazir Madi', 'Ashraf Younes Mghari'],
      'Classroom': [
        'K203',
        'K204',
        'K216',
        'K403',
        'K316',
        'K217',
        'K303',
        'K304',
        'K317',
        'K404'
      ],
      'Duration': 3,
      'Capacity': 80,
      'For_Group': ['Gm 101', 'Gm 102', 'Gm 103', 'Gm 104'],
      'Group': '101'
    };

    //var y = Classes.fromJson(x);

    //var f = Classes.fromJson(jsonClasses[0]);
    // Classes c = jsonClasses[0] as Classes;

    //print('gg $f');
    //need to change the classrooms subject
    //print(classesJson);
    classrooms = Classrooms.fromJson(classesJson['Classrooms']);
    // List jsonClasses = classesJson['Classes'];
    print(classesJson['Classes']);
    List<Classes> classesList =
        jsonClasses.map((json) => Classes.fromJson(json)).toList();
    print(classesList.length);
    _allClasses = classesList;
    // List<Classes> classesList =
    //     jsonClasses.map((json) => Classes.fromJson(json)).toList();
    // _allClasses = classesList;
    _filteredClasses = [...allClasses];
    print('in load');
    notifyListeners();
  }

  Future load2Input() async {
    final jsonString = await rootBundle.loadString('assets/2nd_Input.json');
    // final response = await http.get(
    //   Uri.parse('http://127.0.0.1:5000/getinput1'),
    // );
    var classesJson = jsonDecode(jsonString);

    List jsonClasses = classesJson['Classes'];
    List<Classes> classesList =
        jsonClasses.map((json) => Classes.fromJson(json)).toList();
    _secondInput = classesList;
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
