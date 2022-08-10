import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:path_provider/path_provider.dart';
import 'package:process_run/shell.dart';
import 'package:provider/provider.dart';
import 'package:timetabling/constants.dart';
import 'package:timetabling/models/input_subject_state.dart';
import 'package:timetabling/models/output_subject_state.dart';
import 'package:timetabling/widgets/header.dart';

import '../../helpers/file_helper.dart';
import '../../widgets/lecturer_timetable_widget.dart';

class LectuturersPage extends StatefulWidget {
  LectuturersPage({Key? key}) : super(key: key);

  @override
  State<LectuturersPage> createState() => _LectuturersPageState();
}

class _LectuturersPageState extends State<LectuturersPage> {
  List<String> names = [];
  String searchLec = '';
  Future<List<String>> getAllLecturers() async {
    List<String> all = [];
    context.read<OutputSubjectsState>().allSubjects.forEach((element) {
      all.addAll(element.lecturer);
    });
    all.sort(
      (a, b) {
        return a.toLowerCase().compareTo(b.toLowerCase());
      },
    );
    names = all.toSet().toList();
    return all.toSet().toList();
  }

  void searchLecturer(String query) {
    // final suggestions = names.where((element) {
    //   final lect = element.toLowerCase();
    //   final input = query.toLowerCase();

    //   return names.contains(input);
    // }).toList();
    // names = ['mansour'];
    // print(suggestions);
    searchLec = query;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    
    final provider = Provider.of<InputSubjectsState>(context);
    
    return SingleChildScrollView(
      child: Column(
        children: [
          Header(
            search: searchLecturer,
            name: 'Lecturers',
          ),
          FutureBuilder<List<String>>(
            future: provider.selectLecturers(),
            builder: (context, AsyncSnapshot<List<String>> snapshot) {
              if (snapshot.hasData) {
                List<String> data = snapshot.data!
                    .where(
                      (element) => element
                          .toLowerCase()
                          .contains(searchLec.toLowerCase()),
                    )
                    .toList();
             //   print('lec ${data}');
                //print(jsonEncode(data));
                // context.read<OutputSubjectsState>().allSubjects.where((element) => false);
                return ListView.separated(
                    shrinkWrap: true,
                    itemCount: data.length,
                    separatorBuilder: (context, i) => Divider(),
                    itemBuilder: (context, i) => ListTile(
                          onTap: () async{
                          
                           
                            
                            //print(x.outLines.toString() + 'cmd');
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return LecturersTimeTable(lecturer: data[i]);
                              // return LecturereTableScreen(
                              //   lecturer: allNames[i],
                              //   allSubjects: allSubjects,
                              // );
                            }));
                          },
                          title: Text(data[i]),
                          trailing: Text('Total Credits: ' +
                              context
                                  .read<OutputSubjectsState>()
                                  .getLecturerTotalLoad(data[i])
                                  .toString()),
                          leading: Icon(Icons.assignment_ind),
                        ));
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
          )
        ],
      ),
    );
  }
}
