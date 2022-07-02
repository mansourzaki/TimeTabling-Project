// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subject.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Subject _$SubjectFromJson(Map<String, dynamic> json) => Subject(
      subject: json['Subject'] as String,
      type: $enumDecode(_$TypesEnumMap, json['Type']),
      level: json['Level'] as String,
      department: (json['for'] as List<dynamic>)
          .map((e) => $enumDecode(_$DepartmentEnumMap, e))
          .toList(),
      lecturer:
          (json['Lecturer'] as List<dynamic>).map((e) => e as String).toList(),
      classroom:
          (json['Classroom'] as List<dynamic>).map((e) => e as String).toList(),
      duration: json['Duration'] as String,
      capacity: json['Capacity'] as int,
      forGroup: (json['For_Group'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      group: json['Group'] as String,
      assignedClassroom: json['assigned_classroom'] as String,
      assignedTime: json['assigned_time'],
    );

Map<String, dynamic> _$SubjectToJson(Subject instance) => <String, dynamic>{
      'Subject': instance.subject,
      'Type': _$TypesEnumMap[instance.type],
      'Level': instance.level,
      'for': instance.department.map((e) => _$DepartmentEnumMap[e]).toList(),
      'Lecturer': instance.lecturer,
      'Group': instance.group,
      'Classroom': instance.classroom,
      'Duration': instance.duration,
      'For_Group': instance.forGroup,
      'assigned_classroom': instance.assignedClassroom,
      'Capacity': instance.capacity,
      'assigned_time': instance.assignedTime,
    };

const _$TypesEnumMap = {
  Types.P: 'P',
  Types.V: 'V',
  Types.L: 'L',
};

const _$DepartmentEnumMap = {
  Department.Gm: 'Gm',
  Department.MM_1m: 'MM_1m',
  Department.MO_1m: 'MO_1m',
  Department.CS_2m: 'CS_2m',
  Department.SD_2m: 'SD_2m',
  Department.IT_2m: 'IT_2m',
  Department.MM_2m: 'MM_2m',
  Department.MO_2m: 'MO_2m',
  Department.CS_3m: 'CS_3m',
  Department.SD_3m: 'SD_3m',
  Department.IT_3m: 'IT_3m',
  Department.MM_3m: 'MM_3m',
  Department.MO_3m: 'MO_3m',
  Department.CS_4m: 'CS_4m',
  Department.SD_4m: 'SD_4m',
  Department.IT_4m: 'IT_4m',
  Department.MM_4m: 'MM_4m',
  Department.MO_4m: 'MO_4m',
  Department.Gf: 'Gf',
  Department.MM_1f: 'MM_1f',
  Department.MO_1f: 'MO_1f',
  Department.CS_2f: 'CS_2f',
  Department.SD_2f: 'SD_2f',
  Department.IT_2f: 'IT_2f',
  Department.MM_2f: 'MM_2f',
  Department.MO_2f: 'MO_2f',
  Department.CS_3f: 'CS_3f',
  Department.SD_3f: 'SD_3f',
  Department.IT_3f: 'IT_3f',
  Department.MM_3f: 'MM_3f',
  Department.MO_3f: 'MO_3f',
  Department.CS_4f: 'CS_4f',
  Department.SD_4f: 'SD_4f',
  Department.IT_4f: 'IT_4f',
  Department.MM_4f: 'MM_4f',
  Department.MO_4f: 'MO_4f',
};
