import 'package:json_annotation/json_annotation.dart';
import 'package:mobilitem2miage/core/models/client/User.dart';

part 'Post.g.dart';

@JsonSerializable(explicitToJson: true)
class Post {

  String id;

  String idEtablishment;

  String value;

  List<Post> postResponses;

  User user;

  DateTime date;

  Post({this.id, this.idEtablishment, this.value, this.postResponses, this.user, this.date});

  factory Post.fromJson(Map<String,dynamic> data) => _$PostFromJson(data);

  Map<String, dynamic> toJson() => _$PostToJson(this);
}