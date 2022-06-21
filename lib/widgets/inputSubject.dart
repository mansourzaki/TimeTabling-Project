import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class InputSubject extends StatefulWidget {
  const InputSubject({Key? key}) : super(key: key);

  @override
  State<InputSubject> createState() => _InputSubjectState();
}

class _InputSubjectState extends State<InputSubject> {
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(title: Text('Software Engineering F'));
  }
}
