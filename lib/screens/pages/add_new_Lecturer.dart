import 'package:flutter/material.dart';

class AddNewLecturerPage extends StatefulWidget {
  const AddNewLecturerPage({Key? key}) : super(key: key);

  @override
  State<AddNewLecturerPage> createState() => _AddNewLecturerPageState();
}

class _AddNewLecturerPageState extends State<AddNewLecturerPage> {
  String selectedType = 'Graduate Teaching Assistant';
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                  child: TextField(
                decoration: InputDecoration(hintText: 'Lecturer Name'),
              )),
              Expanded(
                  child: DropdownButton<String>(
                      isExpanded: true,
                      underline: SizedBox(),
                      value: selectedType,
                      items: [
                        DropdownMenuItem<String>(
                          value: 'Graduate Teaching Assistant',
                          child: Text('Graduate Teaching Assistant'),
                        ),
                        DropdownMenuItem<String>(
                          value: 'associate professor',
                          child: Text('associate professor'),
                        ),
                        DropdownMenuItem<String>(
                          value: 'Assistant Professor',
                          child: Text('Assistant Professor'),
                        ),
                        DropdownMenuItem<String>(
                          value: 'Master',
                          child: Text('Master'),
                        ),
                      ],
                      onChanged: (value) {
                        selectedType = value!;
                        setState(() {});
                      })),
              Expanded(
                  child: TextField(
                decoration: InputDecoration(hintText: 'Max Load'),
              )),
              Expanded(
                  child: IconButton(
                onPressed: () {
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text('Added Sucessfuly'),
                    backgroundColor: Colors.green,
                  ));
                },
                icon: Icon(Icons.save),
              )),
            ],
          )
        ],
      ),
    );
  }
}
