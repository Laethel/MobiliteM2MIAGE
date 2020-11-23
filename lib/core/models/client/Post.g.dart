// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostFromJson(Map<String, dynamic> json) {
  return Post(
    id: json['id'] as String,
    idEtablishment: json['idEtablishment'] as String,
    value: json['value'] as String,
    user: json['user'] == null
        ? null
        : User.fromJson(json['user'] as Map<String, dynamic>),
    date: json['date'] == null ? null : DateTime.parse(json['date'] as String),
  )..postResponses = (json['postResponses'] as List)
      ?.map((e) => e == null ? null : Post.fromJson(e as Map<String, dynamic>))
      ?.toList();
}

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      'id': instance.id,
      'idEtablishment': instance.idEtablishment,
      'value': instance.value,
      'postResponses':
          instance.postResponses?.map((e) => e?.toJson())?.toList(),
      'user': instance.user?.toJson(),
      'date': instance.date?.toIso8601String(),
    };
