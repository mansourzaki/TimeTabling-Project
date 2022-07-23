import 'package:flutter/material.dart';
import 'package:timetabling/models/input_subject_state.dart';

import 'classes.dart';

class MyData2 extends DataTableSource {
  final List<Classes> _allClasses;
  final InputSubjectsState provider;
  bool _isEditable = false;
  String _selectedLecturer = '';

  MyData2(this._allClasses, this.provider);

  void sort<T>(
      Comparable<T> Function(Classes classe) getField, bool ascending) {
    _allClasses.sort(((a, b) {
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
  int get rowCount => _allClasses.length;

  @override
  int get selectedRowCount => 0;

  @override
  DataRow? getRow(int index) {
    _selectedLecturer = _allClasses[index].lecturer.first;
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
          provider.subjectController.text = _allClasses[index].subject;
          provider.selectedType = _allClasses[index].getType();
          provider.subjectController.text = _allClasses[index].subject;
          provider.subjectController.text = _allClasses[index].subject;
          provider.subjectController.text = _allClasses[index].subject;
          provider.subjectController.text = _allClasses[index].subject;
          notifyListeners();
        },
        cells: [
          DataCell(
            Text(index.toString()),
          ),
          DataCell(DropdownButtonFormField<String>(
            onChanged: (value) {
              _selectedLecturer = value!;
            },
            value: _selectedLecturer,
            items: _allClasses[index]
                .lecturer
                .map((e) => DropdownMenuItem<String>(
                      value: e,
                      child: Text(e),
                    ))
                .toList(),
          )),
          DataCell(
            _isEditable
                ? _buildTextField(_allClasses[index].subject)
                : Text(_allClasses[index].subject),
          ),
          DataCell(Text(_allClasses[index].getDepartment().toString())),
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
