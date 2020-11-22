// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'User.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    id: json['id'] as String,
    lastName: json['lastName'] as String,
    firstName: json['firstName'] as String,
    email: json['email'] as String,
    birthday: json['birthday'] == null
        ? null
        : DateTime.parse(json['birthday'] as String),
    createdOn: json['createdOn'] == null
        ? null
        : DateTime.parse(json['createdOn'] as String),
    gender: json['gender'] as String,
    location: json['location'] as String,
    favoriteThemes:
        (json['favoriteThemes'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'lastName': instance.lastName,
      'firstName': instance.firstName,
      'email': instance.email,
      'gender': instance.gender,
      'birthday': instance.birthday?.toIso8601String(),
      'createdOn': instance.createdOn?.toIso8601String(),
      'location': instance.location,
      'favoriteThemes': instance.favoriteThemes,
    };
