import 'dart:convert';

import 'package:editable/editable.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:timetabling/models/myData.dart';
import 'package:timetabling/models/subject.dart';
import 'package:provider/provider.dart';
import 'package:timetabling/models/input_subject_state.dart';
import 'package:timetabling/services/json_api.dart';
import '../constants.dart';
import '../models/classes.dart';
import '../models/classrooms.dart';
import '../shared/collapsing_navigation_drawer.dart';
import '../widgets/build_form.dart';

class StudentsTable extends StatefulWidget {
  final List<Classes> allClasses;

  const StudentsTable({Key? key, required this.allClasses}) : super(key: key);

  @override
  State<StudentsTable> createState() => _StudentsTableState();
}

class _StudentsTableState extends State<StudentsTable> {
  Classrooms? classrooms;
  List headers = [
    {'title': 'Name', 'index': 1, 'key': 'Subject'},
    {'title': 'Type', 'index': 2, 'key': 'Type'},
    {'title': 'Level', 'index': 3, 'key': 'Level'},
    {'title': 'Department', 'index': 4, 'key': 'for'},
    {'title': 'Lecturer', 'index': 4, 'key': 'Lecturer'},
    {'title': 'Capacity', 'index': 4, 'key': 'Classroom'},
    {'title': 'Classroom', 'index': 4, 'key': 'Duration'},
    {'title': 'Duration', 'index': 4, 'key': 'Capacity'},
  ];
  void saveCallBackFunction() {
    setState(() {});
  }

  // Future<List<Classes>> getClasses() async {
  //   return widget.allClasses;
  // }

  @override
  void initState() {
    super.initState();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<InputSubjectsState>(context, listen: false);

    final DataTableSource _data = MyData(
        provider.filteredClasses, provider, saveCallBackFunction, context);
    //provider.allClasses.isEmpty
    //    ? const Center(child: Text('No Data'))

    return SingleChildScrollView(
      child: Column(
        children: [
          buildForm(provider),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: PaginatedDataTable(
              header: const Text('Input Data'),
              showCheckboxColumn: true,
              //   columnSpacing: 56,
              columnSpacing: 15,
              dragStartBehavior: DragStartBehavior.down,
              actions: [
                IconButton(
                  splashColor: Colors.transparent,
                  icon: const Icon(Icons.refresh),
                  onPressed: () {
                    setState(() {});
                  },
                ),
                IconButton(
                  splashColor: Colors.transparent,
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    // provider.addClass(Classes.emptyClass());
                    setState(
                      () {
                        if (provider.formKey.currentState!.validate()) {
                          List<String> deps = provider.selectedDepartmentForm;
                          Set<String> fullDeps = {};
                          String gender = provider.selectedGenderForm;
                          String level = provider.selectedLevelForm;
                          deps.forEach(
                            (element) {
                              if (level == '1') {
                                if (element == 'G') {
                                  fullDeps.add('$element$gender');
                                } else if (element == 'MO' || element == 'MM') {
                                  fullDeps.add('${element}_$level$gender');
                                }
                              } else if (element != 'G') {
                                fullDeps.add('${element}_$level$gender');
                              }
                            },
                          );
                          // print('${deps[0]}_$level$gender');
                          print('eeps' +
                              provider.selectedDepartmentForm.toString());
                          // String normalDep = '${deps[0]}_$level$gender';
                          // String generalDep = '${deps[0]}$gender';
                          // print(normalDep);
                          // print(generalDep);

                          var x = {
                            'Subject': provider.subjectController.text.trim() +
                                ' ' +
                                provider.selectedGenderForm[0].toUpperCase(),
                            'Type': provider.selectedType,
                            'Level': provider.selectedLevelForm.toString(),
                            'for': fullDeps.toList(),
                            // 'for': provider.selectedLevelForm == '1'
                            //     ? [generalDep]
                            //     : [normalDep],
                            'Lecturer': [
                              //lecturerController.text.trim()
                              provider.selectedLecturer
                            ],
                            'Capacity': int.parse(
                                provider.capacityController.text.trim()),
                            'Classroom': provider.selectedClassroom.trim(),
                            'Duration': provider.durationController.text.trim()
                          };
                          provider.addClass(Classes.fromJson(x));
                          // provider.selectedDepartmentForm.clear();

                          // print('cleared ' +
                          //     provider.selectedDepartmentForm.toString());
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Adding Data'),
                                  backgroundColor: Colors.green));
                        }

                        // widget.allClasses.insert(0, Classes.emptyClass());
                      },
                    );
                  },
                ),
                ElevatedButton(
                    onPressed: () async {
                      Map<String, dynamic> map = {};
                      map['"Classrooms"'] = jsonEncode(provider.classrooms);
                      map['"departments"'] =
                          jsonEncode(provider.allDepartmentsMap);
                      map['"Classes"'] = json.encode(provider.allClasses);
                      await JsonApi.saveJson(
                          inputFile: map, name: 'test_first_input.json');
                    },
                    child: Text('Get All')),
                ElevatedButton(
                  child: const Text('Clear all'),
                  onPressed: () {
                    provider.deleteAll();
                  },
                ),
              ],
              source: _data,

              columns: const [
                DataColumn(label: Text("Num"), tooltip: 'Num'),
                DataColumn(label: Text("Name"), tooltip: 'Name'),
                DataColumn(label: Text("Type"), tooltip: 'Type'),
                DataColumn(
                  label: Text("Level"),
                  numeric: true,
                  tooltip: 'Level',
                ),
                DataColumn(label: Text("Department"), tooltip: 'Department'),
                DataColumn(label: Text("Lecturer"), tooltip: 'Lecturer'),
                DataColumn(label: Text("Capacity"), tooltip: 'Capacity'),
                DataColumn(label: Text("ClassRoom"), tooltip: 'ClassRoom'),
                DataColumn(label: Text("Duration"), tooltip: 'Duration'),
                DataColumn(label: Text("Delete"), tooltip: 'Delete'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget _buildRow(String text) {
  //   return Padding(
  //     padding: const EdgeInsets.all(8.0),
  //     child: Center(
  //       child: Text(text),
  //     ),
  //   );
  // }

  // List<dynamic> getAllRows() {
  //   List rows = [];
  //   widget.allClasses.forEach((element) {
  //     rows.add(element.toJson());
  //   });
  //   return rows;
  //   // return filtered.map((e) => e.toJson());
  // }
}

// DataCell _buildDataCell(String text, {double width = 50}) {
//   return DataCell(Container(
//     width: width,
//     child: Text(
//       text,
//       softWrap: true,
//       overflow: TextOverflow.visible,
//       style: const TextStyle(fontWeight: FontWeight.w600),
//     ),
//   ));
// }


