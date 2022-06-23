import 'package:flutter/material.dart';
import 'package:timetabling/models/input_subject_state.dart';
import 'package:timetabling/screens/classrooms_screen.dart';
import 'package:timetabling/screens/dataScreen.dart';
import 'package:timetabling/screens/lecturers_screen.dart';

import 'package:provider/provider.dart';
import 'package:timetabling/widgets/timeTableWidget.dart';

void main() {
  runApp(MaterialApp(
      home: ChangeNotifierProvider(
    create: (context) => InputSubjectsState(),
    child: TimeTableWidget(),
  )));
}
