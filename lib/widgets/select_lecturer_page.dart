import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:editable/editable.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:timetabling/models/myData.dart';
import 'package:timetabling/models/myData2.dart';
import 'package:timetabling/models/subject.dart';
import 'package:provider/provider.dart';
import 'package:timetabling/models/input_subject_state.dart';
import 'package:timetabling/services/json_api.dart';
import '../models/classes.dart';
import '../models/classrooms.dart';
import '../shared/collapsing_navigation_drawer.dart';

class SelectLecturerInputPage extends StatefulWidget {
  final List<Classes> allClasses;

  const SelectLecturerInputPage({Key? key, required this.allClasses})
      : super(key: key);

  @override
  State<SelectLecturerInputPage> createState() =>
      _SelectLecturerInputPageState();
}

class _SelectLecturerInputPageState extends State<SelectLecturerInputPage> {
  Classrooms? classrooms;
  List<Map<String, dynamic>> classesListMap = [];
  Map<String, dynamic> map = {};
  List headers = [
    {'title': 'Lecturer', 'index': 4, 'key': 'Lecturer'},
    {'title': 'Name', 'index': 1, 'key': 'Subject'},
    {'title': 'Level', 'index': 3, 'key': 'Level'},
    {'title': 'Department', 'index': 4, 'key': 'for'},
  ];

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
    final DataTableSource _data = MyData2(provider);
    //provider.allClasses.isEmpty
    //    ? const Center(child: Text('No Data'))
    ///     :
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: PaginatedDataTable(
          header: const Text('Choosing Lecturers'),
          showCheckboxColumn: true,
          //   columnSpacing: 56,
          columnSpacing: 5,
          showFirstLastButtons: true,
          dragStartBehavior: DragStartBehavior.down,
          actions: [
            IconButton(
              splashColor: Colors.transparent,
              icon: const Icon(Icons.refresh),
              onPressed: () {
                setState(() {});
              },
            ),
            ElevatedButton(
              child: const Text('Confirm All'),
              onPressed: () async {
                classesListMap.clear();
                List<Classes> singleLecturer = [...provider.secondInput];
                singleLecturer
                    .removeWhere((element) => element.lecturer.length > 1);
                print('single ' + singleLecturer.length.toString());
                // provider.secondInput
                //     .removeWhere((element) => element.lecturer.length > 1);
                // print('lennn' + provider.secondInput.length.toString());
                // print(provider.allClasses.length);
                // await JsonApi.generateFile(singleLecturer);
                // print('lennn2' + provider.secondInput.length.toString());
                print('finalClassAfterSelection ' +
                    provider.finalClassesAfterSelection.length.toString());
                List<Classes> final2 = [...provider.finalClassesAfterSelection];
                final2.forEach((element) {
                  element.lecturer = [element.lecturer[0]];
                });
                singleLecturer.addAll(final2);

                ///singleLecturer.toSet();
                singleLecturer.forEach(
                  (element) {
                    classesListMap.add(element.toMap());
                  },
                );
                map['"department_groups"'] =
                    jsonEncode(provider.departmentGroups);
                map['"departments"'] = jsonEncode(provider.allDepartmentsMap);
                map['"Classes"'] = classesListMap;

                print(map);
                // final directory = await getApplicationDocumentsDirectory();
                // String dirPath = directory.path;
                // print('path ' + dirPath);
                // File file = File('$dirPath/output.json');
                // file.writeAsString(map.toString());
                await JsonApi.generateFile(map);

                // print('final ' +
                //     provider.finalClassesAfterSelection.length.toString());
                // print('final output' + singleLecturer.length.toString());
                // print(classesListMap);
                // print(classesListMap.length);
                // provider.secondInput.forEach(
                //   (element) {
                //     element.lecturer = [element.lecturer[0]];
                //   },
                // );
                print('lennn' + provider.secondInput.length.toString());
                //provider.deleteAll();
              },
            ),
          ],
          source: _data,
          columns: const [
            DataColumn(label: Text("Num"), tooltip: 'Num'),
            DataColumn(label: Text("Lecturer"), tooltip: 'Lecturer'),
            DataColumn(label: Text("Name"), tooltip: 'Name'),
            DataColumn(label: Text("Group"), tooltip: 'Name'),
            DataColumn(label: Text("For Groups"), tooltip: 'Name'),
            DataColumn(label: Text("Department"), tooltip: 'Department'),
          ],
        ),
      ),
    );
  }
}
