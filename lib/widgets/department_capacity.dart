import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../constants.dart';

class DepartmentCapacityTextField extends StatefulWidget {
  final String capacity;
  final String name;
  const DepartmentCapacityTextField(
      {Key? key, required this.name, required this.capacity})
      : super(key: key);

  @override
  State<DepartmentCapacityTextField> createState() =>
      _DepartmentCapacityTextFieldState();
}

class _DepartmentCapacityTextFieldState
    extends State<DepartmentCapacityTextField> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(widget.name),
        SizedBox(
          width: 25,
        ),
        SizedBox(
          width: 150,
          child: TextFormField(
            initialValue: widget.capacity,
            readOnly: true,
            onChanged: (value) {},
            decoration: const InputDecoration(
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
    );
  }
}
