import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:timetabling/widgets/header.dart';

import '../../models/output_subject_state.dart';
import '../../models/subject.dart';
import '../../widgets/classroom_timetable_widget.dart';
import 'package:provider/provider.dart';

class ClassroomsPage extends StatefulWidget {
  const ClassroomsPage({Key? key}) : super(key: key);

  @override
  State<ClassroomsPage> createState() => _ClassroomsPageState();
}

class _ClassroomsPageState extends State<ClassroomsPage> {
  String searchLec = '';
  Future<List<String>> getAllClassrooms() async {
    List<String> all = [];
    context.read<OutputSubjectsState>().allSubjects.forEach((element) {
      all.add(element.assignedClassroom);
    });
    all.sort(
      (a, b) {
        return a.toLowerCase().compareTo(b.toLowerCase());
      },
    );
    return all.toSet().toList();
  }

  void searchClassRoom(String query) {
    searchLec = query;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Header(search: searchClassRoom, name: 'Classrooms'),
          FutureBuilder<List<String>>(
            future: getAllClassrooms(),
            builder: (context, AsyncSnapshot<List<String>> snapshot) {
              if (snapshot.hasData) {
                List<String> data = snapshot.data!
                    .where(
                      (element) => element
                          .toLowerCase()
                          .contains(searchLec.toLowerCase()),
                    )
                    .toList();
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: data.length,
                    itemBuilder: (context, i) {
                      return ListTile(
                        title: Text(data[i].toString()),
                        trailing: Text('Number of classes: ' +
                            context
                                .read<OutputSubjectsState>()
                                .getClassRoomsClasses(data[i])
                                .toString()),
                        leading: Icon(Icons.assignment_ind),
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return ClassRoomsTimeTable(
                              classroom: data[i].toString(),
                              allsubjects: context
                                  .read<OutputSubjectsState>()
                                  .allSubjects,
                            );
                            // return ClassroomsTableScreen(
                            //   name: allClasses[i].toString(),
                            //   allSubjects: allSubjects,
                            // );
                          }));
                        },
                      );
                    });
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Errror'),
                );
              } else {
                return Center(
                  child: SingleChildScrollView(),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
