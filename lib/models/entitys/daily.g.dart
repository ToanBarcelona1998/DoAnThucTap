// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Daily _$DailyFromJson(Map<String, dynamic> json) {
  return Daily()
    ..dt = json['dt'] as int
    ..sunrise = json['sunrise'] as int
    ..sunset = json['sunset'] as int
    ..temp = json['temp'] == null
        ? null
        : Temp.fromJson(json['temp'] as Map<String, dynamic>)
    ..feelsLike = json['feels_like'] == null
        ? null
        : FeelsLike.fromJson(json['feels_like'] as Map<String, dynamic>)
    ..pressure = json['pressure'] as int
    ..humidity = json['humidity'] as int
    ..dew_point = (json['dew_point'] as num)?.toDouble()
    ..wind_speed = (json['wind_speed'] as num)?.toDouble()
    ..wind_deg = (json['wind_deg'] as num)?.toDouble()
    ..weather = (json['weather'] as List)
        ?.map((e) =>
            e == null ? null : Weather.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..clouds = json['clouds'] as int;
}

Map<String, dynamic> _$DailyToJson(Daily instance) => <String, dynamic>{
      'dt': instance.dt,
      'sunrise': instance.sunrise,
      'sunset': instance.sunset,
      'temp': instance.temp,
      'feelsLike': instance.feelsLike,
      'pressure': instance.pressure,
      'humidity': instance.humidity,
      'dew_point': instance.dew_point,
      'wind_speed': instance.wind_speed,
      'wind_deg': instance.wind_deg,
      'weather': instance.weather,
      'clouds': instance.clouds,
    };
