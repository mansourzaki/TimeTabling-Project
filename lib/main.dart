import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timetabling/models/input_subject_state.dart';
import 'package:timetabling/models/output_subject_state.dart';
//import 'package:timetabling/screens/classrooms_screen.dart';
import 'package:timetabling/screens/dataScreen.dart';
//import 'package:timetabling/screens/lecturers_screen.dart';

import 'package:provider/provider.dart';
import 'package:timetabling/screens/main_screen.dart';
import 'package:timetabling/widgets/timeTableWidget.dart';

import 'constants.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => InputSubjectsState(),
        child: const AvailbleDataScreen(),
      ),
      ChangeNotifierProvider(
        create: (context) => OutputSubjectsState(),
      ),
    ],
    child: const MyHome(),
  ));
}

class MyHome extends StatelessWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: bgColor,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
            .apply(bodyColor: Colors.white),
        canvasColor: secondaryColor,
      ),
      home: MainScreen(),
    );
  }
}
