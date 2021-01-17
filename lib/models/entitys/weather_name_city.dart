import 'package:json_annotation/json_annotation.dart';
import 'package:weather_vn_app/models/entitys/main.dart';
import 'package:weather_vn_app/models/entitys/sys_weather.dart';
import 'package:weather_vn_app/models/entitys/weather.dart';
part 'weather_name_city.g.dart';
@JsonSerializable()
class WeatherNameCity{
  List<Weather> weather;
  MainWeather main;
  int visibility;
  SysWeather sys;
  String name;
  WeatherNameCity();
  factory WeatherNameCity.fromJson(Map map)=>_$WeatherNameCityFromJson(map);
  toJson()=>_$WeatherNameCityToJson(this);
}