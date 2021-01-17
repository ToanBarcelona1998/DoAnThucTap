import 'package:json_annotation/json_annotation.dart';
part 'feels_like.g.dart';
@JsonSerializable()
class FeelsLike{
  double day;
  double night;
  double eve;
  double morn;
  FeelsLike();
  factory FeelsLike.fromJson(Map map)=>_$FeelsLikeFromJson(map);
  toJson()=>_$FeelsLikeToJson(this);
}