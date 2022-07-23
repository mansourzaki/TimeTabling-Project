import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chips_input/flutter_chips_input.dart';
import 'package:timetabling/models/classrooms.dart';
import 'package:timetabling/models/input_subject_state.dart';
import 'package:timetabling/screens/departments_capacity_screen.dart';
import 'package:timetabling/screens/table.dart';
import 'package:provider/provider.dart';
import 'package:timetabling/services/json_api.dart';
import '../models/classes.dart';

typedef validator = String? Function(String?)?;

class AvailbleDataScreen extends StatefulWidget {
  const AvailbleDataScreen({Key? key}) : super(key: key);

  @override
  State<AvailbleDataScreen> createState() => _AvailbleDataScreenState();
}

class _AvailbleDataScreenState extends State<AvailbleDataScreen> {
 

  @override
  Widget build(BuildContext context) {
    final _provider = context.watch<InputSubjectsState>();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
                bottom: const TabBar(tabs: [
                  Tab(text: 'Availble Classes'),
                  Tab(text: 'Availble ClassRooms'),
                ]),
                title: const Text('Availble Input Data'),
                leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                actions: [
                  IconButton(
                      onPressed: () async {
                        // final pdfFile =
                        try {
                          // await JsonApi.generateTable(_provider.allClasses);
                        } catch (e) {
                          print(e);
                        }
                        String url = 'http://127.0.0.1:5000/loadinput1';
                        final response = await http.post(Uri.parse(url),
                            body: json.encode(_provider.allClasses));
                        print('$response response');
                      },
                      icon: Icon(Icons.upload))
                ]),
            body: TabBarView(children: [
              Column(mainAxisSize: MainAxisSize.max, children: [
                Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildLevelDropDownButton(_provider),
                      const SizedBox(
                        width: 50,
                      ),
                      _buildDepartmentDropDownButton(_provider),
                    ],
                  ),
                ),
                _buildForm(_provider),
                Container(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [],
                  ),
                ),
                Expanded(
                  child: StudentsTable(
                    allClasses: _provider.filteredClasses,
                    // provider: _provider,
                  ),
                ),
              ]),
              _provider.classrooms == null
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : DepartmentsCapacityScreen()
            ]),
          )),
    );
  }

  Form _buildForm(InputSubjectsState _provider) {
    return Form(
      key: _provider.formKey,
      child: Row(
        children: [
          _buildTextFormField(
              label: 'Subject',
              controller: _provider.subjectController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter subject name';
                }
                return null;
              }),

          _buildTypeDropDownFormButton(_provider),
          buildGenderDropDownFormButton(_provider),
          buildLevelDropDownFormButton(_provider),
          buildDepartmentDropDownFormButton(_provider),
          // _buildTextFormField(
          //     label: 'Departemnts: G,SD,...',
          //     controller: _provider.departmentsController,
          //     validator: (value) {
          //       List<String> deps;
          //       if (value != null) {
          //         deps = value.split(',');
          //         bool exists = deps.every((e) =>
          //             e == 'CS' ||
          //             e == 'Gm' ||
          //             e == 'SD' ||
          //             e == 'IT' ||
          //             e == 'MM' ||
          //             e == 'MO');
          //         if (exists) {
          //           return null;
          //         } else {
          //           return 'Please enter valid department';
          //         }
          //       }
          //       if (value == null || value.isEmpty) {
          //         return 'Please enter group';
          //       }

          //       return null;
          //     }),
          _buildTextFormField(
              label: 'Lecturer',
              controller: _provider.lecturerController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter lecturer name';
                }
                return null;
              }),

          _buildClassRoomDropDownFormButton(_provider),
          _buildTextFormField(
              label: 'Duration',
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              controller: _provider.durationController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter duration';
                } else if (int.parse(value) <= 0 || int.parse(value) > 4) {
                  return 'Please enter a valid duration';
                }
                return null;
              }),
          _buildTextFormField(
              label: 'Capacity',
              controller: _provider.capacityController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter Capacity';
                }
                return null;
              }),
        ],
      ),
    );
  }

  Widget _buildLevelDropDownButton(InputSubjectsState provider) {
    return SizedBox(
        height: 65,
        width: 150,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: DropdownButtonFormField<String>(
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
              ),
              style: TextStyle(fontSize: 14),
              value: 'All',
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
                  value: '3',
                  child: Text('3'),
                ),
                DropdownMenuItem(
                  value: '4',
                  child: Text('4'),
                ),
                DropdownMenuItem(
                  value: 'All',
                  child: Text('All'),
                ),
              ],
              onChanged: (x) {
                provider.selectedLevel = x.toString();
                provider.filterList();
              }),
        ));
  }

  Widget buildGenderDropDownFormButton(InputSubjectsState provider) {
    return Expanded(
      child: Container(
        height: 65,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: DropdownButtonFormField<String>(
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
              ),
              style: TextStyle(fontSize: 14),
              value: 'm',
              hint: Text('Male'),
              iconEnabledColor: Colors.amber,
              items: const [
                DropdownMenuItem(
                  value: 'm',
                  child: Text('Male'),
                ),
                DropdownMenuItem(
                  value: 'f',
                  child: Text('Female'),
                ),
              ],
              onChanged: (x) {
                provider.selectedGenderForm = x.toString();
              }),
        ),
      ),
    );
  }

  Widget buildLevelDropDownFormButton(InputSubjectsState provider) {
    return Expanded(
      child: Container(
        height: 65,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: DropdownButtonFormField<String>(
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
              ),
              style: TextStyle(fontSize: 14),
              value: '1',
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
                  value: '3',
                  child: Text('3'),
                ),
                DropdownMenuItem(
                  value: '4',
                  child: Text('4'),
                ),
              ],
              onChanged: (x) {
                provider.selectedLevelForm = x.toString();
              }),
        ),
      ),
    );
  }

  Widget _buildTypeDropDownFormButton(InputSubjectsState provider) {
    return Expanded(
      child: Container(
        height: 65,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: DropdownButtonFormField<String>(
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
              ),
              style: TextStyle(fontSize: 14),
              value: provider.selectedType,
              hint: Text('Type'),
              iconEnabledColor: Colors.amber,
              items: const [
                DropdownMenuItem(
                  value: 'V',
                  child: Text('V'),
                ),
                DropdownMenuItem(
                  value: 'P',
                  child: Text('P'),
                ),
              ],
              onChanged: (x) {
                provider.selectedType = x.toString();
              }),
        ),
      ),
    );
  }

  Widget buildDepartmentDropDownFormButton(InputSubjectsState provider) {
    return Expanded(
      child: Container(
        height: 65,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: DropdownButtonFormField<String>(
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
              ),
              style: TextStyle(fontSize: 14),
              value: 'G',
              hint: Text('Department'),
              iconEnabledColor: Colors.amber,
              items: const [
                DropdownMenuItem(
                  value: 'G',
                  child: Text('G'),
                ),
                DropdownMenuItem(
                  value: 'CS',
                  child: Text('CS'),
                ),
                DropdownMenuItem(
                  value: 'SD',
                  child: Text('SD'),
                ),
                DropdownMenuItem(
                  value: 'IT',
                  child: Text('IT'),
                ),
                DropdownMenuItem(
                  value: 'MM',
                  child: Text('MM'),
                ),
                DropdownMenuItem(
                  value: 'MO',
                  child: Text('MO'),
                ),
              ],
              onChanged: (x) {
                provider.selectedDepartmentForm.add(x.toString());
              }),
        ),
      ),
    );
  }

  Widget _buildDepartmentDropDownButton(InputSubjectsState provider) {
    return SizedBox(
      height: 65,
      width: 150,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: DropdownButtonFormField<String>(
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
            ),
            style: TextStyle(fontSize: 14),
            hint: Text('Department'),
            value: 'All',
            iconEnabledColor: Colors.amber,
            items: const [
              DropdownMenuItem(
                value: 'Gm',
                child: Text('Gm'),
              ),
              DropdownMenuItem(
                value: 'CS',
                child: Text('CS'),
              ),
              DropdownMenuItem(
                value: 'SD',
                child: Text('SD'),
              ),
              DropdownMenuItem(
                value: 'IT',
                child: Text('IT'),
              ),
              DropdownMenuItem(
                value: 'MM',
                child: Text('MM'),
              ),
              DropdownMenuItem(
                value: 'MO',
                child: Text('MO'),
              ),
              DropdownMenuItem(
                value: 'All',
                child: Text('All'),
              ),
            ],
            onChanged: (x) {
              provider.selectedDepartment = x.toString();
              provider.filterList();
            }),
      ),
    );
  }

  Widget _buildClassRoomDropDownFormButton(InputSubjectsState provider) {
    return Expanded(
      child: Container(
        height: 65,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: DropdownButtonFormField<String>(
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
              ),
              style: TextStyle(fontSize: 14),
              value: 'k',
              hint: Text('ClassRoom'),
              iconEnabledColor: Colors.amber,
              items: const [
                DropdownMenuItem(
                  value: 'k',
                  child: Text('k'),
                ),
                DropdownMenuItem(
                  value: 'l',
                  child: Text('l'),
                ),
                DropdownMenuItem(
                  value: 'im',
                  child: Text('im'),
                ),
                DropdownMenuItem(
                  value: 'im',
                  child: Text('if'),
                ),
                DropdownMenuItem(
                  value: 'n',
                  child: Text('n'),
                ),
              ],
              onChanged: (x) {
                provider.selectedClassroom = x.toString();
              }),
        ),
      ),
    );
  }
}

