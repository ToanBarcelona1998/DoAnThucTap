// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MainWeather _$MainWeatherFromJson(Map<String, dynamic> json) {
  return MainWeather()
    ..temp = (json['temp'] as num)?.toDouble()
    ..feels_like = (json['feels_like'] as num)?.toDouble()
    ..temp_min = (json['temp_min'] as num)?.toDouble()
    ..temp_max = (json['temp_max'] as num)?.toDouble()
    ..pressure = (json['pressure'] as num)?.toDouble()
    ..humidity = (json['humidity'] as num)?.toDouble();
}

Map<String, dynamic> _$MainWeatherToJson(MainWeather instance) =>
    <String, dynamic>{
      'temp': instance.temp,
      'feels_like': instance.feels_like,
      'temp_min': instance.temp_min,
      'temp_max': instance.temp_max,
      'pressure': instance.pressure,
      'humidity': instance.humidity,
    };
