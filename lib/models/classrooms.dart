import 'package:json_annotation/json_annotation.dart';
part 'classrooms.g.dart';

@JsonSerializable()
class Classrooms {
  List<String> l = [];
  List<String> k = [];
  List<String> iml = [];
  List<String> imp = [];
  List<String> ifl = [];
  List<String> ifp = [];
  List<String> n = [];

  Classrooms(this.l, this.k, this.iml, this.imp, this.ifl, this.ifp, this.n);

  factory Classrooms.fromJson(Map<String, dynamic> data) {
    return _$ClassroomsFromJson(data);
  }

  Map<String, dynamic> toJson() => _$ClassroomsToJson(this);
}
