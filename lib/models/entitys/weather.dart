import 'package:json_annotation/json_annotation.dart';
part 'weather.g.dart';
@JsonSerializable()
class Weather{
  int id;
  String main;
  String description;
  String icon;
  Weather();
  factory Weather.fromJson(Map map)=>_$WeatherFromJson(map);
  toJson()=>_$WeatherToJson(this);
}