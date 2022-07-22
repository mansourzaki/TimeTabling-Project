import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:timetabling/constants.dart';
import 'package:timetabling/models/output_subject_state.dart';
import 'package:timetabling/models/subject.dart';
import 'package:timetabling/widgets/studentsTableWidgetForPage.dart';
import 'package:timetabling/widgets/students_timetabel.dart';
import 'package:provider/provider.dart';

class StudedntsTablesPage extends StatefulWidget {
  const StudedntsTablesPage({Key? key}) : super(key: key);

  @override
  State<StudedntsTablesPage> createState() => _StudedntsTablesPageState();
}

class _StudedntsTablesPageState extends State<StudedntsTablesPage> {
  String selectedLevel = '1';
  bool selectedGender = true;
  String selectedDepartment = 'G';
  String x = "Department.CS_2";
  String selectedTabel = 'Department.CS_2m';
  String gender = 'm';
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: DropdownButton<bool>(
                      underline: SizedBox(),
                      borderRadius: BorderRadius.circular(15),
                      dropdownColor: secondaryColor,
                      value: selectedGender,
                      items: [
                        DropdownMenuItem(child: Text('Male'), value: true),
                        DropdownMenuItem(child: Text('Female'), value: false),
                      ],
                      onChanged: (value) {
                        selectedGender = value!;
                        setState(() {});
                      }),
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: DropdownButton<String>(
                      borderRadius: BorderRadius.circular(15),
                      autofocus: false,
                      dropdownColor: secondaryColor,
                      underline: SizedBox(),
                      value: selectedDepartment,
                      items: [
                        DropdownMenuItem(child: Text('General'), value: 'G'),
                        DropdownMenuItem(
                            child: Text('Computer Science'), value: 'CS'),
                        DropdownMenuItem(
                            child: Text('Software Development'), value: 'SD'),
                        DropdownMenuItem(
                            child: Text('Information Technology'), value: 'IT'),
                        DropdownMenuItem(
                            child: Text('Mobile Development'), value: 'MO'),
                        DropdownMenuItem(
                            child: Text('Multi Media'), value: 'MM'),
                      ],
                      onChanged: (value) {
                        // String departmentString = "Department.$valuee";
                        // String underscore = '_';
                        // String gender = selectedGender ? "m" : "f";
                        // selectedDepartment = departmentString +
                        //     underscore +
                        //     selectedLevel +
                        //     gender;
                        //    x = "Department.$value" + "_" + selectedLevel;
                        selectedDepartment = value!;
                        setState(() {});
                      }),
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: DropdownButton<String>(
                      borderRadius: BorderRadius.circular(15),
                      dropdownColor: secondaryColor,
                      underline: SizedBox(),
                      value: selectedLevel,
                      items: [
                        DropdownMenuItem(child: Text('Level 1'), value: '1'),
                        DropdownMenuItem(child: Text('Level 2'), value: '2'),
                        DropdownMenuItem(child: Text('Level 3'), value: '3'),
                        DropdownMenuItem(child: Text('Level 4'), value: '4'),
                      ],
                      onChanged: (value) {
                        selectedLevel = value!;
                        setState(() {});
                      }),
                ),
                IconButton(
                    onPressed: () {
                      selectedTabel = Department.values
                          .firstWhere(
                              (element) => element.toString() == x + gender)
                          .toString();
                      print(selectedTabel + ' tabel');
                      setState(() {});
                    },
                    icon: Icon(Icons.search))
              ],
            ),
          ),
          StudentsTimeTableForPage(
              allsubjects: context.read<OutputSubjectsState>().allSubjects,
              level: selectedLevel,
              isMale: selectedGender,
              department: Department.values.firstWhere(
                  (element) => element.toString() == selectedTabel)),
        ],
      ),
    );
  }
}
