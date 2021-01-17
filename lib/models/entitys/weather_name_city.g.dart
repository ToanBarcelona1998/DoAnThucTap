// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_name_city.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherNameCity _$WeatherNameCityFromJson(Map<String, dynamic> json) {
  return WeatherNameCity()
    ..weather = (json['weather'] as List)
        ?.map((e) =>
            e == null ? null : Weather.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..main = json['main'] == null
        ? null
        : MainWeather.fromJson(json['main'] as Map<String, dynamic>)
    ..visibility = json['visibility'] as int
    ..sys = json['sys'] == null
        ? null
        : SysWeather.fromJson(json['sys'] as Map<String, dynamic>)
    ..name = json['name'] as String;
}

Map<String, dynamic> _$WeatherNameCityToJson(WeatherNameCity instance) =>
    <String, dynamic>{
      'weather': instance.weather,
      'main': instance.main,
      'visibility': instance.visibility,
      'sys': instance.sys,
      'name': instance.name,
    };
