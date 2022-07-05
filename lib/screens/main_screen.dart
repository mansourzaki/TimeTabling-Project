import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:timetabling/models/output_subject_state.dart';
import 'package:timetabling/screens/choosLecturer_screen.dart';
import 'package:timetabling/screens/classrooms_screen.dart';
import 'package:timetabling/screens/dataScreen.dart';
import 'package:timetabling/screens/algorithim_screen.dart';
import 'package:timetabling/screens/lecturers_screen.dart';
import 'package:timetabling/screens/students_screen.dart';
import 'package:provider/provider.dart';
import '../models/input_subject_state.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<OutputSubjectsState>(context);
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Show Lecturers'),
            leading: const Icon(Icons.person),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: ((context) => const LecturersScreen())));
            },
          ),
          ListTile(
            title: const Text('Show Classrooms'),
            leading: const Icon(Icons.person),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: ((context) => const ClassroomsScreen())));
            },
          ),
          ListTile(
            title: const Text('Students Tables'),
            leading: const Icon(Icons.person),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: ((context) => StudentsScreen(
                        allSubjects: provider.allSubjects,
                        // provider: provider,
                      ))));
            },
          ),
          ListTile(
            title: const Text('Edit Input Subjects'),
            leading: const Icon(Icons.person),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: ((context) => const AvailbleDataScreen(

                      // provider: provider,
                      ))));
            },
          ),
          ListTile(
            title: const Text('Choose Lecturers'),
            leading: const Icon(Icons.person),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: ((context) => const ChooseLecturerScreen(

                      // provider: provider,
                      ))));
            },
          ),
          ListTile(
            title: const Text('Algorithim calls'),
            leading: const Icon(Icons.person),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: ((context) => const AlgorithimCalls(

                      // provider: provider,
                      ))));
            },
          ),
        ],
      ),
    );
  }
}
