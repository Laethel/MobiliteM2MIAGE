import 'package:json_annotation/json_annotation.dart';

part 'Theme.g.dart';

@JsonSerializable()
class Theme {

  String label;

  Theme({this.label});

  factory Theme.fromJson(Map<String,dynamic> data) => _$ThemeFromJson(data);

  Map<String, dynamic> toJson() => _$ThemeToJson(this);
}