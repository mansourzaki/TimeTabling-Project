import 'package:flutter/material.dart';
import 'package:timetabling/models/subjectsState.dart';

import 'classes.dart';

class MyData extends DataTableSource {
  final List<Classes> _allClasses;
  final InputSubjectsState provider;
  bool _isEditable = false;
  MyData(this._allClasses, this.provider);

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
    return DataRow(
        //key: ObjectKey(_allClasses[index]),
        onLongPress: () {
          _isEditable = !_isEditable;
          notifyListeners();
        },
        cells: [
          DataCell(
            Text(index.toString()),
          ),
          DataCell(
            _isEditable
                ? _buildTextField(_allClasses[index].subject)
                : Text(_allClasses[index].subject),
          ),
          DataCell(Text(_allClasses[index].getType().toString())),
          DataCell(Text(_allClasses[index].level)),
          DataCell(Text(_allClasses[index].getDepartment().toString())),
          DataCell(Text(_allClasses[index].lecturer)),
          DataCell(Text(_allClasses[index].group.toString())),
          DataCell(Text(_allClasses[index].classroom)),
          DataCell(Text(_allClasses[index].duration)),
          // DataCell(IconButton(
          //     onPressed: () {
          //       // _isEditable = !_isEditable;
          //       // notifyListeners();
          //     },
          //     icon: !_isEditable
          //         ? const Icon(Icons.edit)
          //         : const Icon(Icons.save))),
          DataCell(IconButton(
              onPressed: () {
                provider.deleteClass(index, _allClasses[index]);
              },
              icon: const Icon(Icons.delete))),
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
