import 'package:json_annotation/json_annotation.dart';
part 'main.g.dart';
@JsonSerializable()
class MainWeather{
  double temp;
  double feels_like;
  double temp_min;
  double temp_max;
  double pressure;
  double humidity;
  MainWeather();
  factory MainWeather.fromJson(Map map)=>_$MainWeatherFromJson(map);
  toJson()=>_$MainWeatherToJson(this);
}