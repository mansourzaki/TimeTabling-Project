import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:timetabling/models/input_subject_state.dart';

import '../../constants.dart';
import 'package:provider/provider.dart';

class AddClassroomsScreen extends StatefulWidget {
  const AddClassroomsScreen({Key? key}) : super(key: key);

  @override
  State<AddClassroomsScreen> createState() => _AddClassroomsScreenState();
}

class _AddClassroomsScreenState extends State<AddClassroomsScreen> {
  TextEditingController kController = TextEditingController();
  TextEditingController lController = TextEditingController();
  TextEditingController imlController = TextEditingController();
  TextEditingController iflController = TextEditingController();
  TextEditingController impController = TextEditingController();
  TextEditingController ifpController = TextEditingController();
  TextEditingController nController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    print(context.read<InputSubjectsState>().classrooms.keys);
    return SingleChildScrollView(
        child: Column(
      children: context
          .watch<InputSubjectsState>()
          .classrooms
          .keys
          .map((e) => _buildExpandedTile(e, e[0]))
          .toList(),
    ));
  }

  Widget _buildExpandedTile(String classroom, String room) {
    late TextEditingController controller;
    switch (classroom.toLowerCase()) {
      case 'k':
        controller = kController;
        break;
      case 'l':
        controller = lController;
        break;
      case 'iml':
        controller = imlController;
        break;
      case 'imp':
        controller = impController;
        break;
      case 'ifl':
        controller = iflController;
        break;
      case 'ifp':
        controller = ifpController;
        break;
      case 'n':
        controller = ifpController;
        break;
    }
    return ExpansionTile(
      title: Text('$classroom Classrooms'),
      childrenPadding: EdgeInsets.symmetric(horizontal: 30),
      children: context
          .watch<InputSubjectsState>()
          .getRooms(classroom.toLowerCase())
          .map(
            (e) => Row(
              children: [
                Text(e),
                IconButton(
                    onPressed: () {
                      context
                          .read<InputSubjectsState>()
                          .removeClassRoom(classroom.toLowerCase(), e);
                    },
                    icon: Icon(Icons.delete))
              ],
            ),
          )
          .toList(),
      trailing: SizedBox(
          width: 300,
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    hintText: "Classroom",
                    fillColor: secondaryColor,
                    filled: true,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                ),
              ),
              IconButton(
                  onPressed: () {
                    if (controller.text.isNotEmpty &&
                        controller.text[0].toLowerCase() ==
                            room.toLowerCase()) {
                      context.read<InputSubjectsState>().addNewClassroom(
                          classroom.toLowerCase(), controller.text);
                    }
                  },
                  icon: Icon(Icons.add))
            ],
          )),
    );
  }
}
