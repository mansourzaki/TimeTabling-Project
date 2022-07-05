import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class ChooseLecturerScreen extends StatefulWidget {
  const ChooseLecturerScreen({Key? key}) : super(key: key);

  @override
  State<ChooseLecturerScreen> createState() => _ChooseLecturerScreenState();
}

class _ChooseLecturerScreenState extends State<ChooseLecturerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose Lecturer Screen'),
      ),
      body: Scaffold(),
    );
  }
}
