// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'classes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Classes _$ClassesFromJson(Map<String, dynamic> json) => Classes(
      subject: json['Subject'] as String,
      type: $enumDecode(_$TypesEnumMap, json['Type']),
      level: json['Level'] as String,
      department: (json['for'] as List<dynamic>)
          .map((e) => $enumDecode(_$DepartmentEnumMap, e))
          .toList(),
      lecturer: json['Lecturer'] as String,
      group: (json['Group'] as List<dynamic>).map((e) => e as String).toList(),
      classroom: json['Classroom'] as String,
      duration: json['Duration'] as String,
    );

Map<String, dynamic> _$ClassesToJson(Classes instance) => <String, dynamic>{
      'Subject': instance.subject,
      'Type': _$TypesEnumMap[instance.type],
      'Level': instance.level,
      'for': instance.department.map((e) => _$DepartmentEnumMap[e]).toList(),
      'Lecturer': instance.lecturer,
      'Group': instance.group,
      'Classroom': instance.classroom,
      'Duration': instance.duration,
    };

const _$TypesEnumMap = {
  Types.P: 'P',
  Types.V: 'V',
  Types.L: 'L',
};

const _$DepartmentEnumMap = {
  Department.G: 'G',
  Department.CS: 'CS',
  Department.SD: 'SD',
  Department.IT: 'IT',
  Department.MO: 'MO',
  Department.MM: 'MM',
};
