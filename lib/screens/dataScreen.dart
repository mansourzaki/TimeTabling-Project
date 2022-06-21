import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:timetabling/models/classrooms.dart';
import 'package:timetabling/screens/table.dart';

import '../models/classes.dart';

class AvailbleDataScreen extends StatefulWidget {
  const AvailbleDataScreen({Key? key}) : super(key: key);

  @override
  State<AvailbleDataScreen> createState() => _AvailbleDataScreenState();
}

class _AvailbleDataScreenState extends State<AvailbleDataScreen> {
  List<Classes> allClasses = [];
  List<Classes> filteredClasses = [];
  Classrooms? classrooms;
  @override
  void initState() {
    loadClasses();
    super.initState();
  }

  Future loadClasses() async {
    final jsonString = await rootBundle.loadString('assets/iug_input1.json');

    var classesJson = jsonDecode(jsonString);
    classrooms = Classrooms.fromJson(classesJson['Classrooms']);
    List jsonClasses = classesJson['Classes'];
    //print(jsonClasses[0]);
    var x = {
      'Subject': 'Introduction to computer science M',
      'Type': 'P',
      'Level': '1',
      'for': ['G'],
      'Lecturer': 'salim jamil alyazji',
      'Group': ['101'],
      'Classroom': 'k',
      'Duration': '3'
    };
    var y = Classes.fromJson(x);
    print(y.toJson());
    Classes.fromJson(jsonClasses[1]);
    List<Classes> classesList =
        jsonClasses.map((json) => Classes.fromJson(json)).toList();
    allClasses = classesList;
    filteredClasses = [...allClasses];
    setState(() {});
  }

  String _selectedValue = '';

  Future loadClassesTest() async {
    final jsonString = await rootBundle.loadString('assets/iug_input.json');

    var classesJson = jsonDecode(jsonString);
    classrooms = Classrooms.fromJson(classesJson['Classrooms']);
    List jsonClasses = classesJson['Classes'];
    //print(jsonClasses[0]);

    // Classes.fromJson(jsonClasses[1]);
    List<Classes> classesList =
        jsonClasses.map((json) => Classes.fromJson(json)).toList();
    allClasses = classesList;

    setState(() {});
  }

  Future<List<Classes>> getClasses() async {
    return allClasses;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              bottom: const TabBar(tabs: [
                Tab(text: 'Availble Classes'),
                Tab(text: 'Availble ClassRooms'),
              ]),
              title: const Text('Availble Input Data'),
            ),
            body: TabBarView(children: [
              Column(mainAxisSize: MainAxisSize.max, children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 100,
                        child: DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            borderRadius: BorderRadius.circular(10),
                            hint: Text('Level'),
                            iconEnabledColor: Colors.amber,
                            items: const [
                              DropdownMenuItem(
                                value: '1',
                                child: Text('1'),
                              ),
                              DropdownMenuItem(
                                value: '2',
                                child: Text('2'),
                              ),
                              DropdownMenuItem(
                                value: '4',
                                child: Text('3'),
                              ),
                              DropdownMenuItem(
                                value: '3',
                                child: Text('4'),
                              ),
                            ],
                            onChanged: (x) {
                              setState(() {
                                filteredClasses = allClasses
                                    .where((element) => element.level == x)
                                    .toList();
                                    print('in setstate');
                              });
                            }),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: StudentsTable(
                    allClasses: filteredClasses,
                  ),
                ),
              ]),
              classrooms == null
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Container(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ExpansionTile(
                            title: const Text('IFemale'),
                            children: [
                              ListTile(
                                title: Text('${classrooms!.ifemale}'),
                              )
                            ],
                          ),
                          ExpansionTile(
                            title: const Text('IMale'),
                            children: [
                              ListTile(
                                title: Text('${classrooms!.im}'),
                              )
                            ],
                          ),
                          ExpansionTile(
                            title: const Text('K'),
                            children: [
                              ListTile(
                                title: Text('${classrooms!.k}'),
                              )
                            ],
                          ),
                          ExpansionTile(
                            title: const Text('L'),
                            children: [
                              ListTile(
                                title: Text('${classrooms!.l}'),
                              )
                            ],
                          ),
                          ExpansionTile(
                            title: const Text('N'),
                            children: [
                              ListTile(
                                title: Text('${classrooms!.n}'),
                              )
                            ],
                          ),
                        ],
                      ),
                    )
            ]),
          )),
    );
  }
}

Widget _buildListViewForInputFile(
    BuildContext context, List<Classes> allClasses) {
  return ListView.builder(
    itemCount: allClasses.length,
    itemBuilder: (context, i) {
      print('tesst');
      return ExpansionTile(
        trailing: IconButton(
          icon: Icon(Icons.edit),
          onPressed: () {},
        ),
        title: Text(allClasses[i].subject),
        subtitle: Text('Lecturer: ${allClasses[i].lecturer}, Groups'),
        children: [
          DataTable(border: TableBorder.all(), columns: const [
            DataColumn(
              label: Text("Lecturer"),
            ),
            DataColumn(
              label: Text("Type"),
            ),
            DataColumn(
              label: Text("Level"),
            ),
            DataColumn(
              label: Text("Department"),
            ),
            DataColumn(
              label: Text("Groups"),
            ),
            DataColumn(
              label: Text("ClassRoom"),
            ),
            DataColumn(
              label: Text("Duration"),
            ),
          ], rows: [
            DataRow(cells: [
              _buildDataCell(allClasses[i].lecturer, width: 150),
              _buildDataCell(allClasses[i].getType().toString()),
              _buildDataCell(allClasses[i].level.toString()),
              _buildDataCell(allClasses[i].getDepartment().toString()),
              _buildDataCell(allClasses[i].group.toString(), width: 150),
              _buildDataCell(allClasses[i].classroom),
              _buildDataCell(allClasses[i].duration.toString()),
            ]),
          ])
        ],
      );
    },
  );
}

DataCell _buildDataCell(String text, {double width = 50}) {
  return DataCell(Container(
    width: width,
    child: Text(
      text,
      softWrap: true,
      overflow: TextOverflow.visible,
      style: const TextStyle(fontWeight: FontWeight.w600),
    ),
  ));
}
