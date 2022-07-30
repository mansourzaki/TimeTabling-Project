import 'dart:js';

import 'package:flutter/material.dart';
import 'package:timetabling/models/input_subject_state.dart';
import 'package:timetabling/models/subject.dart';
import 'classes.dart';

class MyData2 extends DataTableSource {
  final InputSubjectsState provider;
  bool _isEditable = false;
  String _selectedLecturer = '';
  List<String> selectedLec = [];
  MyData2(this.provider) {
    // provider.finalClassesAfterSelection.clear();
    // provider.finalClassesAfterSelection = [...provider.multipleLecturers];
    // provider.finalClassesAfterSelection.forEach((element) {
    //   selectedLec.add(element.lecturer.first);
    // });
    print('cleared andd added');
  }

  void sort<T>(
      Comparable<T> Function(Classes classe) getField, bool ascending) {
    provider.finalClassesAfterSelection.sort(((a, b) {
      final aValue = getField(a);
      final bValue = getField(b);
      return ascending
          ? Comparable.compare(aValue, bValue)
          : Comparable.compare(bValue, aValue);
    }));
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => provider.finalClassesAfterSelection.length;

  @override
  int get selectedRowCount => 0;

  @override
  DataRow? getRow(int index) {
    // _selectedLecturer =
    //     provider.finalClassesAfterSelection[index].lecturer.first;
    // i = provider.secondInput.indexOf(provider.multipleLecturers[index]);
    return DataRow(
        //key: ObjectKey(_allClasses[index]),
        color: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return Colors.yellow;
          } else {
            return null;
          }
        }),
        onLongPress: () {
          provider.subjectController.text =
              provider.finalClassesAfterSelection[index].subject;
          provider.selectedType =
              provider.finalClassesAfterSelection[index].getType();
          provider.subjectController.text =
              provider.finalClassesAfterSelection[index].subject;
          provider.subjectController.text =
              provider.finalClassesAfterSelection[index].subject;
          provider.subjectController.text =
              provider.finalClassesAfterSelection[index].subject;
          provider.subjectController.text =
              provider.finalClassesAfterSelection[index].subject;
          notifyListeners();
        },
        cells: [
          DataCell(
            Text(index.toString()),
          ),
          DataCell(DropdownButtonFormField<String>(
            onChanged: (value) {
              //  _selectedLecturer = value!;
              // int indexOfsecondInput = provider.secondInput
              //     .indexOf(provider.multipleLecturers[index]);
              // Classes cls = provider.secondInput.elementAt(indexOfsecondInput);
              // int mulIndex = provider.multipleLecturers
              //     .indexOf(cls);
              // provider.finalClassesAfterSelection
              //     .remove(provider.multipleLecturers[index]);
              String first =
                  provider.finalClassesAfterSelection[index].lecturer.first;
              int place1 = provider.finalClassesAfterSelection[index].lecturer
                  .indexOf(value!);
              print('first' + first);
              print('new' + value);
              provider.finalClassesAfterSelection[index].lecturer[0] = value;
              provider.finalClassesAfterSelection[index].lecturer[place1] =
                  first;
              _selectedLecturer = first;
              // selectedLec[index] = value;
              // provider.finalClassesAfterSelection
              //     .add(provider.secondInput[index]);
              // provider.finalClassesAfterSelection[index].lecturer = [value];
              // Classes cls = Classes.fromJson(_allClasses[index].toJson());
              //  cls.lecturer = [value];
              // _allClasses[index].lecturer = [value];

              // print('removed');
              // provider.finalClassesAfterSelection
              //     .add(provider.secondInput[index]);
              print(provider.finalClassesAfterSelection[index].lecturer);
              print('added to final');
              print(provider.finalClassesAfterSelection[index].lecturer.first);
            },
            value: provider.finalClassesAfterSelection[index].lecturer.first,
            items: provider.finalClassesAfterSelection[index].lecturer
                .map((e) => DropdownMenuItem<String>(
                      value: e,
                      child: Text(e),
                    ))
                .toList(),
          )),
          DataCell(
            _isEditable
                ? _buildTextField(
                    provider.finalClassesAfterSelection[index].subject)
                : Text(provider.finalClassesAfterSelection[index].subject),
          ),
          DataCell(Text(
              provider.finalClassesAfterSelection[index].group.toString())),
          DataCell(Text(provider.finalClassesAfterSelection[index].type ==
                  Types.V
              ? provider.finalClassesAfterSelection[index].department[0]
                      .toShortString() + ' ' + 
                  provider.finalClassesAfterSelection[index].group.toString()
              : provider.finalClassesAfterSelection[index].forGroup
                  .toString())),
          DataCell(Text(provider.finalClassesAfterSelection[index]
              .getDepartment()
              .toString())),
        ]);
  }

  Padding _buildTextField(String text) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: TextFormField(
        initialValue: text,
        // style: TextStyle(fontSize: 12),
        // decoration: InputDecoration(
        //     border: OutlineInputBorder(
        //   borderRadius: BorderRadius.circular(8),
        // )),
      ),
    );
  }
}
