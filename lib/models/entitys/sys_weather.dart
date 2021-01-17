import 'package:json_annotation/json_annotation.dart';
part 'sys_weather.g.dart';
@JsonSerializable()
class SysWeather{
  int type;
  int id;
  String country;
  int sunrise;
  int sunset;
  SysWeather();
  factory SysWeather.fromJson(Map map)=>_$SysWeatherFromJson(map);
  toJson()=>_$SysWeatherToJson(this);
}