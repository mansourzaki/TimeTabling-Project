import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:timetabling/screens/table.dart';
import 'package:timetabling/widgets/select_lecturer_page.dart';

import '../../models/input_subject_state.dart';
import 'package:provider/provider.dart';

class SelectLectuerPage extends StatefulWidget {
  const SelectLectuerPage({Key? key}) : super(key: key);

  @override
  State<SelectLectuerPage> createState() => _SelectLectuerPageState();
}

class _SelectLectuerPageState extends State<SelectLectuerPage> {
  @override
  void initState() {
    context.read<InputSubjectsState>().load2Input();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _provider = context.watch<InputSubjectsState>();
    return _provider.secondInput.isEmpty
        ? Center(
            child: CircularProgressIndicator(),
          )
        : SelectLecturerInputPage(allClasses: _provider.multipleLecturers);
  }
}
