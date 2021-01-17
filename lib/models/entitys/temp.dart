import 'package:json_annotation/json_annotation.dart';
part 'temp.g.dart';
@JsonSerializable()
class Temp{
  double day;
  double min;
  double max;
  double night;
  double eve;
  double morn;
  Temp();
  factory Temp.fromJson(Map map)=>_$TempFromJson(map);
  toJson()=>_$TempToJson(this);
}