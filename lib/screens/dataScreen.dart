import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:timetabling/models/classrooms.dart';

import '../models/classes.dart';

class AvailbleDataScreen extends StatefulWidget {
  const AvailbleDataScreen({Key? key}) : super(key: key);

  @override
  State<AvailbleDataScreen> createState() => _AvailbleDataScreenState();
}

class _AvailbleDataScreenState extends State<AvailbleDataScreen> {
  List<Classes> allClasses = [];
  Classrooms? classrooms;
  @override
  void initState() {
    loadClasses();
    super.initState();
  }

  Future loadClasses() async {
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
              ListView.builder(
                itemCount: allClasses.length,
                itemBuilder: (context, i) {
                
                  print('tesst');
                  return ExpansionTile(
                    trailing: IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {},
                    ),
                    title: Text(allClasses[i].subject),
                    subtitle:
                        Text('Lecturer: ${allClasses[i].lecturer}, Groups'),
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
                          _buildDataCell(allClasses[i].level),
                          _buildDataCell(
                              allClasses[i].getDepartment().toString()),
                          _buildDataCell(allClasses[i].group.toString(),
                              width: 150),
                          _buildDataCell(allClasses[i].classroom),
                          _buildDataCell(allClasses[i].duration),
                        ]),
                      ])
                    ],
                  );
                },
              ),
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
