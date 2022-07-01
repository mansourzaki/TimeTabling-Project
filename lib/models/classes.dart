import 'package:json_annotation/json_annotation.dart';
import 'package:timetabling/models/subject.dart';
part 'classes.g.dart';

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
  String lecturer;
  @JsonKey(name: 'Capacity')
  int capacity;
  @JsonKey(name: 'Classroom')
  String classroom;
  @JsonKey(name: 'Duration')
  String duration;
  Classes({
    required this.subject,
    required this.type,
    required this.level,
    required this.department,
    required this.lecturer,
    required this.capacity,
    required this.classroom,
    required this.duration,
  });

  factory Classes.fromJson(Map<String, dynamic> data) {
    return _$ClassesFromJson(data);
  }

  factory Classes.emptyClass() {
    return Classes(
        subject: 'Subject Name',
        type: Types.L,
        level: '0',
        department: [Department.Gm],
        lecturer: 'Lecturer Name',
        capacity: 0,
        classroom: 'k',
        duration: '0');
  }

  Map<String, dynamic> toJson() => _$ClassesToJson(this);

  List<String> getDepartment() {
    return department.map((e) => e.toString().split('.').last).toList();
  }

  String getType() {
    return type.toString().split('.').last;
    
  }
}
