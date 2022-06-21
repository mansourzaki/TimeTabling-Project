// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'classrooms.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Classrooms _$ClassroomsFromJson(Map<String, dynamic> json) => Classrooms(
      (json['l'] as List<dynamic>).map((e) => e as String).toList(),
      (json['k'] as List<dynamic>).map((e) => e as String).toList(),
      (json['im'] as List<dynamic>).map((e) => e as String).toList(),
      (json['if'] as List<dynamic>).map((e) => e as String).toList(),
      (json['n'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$ClassroomsToJson(Classrooms instance) =>
    <String, dynamic>{
      'l': instance.l,
      'k': instance.k,
      'im': instance.im,
      'if': instance.ifemale,
      'n': instance.n,
    };
