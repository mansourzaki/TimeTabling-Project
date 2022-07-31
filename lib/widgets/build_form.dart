import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:timetabling/models/subject.dart';

import '../models/input_subject_state.dart';
import '../screens/dataScreen.dart';

Widget _buildTextFormField(
    {required String label,
    validator validator,
    required TextEditingController controller,
    List<TextInputFormatter>? inputFormatters}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
    child: TextFormField(
      style: TextStyle(fontSize: 14, color: Colors.white),
      validator: validator,
      controller: controller,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
          )),
    ),
  );
}

Form buildForm(InputSubjectsState _provider) {
  return Form(
    key: _provider.formKey,
    child: Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: 200,
              child: _buildTextFormField(
                  label: 'Subject',
                  controller: _provider.subjectController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter subject name';
                    }
                    return null;
                  }),
            ),
            SizedBox(
                width: 150, child: _buildTypeDropDownFormButton(_provider)),
            SizedBox(
                width: 150, child: buildGenderDropDownFormButton(_provider)),
            SizedBox(
                width: 150, child: buildLevelDropDownFormButton(_provider)),
            //deps
            Expanded(
              child: DropdownSearch<String>.multiSelection(
                dropdownDecoratorProps: DropDownDecoratorProps(
                    dropdownSearchDecoration: InputDecoration(
                  labelText: "Select Departments",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5)),
                )),
                items: [
                  'General',
                  'Computer Science',
                  'Software Development',
                  'Informataion Technologoy',
                  'Mobile Development',
                  'MultiMedia'
                ],
                onSaved: (values) {},
                onChanged: (values) {
                  // print(values);
                  values.forEach((element) {
                    switch (element) {
                      case 'General':
                        _provider.selectedDepartmentForm.add('G');
                        break;
                      case 'Computer Science':
                        _provider.selectedDepartmentForm.add('CS');
                        break;
                      case 'Software Development':
                        _provider.selectedDepartmentForm.add('SD');
                        break;
                      case 'Mobile Development':
                        _provider.selectedDepartmentForm.add('MO');
                        break;
                      case 'MultiMedia':
                        _provider.selectedDepartmentForm.add('MM');
                        break;
                    }
                  });
                  //  _provider.selectedDepartmentForm = values;
                },
              ),
            ),
            // buildDepartmentDropDownFormButton(_provider),
          ],
        ),
        Row(
          children: [
            Expanded(
                child: DropdownSearch<String>(
              popupProps: PopupProps.menu(
                showSelectedItems: true,
                showSearchBox: true,
              ),
              dropdownDecoratorProps: DropDownDecoratorProps(
                  dropdownSearchDecoration: InputDecoration(
                labelText: "Select Lecturer",
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
              )),
              items: _provider.lecturers.map((e) => e).toList(),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter lecturer name';
                }
                return null;
              },
              onChanged: (value) {
                _provider.selectedLecturer = value!;
              },
            )),
            // _buildTextFormField(
            //     label: 'Lecturer',
            //     controller: _provider.lecturerController,
            //     validator: (value) {
            //       if (value == null || value.isEmpty) {
            //         return 'Please enter lecturer name';
            //       }
            //       return null;
            //     }),
            SizedBox(
                width: 150,
                child: _buildClassRoomDropDownFormButton(_provider)),
            SizedBox(
              width: 150,
              child: _buildTextFormField(
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
            ),
            SizedBox(
              width: 150,
              child: _buildTextFormField(
                  label: 'Capacity',
                  controller: _provider.capacityController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Capacity';
                    }
                    return null;
                  }),
            ),
          ],
        )
      ],
    ),
  );
}

Widget buildGenderDropDownFormButton(InputSubjectsState provider) {
  return Container(
    height: 65,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: DropdownButtonFormField<String>(
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
          ),
          style: TextStyle(fontSize: 14, color: Colors.white),
          value: provider.selectedGenderForm,
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
  );
}

Widget buildLevelDropDownFormButton(InputSubjectsState provider) {
  return Container(
    height: 65,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: DropdownButtonFormField<String>(
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
          ),
          style: TextStyle(fontSize: 14, color: Colors.white),
          value: provider.selectedLevelForm,
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
  );
}

Widget _buildTypeDropDownFormButton(InputSubjectsState provider) {
  return Container(
    height: 65,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: DropdownButtonFormField<String>(
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
          ),
          style: TextStyle(fontSize: 14, color: Colors.white),
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
  );
}

Widget buildDepartmentDropDownFormButton(InputSubjectsState provider) {
  return SizedBox(
    width: 220,
    child: Container(
      height: 65,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: DropdownButtonFormField<String>(
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
            ),
            style: TextStyle(fontSize: 14, color: Colors.white),
            value: 'G',
            hint: Text('Department'),
            iconEnabledColor: Colors.amber,
            items: const [
              DropdownMenuItem(child: Text('General'), value: 'G'),
              DropdownMenuItem(child: Text('Computer Science'), value: 'CS'),
              DropdownMenuItem(
                  child: Text('Software Development'), value: 'SD'),
              DropdownMenuItem(
                  child: Text('Information Technology'), value: 'IT'),
              DropdownMenuItem(child: Text('Mobile Development'), value: 'MO'),
              DropdownMenuItem(child: Text('Multi Media'), value: 'MM'),
            ],
            onChanged: (x) {
              if (x == 'G') {
                provider.selectedLevel = '1';
                print(provider.selectedLevel);
              }
              provider.selectedDepartmentForm.clear();
              provider.selectedDepartmentForm.add(x.toString());
            }),
      ),
    ),
  );
}

Widget _buildClassRoomDropDownFormButton(InputSubjectsState provider) {
  return Container(
    height: 65,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: DropdownButtonFormField<String>(
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
          ),
          style: TextStyle(fontSize: 14, color: Colors.white),
          value: provider.selectedClassroom,
          hint: Text('ClassRoom'),
          iconEnabledColor: Colors.amber,
          items: const [
            DropdownMenuItem(
              value: 'k',
              child: Text('k'),
            ),
            DropdownMenuItem(
              value: 'l',
              child: Text('L'),
            ),
            DropdownMenuItem(
              value: 'iml',
              child: Text('iml'),
            ),
            DropdownMenuItem(
              value: 'imp',
              child: Text('imp'),
            ),
            DropdownMenuItem(
              value: 'ifp',
              child: Text('ifp'),
            ),
            DropdownMenuItem(
              value: 'ifl',
              child: Text('ifl'),
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
  );
}
