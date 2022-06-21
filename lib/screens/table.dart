import 'dart:convert';

import 'package:editable/editable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:timetabling/models/subject.dart';

import '../models/classes.dart';
import '../models/classrooms.dart';
import '../shared/collapsing_navigation_drawer.dart';

class StudentsTable extends StatefulWidget {
  final List<Classes> allClasses;
  const StudentsTable({Key? key, required this.allClasses}) : super(key: key);

  @override
  State<StudentsTable> createState() => _StudentsTableState();
}

class _StudentsTableState extends State<StudentsTable> {
  // List<Classes> allClasses = [];
  Classrooms? classrooms;
  List headers = [
    {'title': 'Name', 'index': 1, 'key': 'Subject'},
    {'title': 'Type', 'index': 2, 'key': 'Type'},
    {'title': 'Level', 'index': 3, 'key': 'Level'},
    {'title': 'Department', 'index': 4, 'key': 'for'},
    {'title': 'Lecturer', 'index': 4, 'key': 'Lecturer'},
    {'title': 'Group', 'index': 4, 'key': 'Group'},
    {'title': 'Classroom', 'index': 4, 'key': 'Classroom'},
    {'title': 'Duration', 'index': 4, 'key': 'Duration'},
  ];

  Future<List<Classes>> getClasses() async {
    return widget.allClasses;
  }

  @override
  void initState() {
    super.initState();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return widget.allClasses.isEmpty
        ? const Center(child: CircularProgressIndicator())
        : Padding(
            padding: const EdgeInsets.all(8.0),
            child: Editable(
              columnCount: 8,
              columnRatio: 0.12,
              thSize: 16,
              showCreateButton: true,
              tdStyle: const TextStyle(fontSize: 14),
              onRowSaved: (x) {
                if (x != 'no edit') {
                  var y = widget.allClasses[x['row']].toJson();
                  print(x.runtimeType);
                  Map<String, dynamic> d = Map.from(x);
                  y.addAll(d);
                  y.remove('row');
                  print(y);
                  // allClasses.removeWhere((element) => (element.subject == y['Subject']));
                  widget.allClasses[x['row']] = Classes.fromJson(y);

                  //  print(allClasses[0].toJson());
                } else {
                  print(x);
                  print(jsonEncode(widget.allClasses));
                  print('${widget.allClasses[0].level} ff');
                }
              },
              tdAlignment: TextAlign.center,
              thAlignment: TextAlign.center,
              tdEditableMaxLines: 2,
              columns: headers,
              rows: [widget.allClasses[0].toJson()],
              showSaveIcon: true,
              borderColor: Colors.grey.shade300,
            ),
          );
  }

  List<dynamic> getAllRows() {
    List rows = [];
    widget.allClasses.forEach((element) {
      rows.add(element.toJson());
    });
    return rows;
    // return filtered.map((e) => e.toJson());
  }
}
