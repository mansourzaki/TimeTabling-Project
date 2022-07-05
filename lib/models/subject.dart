import 'package:json_annotation/json_annotation.dart';
import 'package:timetabling/shared/constants.dart';
part 'subject.g.dart';

enum Types { P, V, L }

enum Department {
  Gm,
  MM_1m,
  MO_1m,
  CS_2m,
  SD_2m,
  IT_2m,
  MM_2m,
  MO_2m,
  CS_3m,
  SD_3m,
  IT_3m,
  MM_3m,
  MO_3m,
  CS_4m,
  SD_4m,
  IT_4m,
  MM_4m,
  MO_4m,
  Gf,
  MM_1f,
  MO_1f,
  CS_2f,
  SD_2f,
  IT_2f,
  MM_2f,
  MO_2f,
  CS_3f,
  SD_3f,
  IT_3f,
  MM_3f,
  MO_3f,
  CS_4f,
  SD_4f,
  IT_4f,
  MM_4f,
  MO_4f,
}

@JsonSerializable()
class Subject {
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
  @JsonKey(name: 'Group')
  String group;
  @JsonKey(name: 'Classroom')
  List<String> classroom;
  @JsonKey(name: 'Duration')
  String duration;
  @JsonKey(name: 'For_Group')
  List<String>? forGroup;
  @JsonKey(name: 'assigned_classroom')
  String assignedClassroom;
  @JsonKey(name: 'Capacity')
  int capacity;
  @JsonKey(name: 'assigned_time')
  dynamic assignedTime;

  Subject(
      {required this.subject,
      required this.type,
      required this.level,
      required this.department,
      required this.lecturer,
      required this.classroom,
      required this.duration,
      required this.capacity,
      this.forGroup,
      required this.group,
      required this.assignedClassroom,
      required this.assignedTime});

  factory Subject.fromJson(Map<String, dynamic> data) {
    // if (data['assigned_time'].runtimeType is int) {
    //   print('jssommmm');
    //   print('In From json ${data['assigned_time']}');
    //   data['assigned_time'] = [data['assigned_time']];
    // }
    return _$SubjectFromJson(data);
  }

  Map<String, dynamic> toJson() => _$SubjectToJson(this);

  String getDayFromInt(int x) {
    if (x >= 0 && x < 16) {
      print('Saturday');
      return 'Saturday';
    } else if (x >= 16 && x < 32) {
      print('Sunday');
      return 'Sunday';
    } else if (x >= 32 && x < 48) {
      print('Monday');
      return 'Monday';
    } else if (x >= 48 && x < 64) {
      print('Tuesday');
      return 'Tuesday';
    } else if (x >= 64 && x < 80) {
      print('Wednesday');
      return 'Wednesday';
    } else {
      print('Error in finding the day');
      return 'ggs';
    }
  }

  String get getTime {
    List<int> periods = [0, 16, 32, 48, 64, 76];

    //change runtype == int
    if (assignedTime.length == 1) {
      int startPoint = 0;
      int x = assignedTime[0];
      periods.forEach((element) {
        if (x >= element) {
          startPoint = element;
        }
      });

      double y = x - startPoint as double;
      double mul = y * 0.5;

      double startTime = mul + 8;
      double endTime = startTime + double.parse(duration);
      //converting 0.5 to :30
      String start =
          startTime % 1 == 0 ? '$startTime:00' : '${startTime.floor()}:30';
      String end = endTime % 1 == 0 ? '$endTime:00' : '${endTime.floor()}:30';
      return '$start - $end';
      // print('Time is ${mul + 8}');
      // print('$startPoint fffff');
    } else if (assignedTime is List) {
      List<dynamic> list = assignedTime;
      List<dynamic> days = [];
      int x = list[0] as int;
      int startPoint = 0;
      periods.forEach((element) {
        if (x >= element) {
          startPoint = element;
        }
      });
      double y = x - startPoint as double;
      double mul = y * 0.5;
      double startTime = mul + 8;

      if (list.length == 3 && duration == '3') {
        double endTime = startTime + 1;
        //converting 0.5 to :30
        String start =
            startTime % 1 == 0 ? '$startTime:00' : '${startTime.floor()}:30';
        String end = endTime % 1 == 0 ? '$endTime:00' : '${endTime.floor()}:30';
        return '$start - $end';
        //return '$startTime - $endTime';
      } else if (list.length == 2 && duration == '3') {
        double endTime = startTime + 1.5;
        // return '$startTime - $endTime';
        //converting 0.5 to :30
        String start =
            startTime % 1 == 0 ? '$startTime:00' : '${startTime.floor()}:30';
        String end = endTime % 1 == 0 ? '$endTime:00' : '${endTime.floor()}:30';
        return '$start - $end';
      }
      //need to check this
      else if (list.length == 2 && duration == '2') {
        double endTime = startTime + 1;
        String start =
            startTime % 1 == 0 ? '$startTime:00' : '${startTime.floor()}:30';
        String end = endTime % 1 == 0 ? '$endTime:00' : '${endTime.floor()}:30';
        return '$start - $end';
      } else {
        print('list length $list');
        return 'not conditioned';
      }
    } else {
      return '0.0';
    }
  }

  int daysNum() {
    int x = 0;
    if (getDays.length == 1) {
      switch (getDays[0]) {
        case saturday:
          x = 1;
          break;
        case sunday:
          x = 2;
          break;
        case monday:
          x = 3;
          break;
        case tuesday:
          x = 4;
          break;
        case wednesday:
          x = 5;
          break;
      }
    } else if (getDays.length == 2) {
      x = 22;
      return x;
    } else {
      x = 33;
      return x;
    }
    return x;
  }

  List<dynamic> get getDays {
    // print('get All' + assignedTime.toString());
    if (assignedTime.runtimeType == int) {
      int x = assignedTime;
      return [getDayFromInt(x)];
    } else if (assignedTime is List) {
      List<dynamic> list = assignedTime;
      List<dynamic> days = [];
      for (int i = 0; i < list.length; i++) {
        days.add(getDayFromInt(list[i]));
      }
      return days;
    } else {
      // print('in else' + assignedTime.toString());
      return ['error'];
    }
  }
}
