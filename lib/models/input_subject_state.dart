import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:timetabling/models/subject.dart';

import 'classes.dart';
import 'classrooms.dart';

class InputSubjectsState with ChangeNotifier {
  List<String> lecturers = [];
  List<dynamic> departmentGroups = [
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
  ];
  Map<String, dynamic> allDepartmentsMap = {};
  // List<Subject> _data = [];
  List<Classes> _allClasses = [];
  List<Classes> _secondInput = [];
  List<Classes> _filteredClasses = [];
  List<Classes> finalClassesAfterSelection = [];
  Map<String, dynamic> classrooms = {};
  String selectedLecturer = '';
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
  List<Department> selectedDepsSearchForm = [];
  String selectedGenderForm = 'm';
  String selectedClassroom = 'k';
  //********************** */
  String subName = '';
  Types subType = Types.P;
  String subLevel = '1';
  List<Department> subDeps = [];
  List<String> subLecs = [];
  int subCap = 0;
  String subRoom = '';
  String subDuration = '';
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

  void changeCapacity(
    String key,
    String num,
  ) {
    allDepartmentsMap[key] = num;
    notifyListeners();
  }

  Future loadAllClasses() async {
    final jsonString = await rootBundle.loadString('assets/iug_input1.json');

    // final response = await http.get(
    //   Uri.parse('http://127.0.0.1:5000/getinput2'),
    // );
    var classesJson = jsonDecode(jsonString);
    print('in load');
    classrooms = classesJson['Classrooms'];
    print('Classrooms ' + classrooms.toString());
    //print('classrooms' + classrooms.toString());
    List jsonClasses = classesJson['Classes'];
    Map<String, dynamic> deps = classesJson['departments'];
    allDepartmentsMap = deps;

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
    //classrooms = Classrooms.fromJson(classesJson['Classrooms']);
    // List jsonClasses = classesJson['Classes'];
    // print(classesJson['Classes']);
    List<Classes> classesList =
        jsonClasses.map((json) => Classes.fromJson(json)).toList();
    print(classesList.length);
    _allClasses = classesList;
    // List<Classes> classesList =
    //     jsonClasses.map((json) => Classes.fromJson(json)).toList();
    // _allClasses = classesList;
    _filteredClasses = [...allClasses];
    getAllLecturers();
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
    departmentGroups = classesJson['department_groups'];
    Map<String, dynamic> deps = classesJson['departments'];
    allDepartmentsMap = deps;
    // print('departmentsGroups');
    // print(jsonEncode(departmentGroups));
    // print('deeps');
    // print(jsonEncode(deps));
    List<Classes> classesList =
        jsonClasses.map((json) => Classes.fromJson(json)).toList();
    _secondInput = classesList;
    finalClassesAfterSelection =
        secondInput.where((element) => element.lecturer.length > 1).toList();
    addTempLecs();
    notifyListeners();
  }

  void addLecToFinal() {
    finalClassesAfterSelection =
        secondInput.where((element) => element.lecturer.length > 1).toList();
  }

  void addTempLecs() {
    List<String> malesPractical = [
      'Practical Lecturer 1 M',
      'Practical Lecturer 2 M',
      'Practical Lecturer 3 M',
      'Practical Lecturer 4 M',
      'Practical Lecturer 5 M',
    ];
    List<String> males = [
      'Lecturer 1',
      'Lecturer 2',
      'Lecturer 3',
      'Lecturer 4',
      'Lecturer 5',
    ];
    List<String> femalesPractical = [
      'Practical Lecturer 1 F',
      'Practical Lecturer 2 F',
      'Practical Lecturer 3 F',
      'Practical Lecturer 4 F',
      'Practical Lecturer 5 F',
    ];

    finalClassesAfterSelection.forEach(
      (element) {
        //print(element.subject[element.subject.length - 1]);
        if (element.type == Types.P) {
          element.lecturer.addAll(males);
        } else {
          if (element.subject[element.subject.length - 1] == 'M') {
            element.lecturer.addAll(malesPractical);
          } else {
            element.lecturer.addAll(femalesPractical);
          }
        }
      },
    );
  }

  List getRooms(String building) {
    return classrooms[building];
  }

  addNewClassroom(String building, String room) {
    int x = classrooms[building].length;
    print(x);
    classrooms[building].add(room);

    print('new' + classrooms[building].toString());
    notifyListeners();
  }

  removeClassRoom(String building, String room) {
    int x = classrooms[building].length;
    print(x);
    //classrooms[building].removeWhere((element) => element == room);
    classrooms[building].remove(room);

    print('new' + classrooms[building].toString());
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

  void updateClass(Classes classes, int index) {
    _allClasses[index] = Classes(
        subject: classes.subject,
        type: classes.type,
        level: classes.level,
        department: classes.department,
        lecturer: classes.lecturer,
        classroom: classes.classroom,
        duration: classes.duration,
        capacity: classes.capacity);
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

  getAllLecturers() {
    _allClasses.forEach((element) {
      lecturers.addAll(element.lecturer);
    });
    List<String> set = lecturers.toSet().toList();
    lecturers.sort(
      (a, b) {
        return a.toLowerCase().compareTo(b.toLowerCase());
      },
    );
    lecturers = set;
  }

  void addNewLecturer(String lecturer) {
    if (!lecturers.contains(lecturer)) {
      lecturers.add(lecturer);
    }
    notifyListeners();
  }
}
