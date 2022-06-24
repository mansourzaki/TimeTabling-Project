import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:timetabling/models/output_subject_state.dart';
import 'package:timetabling/screens/classrooms_screen.dart';
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
      appBar: AppBar(actions: [
        
      ]),
      body: ListView(
        children: [
          ListTile(
            title: Text('Show Lecturers'),
            leading: Icon(Icons.person),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: ((context) => const LecturersScreen())));
            },
          ),
          ListTile(
            title: Text('Show Classrooms'),
            leading: Icon(Icons.person),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: ((context) => ClassroomsScreen())));
            },
          ),
          ListTile(
            title: Text('Students Tables'),
            leading: Icon(Icons.person),
            onTap: () {
              
              Navigator.of(context).push(MaterialPageRoute(
                  builder: ((context) => StudentsScreen(
                        allSubjects: provider.allSubjects,
                        // provider: provider,
                      ))));
            },
          ),
        ],
      ),
    );
  }
}
