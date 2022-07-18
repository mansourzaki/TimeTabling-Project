import 'package:flutter/material.dart';
import '../models/input_subject_state.dart';
import 'dataScreen.dart';

class DepartmentsCapacityScreen extends StatefulWidget {
  DepartmentsCapacityScreen({Key? key}) : super(key: key);

  @override
  State<DepartmentsCapacityScreen> createState() =>
      _DepartmentsCapacityScreenState();
}

class _DepartmentsCapacityScreenState extends State<DepartmentsCapacityScreen> {
  String selectedDepartment = 'G';
  String selectedGender = 'm';

  List<String> deps = [
    'Gm',
    'MM_1m',
    'MO_1m',
    'CS_2m',
    'SD_2m',
    'IT_2m',
    'MM_2m',
    'MO_2m',
    'CS_3m',
    'SD_3m',
    'IT_3m',
    'MM_3m',
    'MO_3m',
    'CS_4m',
    'SD_4m',
    'IT_4m',
    'MM_4m',
    'MO_4m',
    'Gf',
    'MM_1f',
    'MO_1f',
    'CS_2f',
    'SD_2f',
    'IT_2f',
    'MM_2f',
    'MO_2f',
    'CS_3f',
    'SD_3f',
    'IT_3f',
    'MM_3f',
    'MO_3f',
    'CS_4f',
    'SD_4f',
    'IT_4f',
    'MM_4f',
    'MO_4f',
  ];

  List<String> filtered = [
    'Gm',
    'MM_1m',
    'MO_1m',
    'CS_2m',
    'SD_2m',
    'IT_2m',
    'MM_2m',
    'MO_2m',
    'CS_3m',
    'SD_3m',
    'IT_3m',
    'MM_3m',
    'MO_3m',
    'CS_4m',
    'SD_4m',
    'IT_4m',
    'MM_4m',
    'MO_4m',
    'Gf',
    'MM_1f',
    'MO_1f',
    'CS_2f',
    'SD_2f',
    'IT_2f',
    'MM_2f',
    'MO_2f',
    'CS_3f',
    'SD_3f',
    'IT_3f',
    'MM_3f',
    'MO_3f',
    'CS_4f',
    'SD_4f',
    'IT_4f',
    'MM_4f',
    'MO_4f',
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width / 2,
            child: Row(
              children: [
                buildGenderDropDownFormButton(),
                buildDepartmentDropDownFormButton(),
              ],
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 2,
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: filtered.length,
                itemBuilder: (context, i) {
                  return Container(
                    padding: const EdgeInsets.all(16),
                    color: i % 2 == 0 ? Colors.grey[200] : Colors.white,
                    child: Row(
                      children: [
                        Text(filtered[i]),
                        const Spacer(),
                        const SizedBox(
                          width: 100,
                          child: TextField(
                              decoration: InputDecoration(
                                  hintText: 'Capacity',
                                  border: OutlineInputBorder(),
                                  contentPadding: EdgeInsets.all(5))),
                        ),
                      ],
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }

  Widget buildDepartmentDropDownFormButton() {
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
              style: const TextStyle(fontSize: 14),
              value: 'G',
              hint: const Text('Department'),
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
                selectedDepartment = x.toString();

                if (selectedDepartment == 'G') {
                  filtered = deps
                      .where((element) =>
                          element == '$selectedDepartment$selectedGender')
                      .toList();
                  print(selectedDepartment);
                  print('gen $selectedGender - $selectedDepartment');
                } else {
                  filtered = deps
                      .where((element) =>
                          element.substring(element.length - 1) ==
                              selectedGender &&
                          element.split('_')[0] == selectedDepartment)
                      .toList();
                  print('${selectedDepartment + selectedGender}');
                }
                setState(() {});
              }),
        ),
      ),
    );
  }

  Widget buildGenderDropDownFormButton() {
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
              style: const TextStyle(fontSize: 14),
              value: 'm',
              hint: const Text('Male'),
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
                selectedGender = x.toString();

                if (selectedDepartment == 'G') {
                  filtered = deps
                      .where((element) =>
                          element == '$selectedDepartment$selectedGender')
                      .toList();
                  print(selectedDepartment);
                  print('gen $selectedGender - $selectedDepartment');
                } else {
                  filtered = deps
                      .where((element) =>
                          element.substring(element.length - 1) ==
                              selectedGender &&
                          element.split('_')[0] == selectedDepartment)
                      .toList();
                  print('${selectedDepartment + selectedGender}');
                }
                setState(() {});
              }),
        ),
      ),
    );
  }
}