class ClassroomsWidget extends StatelessWidget {
  const ClassroomsWidget({
    Key? key,
    required InputSubjectsState provider,
  })  : _provider = provider,
        super(key: key);

  final InputSubjectsState _provider;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ExpansionTile(
            title: const Text('IFemale'),
            children: [
              ListTile(
                title: Text('${_provider.classrooms!.ifl}'),
              )
            ],
          ),
          ExpansionTile(
            title: const Text('IMale'),
            children: [
              ListTile(
                title: Text('${_provider.classrooms!.iml}'),
              )
            ],
          ),
          ExpansionTile(
            title: const Text('K'),
            children: [
              ListTile(
                title: Text('${_provider.classrooms!.k}'),
              )
            ],
          ),
          ExpansionTile(
            title: const Text('L'),
            children: [
              ListTile(
                title: Text('${_provider.classrooms!.l}'),
              )
            ],
          ),
          ExpansionTile(
            title: const Text('N'),
            children: [
              ListTile(
                title: Text('${_provider.classrooms!.n}'),
              )
            ],
          ),
        ],
      ),
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
              _buildDataCell(allClasses[i].lecturer.toString(), width: 150),
              _buildDataCell(allClasses[i].getType().toString()),
              _buildDataCell(allClasses[i].level.toString()),
              _buildDataCell(allClasses[i].getDepartment().toString()),
              _buildDataCell(allClasses[i].classroom.toString()),
              _buildDataCell(allClasses[i].duration.toString()),
              _buildDataCell(allClasses[i].capacity.toString(), width: 150),
            ]),
          ])
        ],
      );
    },
  );
}

