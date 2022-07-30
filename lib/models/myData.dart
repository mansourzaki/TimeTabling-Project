import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:timetabling/constants.dart';
import 'package:timetabling/models/input_subject_state.dart';
import 'package:provider/provider.dart';
import 'classes.dart';

class MyData extends DataTableSource {
  final List<Classes> _allClasses;
  final InputSubjectsState provider;
  bool _isEditable = false;
  Function saveCallBackFunction;
  BuildContext context;
  // List<Widget> fields = [
  // DataCell(
  //   Text(index.toString()),
  // ),
  // DataCell(_buildTextField(_allClasses[index].subject)),
  // DataCell(_buildTextField((_allClasses[index].getType().toString()))),
  // DataCell(_buildTextField(_allClasses[index].level)),
  // DataCell(_buildTextField(_allClasses[index].getDepartment().toString())),
  // DataCell(_buildTextField(_allClasses[index].lecturer[0])),
  // DataCell(_buildTextField(_allClasses[index].capacity.toString())),
  // DataCell(_buildTextField(_allClasses[index].classroom.toString())),
  // DataCell(_buildTextField(_allClasses[index].duration)),
  // DataCell(IconButton(onPressed: () {}, icon: const Icon(Icons.save))),
  // ];
  MyData(
      this._allClasses, this.provider, this.saveCallBackFunction, this.context);

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
    return _allClasses[index].capacity == 0
        ? DataRow(cells: [
            DataCell(
              Text(index.toString()),
            ),
            DataCell(_buildTextField(_allClasses[index].subject)),
            DataCell(
                _buildTextField((_allClasses[index].getType().toString()))),
            DataCell(_buildNumTextField(_allClasses[index].level)),
            DataCell(_buildDepartmentDropDown()),
            DataCell(_buildTextField(_allClasses[index].lecturer[0])),
            DataCell(_buildTextField(_allClasses[index].capacity.toString())),
            DataCell(_buildTextField(_allClasses[index].classroom.toString())),
            DataCell(_buildTextField(_allClasses[index].duration)),
            DataCell(IconButton(
                onPressed: () {
                  _allClasses[index].capacity = 50;
                  saveCallBackFunction();
                },
                icon: const Icon(Icons.save))),
          ])
        : DataRow(
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
                DataCell(
                  _isEditable
                      ? _buildTextField(_allClasses[index].subject)
                      : Text(_allClasses[index].subject),
                ),
                DataCell(Text(_allClasses[index].getType().toString())),
                DataCell(Text(_allClasses[index].level)),
                DataCell(Text(_allClasses[index].getDepartment().toString())),
                DataCell(SelectableText(_allClasses[index].lecturer[0])),
                DataCell(Text(_allClasses[index].capacity.toString())),
                DataCell(Text(_allClasses[index].classroom.toString())),
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
        decoration: InputDecoration(fillColor: primaryColor),
        // decoration: InputDecoration(
        //     border: OutlineInputBorder(
        //   borderRadius: BorderRadius.circular(8),
        // )),
      ),
    );
  }

  Padding _buildNumTextField(String text) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: TextFormField(
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly
        ],
        initialValue: text,
        // style: TextStyle(fontSize: 12),
        decoration: InputDecoration(fillColor: primaryColor),
        // decoration: InputDecoration(
        //     border: OutlineInputBorder(
        //   borderRadius: BorderRadius.circular(8),
        // )),
      ),
    );
  }

  Widget _buildDepartmentDropDown() {
    return DropdownButton<String>(
        borderRadius: BorderRadius.circular(15),
        autofocus: false,
        dropdownColor: secondaryColor,
        underline: SizedBox(),
        value: 'G',
        items: [
          DropdownMenuItem(child: Text('General'), value: 'G'),
          DropdownMenuItem(child: Text('Computer Science'), value: 'CS'),
          DropdownMenuItem(child: Text('Software Development'), value: 'SD'),
          DropdownMenuItem(child: Text('Information Technology'), value: 'IT'),
          DropdownMenuItem(child: Text('Mobile Development'), value: 'MO'),
          DropdownMenuItem(child: Text('Multi Media'), value: 'MM'),
        ],
        onChanged: (value) {
          provider.subDeps = [];
        });
  }

  Widget _buildLevelDropDown() {
    return DropdownButton<String>(
        borderRadius: BorderRadius.circular(15),
        autofocus: false,
        dropdownColor: secondaryColor,
        underline: SizedBox(),
        value: context.watch<InputSubjectsState>().subLevel.toString(),
        items: [
          DropdownMenuItem(child: Text('1'), value: '1'),
          DropdownMenuItem(child: Text('2'), value: '2'),
          DropdownMenuItem(child: Text('3'), value: '3'),
          DropdownMenuItem(child: Text('4'), value: '4'),
        ],
        onChanged: (value) {
          print(value);
          context.read<InputSubjectsState>().subLevel = value!;
        });
  }
}
