import 'package:json_annotation/json_annotation.dart';
part 'classrooms.g.dart';
@JsonSerializable()
class Classrooms {
  List<String> l = [];
  List<String> k = [];
  List<String> im = [];
  @JsonKey(name: 'if')
  List<String> ifemale = [];
  List<String> n = [];

  Classrooms(this.l, this.k, this.im, this.ifemale, this.n);

  factory Classrooms.fromJson(Map<String, dynamic> data) {
    return _$ClassroomsFromJson(data);
  }

  Map<String, dynamic> toJson() => _$ClassroomsToJson(this);
}
