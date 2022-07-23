import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:timetabling/screens/table.dart';
import 'package:provider/provider.dart';
import '../../models/input_subject_state.dart';

class EditInputScreen extends StatefulWidget {
  const EditInputScreen({Key? key}) : super(key: key);

  @override
  State<EditInputScreen> createState() => _EditInputScreenState();
}

class _EditInputScreenState extends State<EditInputScreen> {
  @override
  Widget build(BuildContext context) {
    final _provider = context.watch<InputSubjectsState>();
    return StudentsTable(allClasses: _provider.allClasses);
  }
}
