// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';

// import '../models/classes.dart';
// import '../models/classrooms.dart';
// import '../theme.dart';

// class MainView extends StatefulWidget {
//   const MainView({Key? key}) : super(key: key);

//   @override
//   State<MainView> createState() => _MainViewState();
// }

// class _MainViewState extends State<MainView> {
//   List<Classes> allClasses = [];
//   Classrooms? classrooms;
//   List headers = [
//     {'title': 'Name', 'index': 1, 'key': 'Subject'},
//     {'title': 'Type', 'index': 2, 'key': 'Type'},
//     {'title': 'Level', 'index': 3, 'key': 'Level'},
//     {'title': 'Department', 'index': 4, 'key': 'for'},
//     {'title': 'Lecturer', 'index': 4, 'key': 'Lecturer'},
//     {'title': 'Group', 'index': 4, 'key': 'Group'},
//     {'title': 'Classroom', 'index': 4, 'key': 'Classroom'},
//     {'title': 'Duration', 'index': 4, 'key': 'Duration'},
//   ];
//   Future<List<Classes>> loadClasses() async {
//     final jsonString = await rootBundle.loadString('assets/iug_input.json');

//     var classesJson = jsonDecode(jsonString);
//     classrooms = Classrooms.fromJson(classesJson['Classrooms']);
//     List jsonClasses = classesJson['Classes'];
//     //print(jsonClasses[0]);

//     // Classes.fromJson(jsonClasses[1]);
//     List<Classes> classesList =
//         jsonClasses.map((json) => Classes.fromJson(json)).toList();
//     allClasses = classesList;
//     return classesList;
//     setState(() {});
//   }

//   Future<List<Classes>> getClasses() async {
//     return allClasses;
//   }

//   @override
//   void initState() {
//     loadClasses();
//     super.initState();
//     setState(() {});
//   }

//   List<DropdownMenuItem> list = [];
//   var _selectedItem = 0;
//   var selectedItemName;
//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         return Column(
//           crossAxisAlignment: CrossAxisAlignment.end,
//           children: [
//             Row(children: [
//               Container(
//                 width: 150,
//                 margin: EdgeInsets.only(left: 20, right: 20, bottom: 10),
//                 padding: EdgeInsets.only(left: 20, right: 20),
//                 decoration: BoxDecoration(
//                     color: drawbackgroundColor,
//                     borderRadius: BorderRadius.circular(15)),
//                 child: DropdownButtonHideUnderline(
//                   child: FutureBuilder<List<Classes>>(
//                     future: loadClasses(),
//                     builder: (context, snapshot) {
//                       if (snapshot.hasError) {
//                         return Container();
//                       } else if (snapshot.hasData) {
//                         list.clear();
//                         //listItemNames.clear();
//                         var dropDownItemsMap = new Map();

//                         // snapshot.data.forEach((item) {
//                         //   //listItemNames.add(branchItem.itemName);
//                         //   int index = snapshot.data.indexOf(item);
//                         //   dropDownItemsMap[index] = item;

//                         //   list.add(DropdownMenuItem(
//                         //       child: Text(item.name), value: index));
//                         // });
//                         selectedItemName = dropDownItemsMap[_selectedItem].name;
                      
//                         return DropdownButton(
//                           items: list,
//                           onChanged: (selected) {
//                             _selectedItem = selected;
//                             setState(() {
//                               selectedSections.clear();
//                               selectedSections =
//                                   dropDownItemsMap[_selectedItem].section;
//                               _item = selectedSections[0];
//                               selectedItemName =
//                                   dropDownItemsMap[_selectedItem].name;
//                             });
//                           },
//                           hint: Text(
//                             selectedItemName,
//                             style: TextStyle(color: Colors.blue),
//                           ),
//                         );
//                       } else {
//                         return Text('loading...');
//                       }
//                     },
//                   ),
//                 ),
//               ),
//               Container(
//                 width: 150,
//                 margin: EdgeInsets.only(left: 20, right: 20, bottom: 10),
//                 padding: EdgeInsets.only(left: 20, right: 20),
//                 decoration: BoxDecoration(
//                     color: Colors.white70,
//                     borderRadius: BorderRadius.circular(15)),
//                 child: _item != null
//                     ? DropdownButton<Section>(
//                         hint: Text(_item != null ? _item.name : 'selected'),
//                         value: _item != null ? _item : null,
//                         onChanged: (Section value) {
//                           print(value);
//                         },
//                         items: selectedSections.map((Section item) {
//                           return DropdownMenuItem<Section>(
//                             value: item != null ? item : null,
//                             child: Text(item != null ? item.name : ''),
//                             onTap: () {
//                               _getStudentsByClass(
//                                   item.myClassId, item.id, item);
//                             },
//                           );
//                         }).toList(),
//                       )
//                     : Text(''),
//               ),
//               TextButton(
//                   onPressed: () {
//                     classDrop.currentState.createRow();
//                     setState(() {});
//                   },
//                   child: Text('create new row'))
//             ]),
//             Expanded(
//               child: Container(
//                 padding: EdgeInsets.all(20),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(15),
//                   color: drawbackgroundColor,
//                 ),
//                 child: Editable(
//                   key: classDrop,
//                   onRowSaved: (value) {
//                     newstudent = Students.fromJson(value);
//                     print(newstudent);
//                   },
//                   onSubmitted: (value) {
//                     print(value);
//                   },
//                   columns: cols,
//                   rows: rows,
//                   showCreateButton: true,
//                   showSaveIcon: true,
//                 ),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
