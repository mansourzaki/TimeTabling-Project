import 'package:flutter/material.dart';
import 'package:timetabling/models/input_subject_state.dart';
import 'package:timetabling/widgets/department_capacity.dart';
import 'package:timetabling/widgets/inputSubject.dart';

import '../../constants.dart';
import '../../models/subject.dart';
import 'package:provider/provider.dart';

class AddNewLecturerPage extends StatefulWidget {
  const AddNewLecturerPage({Key? key}) : super(key: key);

  @override
  State<AddNewLecturerPage> createState() => _AddNewLecturerPageState();
}

class _AddNewLecturerPageState extends State<AddNewLecturerPage> {
  String selectedType = 'Graduate Teaching Assistant';
  String selectedLevel = '1';
  bool selectedGender = true;
  String selectedDepartment = 'G';
  String x = "Department.CS_2";
  String selectedTabel = 'Department.CS_2m';
  String gender = 'm';
  bool isGeneral = true;
  bool showAll = false;
  TextEditingController capacityController = TextEditingController();
  TextEditingController lecNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<InputSubjectsState>(context);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 18),
        child: Column(
          children: [
            SizedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                      child: TextField(
                    controller: lecNameController,
                    decoration:
                        const InputDecoration(hintText: 'Lecturer Name'),
                  )),
                  Expanded(
                      child: DropdownButton<String>(
                          isExpanded: true,
                          underline: const SizedBox(),
                          value: selectedType,
                          items: [
                            const DropdownMenuItem<String>(
                              value: 'Graduate Teaching Assistant',
                              child: const Text('Graduate Teaching Assistant'),
                            ),
                            const DropdownMenuItem<String>(
                              value: 'associate professor',
                              child: const Text('associate professor'),
                            ),
                            const DropdownMenuItem<String>(
                              value: 'Assistant Professor',
                              child: const Text('Assistant Professor'),
                            ),
                            const DropdownMenuItem<String>(
                              value: 'Master',
                              child: const Text('Master'),
                            ),
                          ],
                          onChanged: (value) {
                            selectedType = value!;
                            setState(() {});
                          })),
                  const Expanded(
                      child: TextField(
                    decoration: const InputDecoration(hintText: 'Max Load'),
                  )),
                  Expanded(
                    child: IconButton(
                      onPressed: () {
                        context
                            .read<InputSubjectsState>()
                            .addNewLecturer(lecNameController.text);
                        Scaffold.of(context).showSnackBar(const SnackBar(
                          content: const Text('Added Sucessfuly'),
                          backgroundColor: Colors.green,
                        ));
                      },
                      icon: const Icon(Icons.save),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Adding Capacities',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            SizedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: 200,
                    child: DropdownButton<bool>(
                        underline: const SizedBox(),
                        borderRadius: BorderRadius.circular(15),
                        dropdownColor: secondaryColor,
                        value: selectedGender,
                        items: [
                          const DropdownMenuItem(
                              value: true, child: Text('Male')),
                          const DropdownMenuItem(
                              value: false, child: Text('Female')),
                        ],
                        onChanged: (value) {
                          if (selectedDepartment == 'G') {
                            selectedLevel = '1';

                            gender = value! ? 'm' : 'f';
                            isGeneral = true;
                            // print('G$gender');
                            // print(provider.allDepartmentsMap['Gm']);
                            selectedTabel = 'G$gender';
                            capacityController.text = provider
                                .allDepartmentsMap['G$gender']
                                .toString();
                            print(selectedTabel + ' level');
                            print(capacityController.text);
                            setState(() {});
                            // x = 'Department.' + selectedDepartment;
                            // print(x + gender);
                            // selectedTabel =
                            //     Department.values.firstWhere((element) {
                            //   print(element.toString());
                            //   return element.toString() == x + gender;
                            // }).toString();

                            // print(selectedTabel + ' tabel');
                            // setState(() {});
                          } else {
                            if (selectedLevel == '1') {
                              if (selectedDepartment == 'MO' ||
                                  selectedDepartment == 'MM') {
                                selectedLevel = '1';
                              } else {
                                selectedLevel = '2';
                              }
                            }
                            selectedGender = value!;
                            gender = selectedGender ? 'm' : 'f';
                            x = '$selectedDepartment' +
                                '_' +
                                selectedLevel +
                                gender;
                            capacityController.text =
                                provider.allDepartmentsMap[x].toString();
                            print(capacityController.text);
                            print(x);
                            setState(() {});
                          }
                          // selectedGender = value!;
                          // gender = selectedGender ? 'm' : 'f';
                          // x = 'Department.' +
                          //     selectedDepartment +
                          //     '_' +
                          //     selectedLevel;
                          // selectedTabel = Department.values
                          //     .firstWhere(
                          //         (element) => element.toString() == x + gender)
                          //     .toString();
                          // print(selectedTabel + ' tabel');
                          // setState(() {});
                        }),
                  ),
                  SizedBox(
                    width: 230,
                    child: DropdownButton<String>(
                        borderRadius: BorderRadius.circular(15),
                        autofocus: false,
                        dropdownColor: secondaryColor,
                        underline: const SizedBox(),
                        value: selectedDepartment,
                        items: const [
                          DropdownMenuItem(value: 'G', child: Text('General')),
                          DropdownMenuItem(
                              value: 'CS', child: Text('Computer Science')),
                          DropdownMenuItem(
                              value: 'SD', child: Text('Software Development')),
                          DropdownMenuItem(
                              value: 'IT',
                              child: Text('Information Technology')),
                          DropdownMenuItem(
                              value: 'MO', child: Text('Mobile Development')),
                          DropdownMenuItem(
                              value: 'MM', child: Text('Multi Media')),
                        ],
                        onChanged: (value) {
                          changevalues(value, provider);
                          // selectedDepartment = value!;
                          // gender = selectedGender ? 'm' : 'f';
                          // x = 'Department.' +
                          //     selectedDepartment +
                          //     '_' +
                          //     selectedLevel;
                          // selectedTabel = Department.values
                          //     .firstWhere(
                          //         (element) => element.toString() == x + gender)
                          //     .toString();
                          // print(selectedTabel + ' tabel');
                          // setState(() {});
                        }),
                  ),
                  isGeneral
                      ? const SizedBox()
                      : SizedBox(
                          width: 200,
                          child: DropdownButton<String>(
                              borderRadius: BorderRadius.circular(15),
                              dropdownColor: secondaryColor,
                              underline: const SizedBox(),
                              value: selectedLevel,
                              items: const [
                                DropdownMenuItem(
                                    value: '1', child: Text('Level 1')),
                                DropdownMenuItem(
                                    value: '2', child: Text('Level 2')),
                                DropdownMenuItem(
                                    value: '3', child: Text('Level 3')),
                                DropdownMenuItem(
                                    value: '4', child: Text('Level 4')),
                              ],
                              onChanged: (value) {
                                if (selectedDepartment == 'G') {
                                  selectedLevel = '1';
                                  gender = selectedGender ? 'm' : 'f';
                                  isGeneral = true;
                                  selectedLevel = value!;
                                  // print('G$gender');
                                  // print(provider.allDepartmentsMap['Gm']);
                                  selectedTabel = 'G$gender';
                                  capacityController.text = provider
                                      .allDepartmentsMap['G$gender']
                                      .toString();
                                  print(capacityController.text);
                                  setState(() {});
                                  // x = 'Department.' + selectedDepartment;
                                  // print(x + gender);
                                  // selectedTabel =
                                  //     Department.values.firstWhere((element) {
                                  //   print(element.toString());
                                  //   return element.toString() == x + gender;
                                  // }).toString();

                                  // print(selectedTabel + ' tabel');
                                  // setState(() {});
                                } else {
                                  selectedLevel = value!;
                                  print(selectedDepartment + ' fff');
                                  if (selectedLevel == '1') {
                                    if (selectedDepartment == 'MO' ||
                                        selectedDepartment == 'MM') {
                                      selectedLevel = '1';
                                    } else {
                                      selectedLevel = '2';
                                    }
                                  }
                                  selectedGender = selectedGender;
                                  gender = selectedGender ? 'm' : 'f';

                                  x = '$selectedDepartment' +
                                      '_' +
                                      selectedLevel +
                                      gender;
                                  capacityController.text =
                                      provider.allDepartmentsMap[x].toString();
                                  print(capacityController.text);
                                  print(x);
                                  setState(() {});
                                }
                                // selectedLevel = value!;
                                // x = 'Department.' +
                                //     selectedDepartment +
                                //     '_' +
                                //     selectedLevel;
                                // gender = selectedGender ? 'm' : 'f';
                                // selectedTabel = Department.values
                                //     .firstWhere((element) =>
                                //         element.toString() == x + gender)
                                //     .toString();
                                // print(selectedTabel + ' tabel');
                                // setState(() {});
                              }),
                        ),
                  SizedBox(
                    width: 150,
                    child: TextField(
                      controller: capacityController,
                      onChanged: (value) {},
                      decoration: InputDecoration(
                        suffix: IconButton(
                            onPressed: () async{
                              String dep = '';
                              if (selectedDepartment == 'G') {
                                // selectedLevel = '1';
                                String gender = selectedGender ? 'm' : 'f';
                                dep = 'G$gender';
                              } else {
                                String gender = selectedGender ? 'm' : 'f';
                                dep = '$selectedDepartment' +
                                    '_' +
                                    selectedLevel +
                                    gender;
                                print('dep ' + dep);
                              }
                              // provider.allDepartmentsMap[dep] =
                              //     capacityController.text;
                             await context
                                  .read<InputSubjectsState>()
                                  .changeCapacity(dep, capacityController.text);
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Capacity updated')));
                              
                            },
                            icon: Icon(Icons.save)),
                        hintText: "Capacity",
                        fillColor: secondaryColor,
                        filled: true,
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton(
                  onPressed: () {
                    showAll = !showAll;
                    setState(() {});
                  },
                  child: Text(showAll ? 'Show Less' : 'Show All')),
            ),
            showAll
                ? GridView.builder(
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      childAspectRatio: 4,
                      maxCrossAxisExtent: 400,
                      mainAxisSpacing: 0,
                      crossAxisSpacing: 3,
                    ),
                    itemCount: provider.allDepartmentsMap.length,
                    itemBuilder: (context, i) {
                      return DepartmentCapacityTextField(
                          name: provider.allDepartmentsMap.keys.toList()[i],
                          capacity: context
                              .read<InputSubjectsState>()
                              .allDepartmentsMap
                              .values
                              .toList()[i]
                              .toString());
                    })
                : SizedBox(),
          ],
        ),
      ),
    );
  }

  void changevalues(String? value, InputSubjectsState provider) {
    if (value == 'G') {
      selectedLevel = '1';
      selectedDepartment = value!;
      gender = selectedGender ? 'm' : 'f';
      isGeneral = true;
      // print('G$gender');
      // print(provider.allDepartmentsMap['Gm']);
      selectedTabel = 'G$gender';
      print(selectedTabel);
      capacityController.text =
          provider.allDepartmentsMap['G$gender'].toString();
      setState(() {});
      print(capacityController.text);

      // x = 'Department.' + selectedDepartment;
      // print(x + gender);
      // selectedTabel =
      //     Department.values.firstWhere((element) {
      //   print(element.toString());
      //   return element.toString() == x + gender;
      // }).toString();

      // print(selectedTabel + ' tabel');
      // setState(() {});
    } else {
      selectedDepartment = value!;
      print(selectedLevel);
      print(selectedDepartment);
      if (selectedLevel == '1') {
        if (selectedDepartment == 'MO' || selectedDepartment == 'MM') {
          selectedLevel = '1';
        } else {
          selectedLevel = '2';
        } 
      }
    //    selectedLevel = se;
      isGeneral = false;
      setState(() {});
      selectedDepartment = value;
      gender = selectedGender ? 'm' : 'f';
      x = '$value' + '_' + selectedLevel + gender;
      capacityController.text = provider.allDepartmentsMap[x].toString();
      print(capacityController.text);
      setState(() {});
    }
  }
}
