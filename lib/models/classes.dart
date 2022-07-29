import 'dart:math';

import 'package:json_annotation/json_annotation.dart';
import 'package:timetabling/models/subject.dart';
part 'classes.g.dart';

extension ParseToString on Enum {
  String toShortString() {
    return toString().split('.').last;
  }
}

@JsonSerializable()
class Classes {
  @JsonKey(name: 'Subject')
  String subject;
  @JsonKey(name: 'Type')
  Types type;
  @JsonKey(name: 'Level')
  String level;
  @JsonKey(name: 'for')
  List<Department> department;
  @JsonKey(name: 'Lecturer')
  List<String> lecturer;
  @JsonKey(name: 'Classroom')
  dynamic classroom;
  @JsonKey(name: 'Duration')
  String duration;
  @JsonKey(name: 'Capacity')
  int capacity;
  @JsonKey(name: 'For_Group')
  List<String>? forGroup;
  @JsonKey(name: 'Group')
  String? group;
  Classes(
      {required this.subject,
      required this.type,
      required this.level,
      required this.department,
      required this.lecturer,
      required this.classroom,
      required this.duration,
      required this.capacity,
      this.forGroup,
      this.group});

  factory Classes.fromJson(Map<String, dynamic> data) {
    return _$ClassesFromJson(data);
  }

  factory Classes.emptyClass() {
    return Classes(
        subject: 'Subject Name',
        type: Types.L,
        level: '0',
        department: [Department.Gm],
        lecturer: ['Lecturer Name'],
        capacity: 0,
        classroom: ['k'],
        duration: '0',
        group: '',
        forGroup: []);
  }

  Map<String, dynamic> toJson() => _$ClassesToJson(this);

  Map<String, dynamic> toMap() => {
        '"Subject"': '"$subject"',
        '"Type"': '"${type.toString().split('.').last}"',
        '"Level"': '"$level"',
        '"for"': getDepartmentsForMap(department),
        '"Lecturer"': getLecturersForMap(lecturer),
        '"capacity"': '$capacity',
        '"Classroom"': getClassroomForMap(classroom),
        '"Duration"': '"$duration"',
        '"Group"': '"$group"',
        '"For_Group"':
            forGroup == null ? '$forGroup' : getForGroupForMap(forGroup!)
        //  forGroup == null ? '"$forGroup"' : getForGroupForMap(forGroup!)
      };

  List<String> getLecturersForMap(List<String> lec) {
    List<String> x = [];
    lec.forEach((element) {
      x.add('"$element"');
    });
    return x;
  }

  List<String> getDepartmentsForMap(List<Department> deps) {
    List<String> x = [];
    deps.forEach((element) {
      String dep = element.toString().split('.').last;
      x.add('"$dep"');
    });
    return x;
  }

  List<String> getClassroomForMap(dynamic classrooms) {
    List<String> y = List<String>.from(classrooms as List);

    List<String> x = [];

    y.forEach((element) {
      x.add('"$element"');
    });
    return x;
  }

  List<String> getForGroupForMap(List<String> forGroup) {
    List<String> x = [];
    forGroup.forEach((element) {
      x.add('"$element"');
    });
    return x;
  }

  List<String> getDepartment() {
    return department.map((e) => e.toString().split('.').last).toList();
  }

  String getType() {
    return type.toString().split('.').last;
  }
}
