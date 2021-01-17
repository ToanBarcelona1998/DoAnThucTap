import 'package:json_annotation/json_annotation.dart';
import 'package:weather_vn_app/models/entitys/feels_like.dart';
import 'package:weather_vn_app/models/entitys/temp.dart';
import 'package:weather_vn_app/models/entitys/weather.dart';
part 'daily.g.dart';
@JsonSerializable()
class Daily{
  int dt;
  int sunrise;
  int sunset;
  Temp temp;
  FeelsLike feelsLike;
  int pressure;
  int humidity;
  double dew_point;
  double wind_speed;
  double wind_deg;
  List<Weather> weather;
  int clouds;
  Daily();
  factory Daily.fromJson(Map map)=>_$DailyFromJson(map);
  toJson()=>_$DailyToJson(this);

}