Widget _buildChipsInput() {
  return Expanded(
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: ChipsInput(
        textCapitalization: TextCapitalization.words,
        decoration: InputDecoration(
            labelText: 'Departments',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
            )),
        maxChips: 3,
        findSuggestions: _findSuggestions,
        suggestionBuilder: (context, state, data) {
          return ListTile(
            key: ObjectKey(data),
            title: Text(data.toString()),
            onTap: () => state.selectSuggestion(data),
          );
        },
        onChanged: (input) {
          print(input);
        },
        chipBuilder: (context, state, data) {
          return InputChip(
            label: Text(data.toString()),
            onDeleted: () => state.deleteChip(data),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          );
        },
      ),
    ),
  );
}

Future<List<String>> _findSuggestions(String input) async {
  List<String> list = [];
  final List<String> labels = [
    'Gm',
    'MM_1m',
    'MM_1m',
    'MM_1m',
    'MM_1m',
    'MM_1m',
  ];
  if (input.isNotEmpty) {
    list.addAll(labels.where((e) => e.contains(input)));
    return list;
  } else {
    return [];
  }
}

Widget _buildTextFormField(
    {required String label,
    validator validator,
    required TextEditingController controller,
    List<TextInputFormatter>? inputFormatters}) {
  return Expanded(
      child: Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
    child: TextFormField(
      style: TextStyle(fontSize: 14),
      validator: validator,
      controller: controller,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
          )),
    ),
  ));
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
