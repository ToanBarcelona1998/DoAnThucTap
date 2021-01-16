import 'package:rxdart/rxdart.dart';
import 'package:weather_vn_app/models/entitys/detail_weather.dart';
import 'package:weather_vn_app/models/services/weather_long_lat_service.dart';

class WeatherBloc{
  PublishSubject<DetailWeather> _publishSubject=PublishSubject();
  Stream get stream=>_publishSubject.stream;

  getWeatherLongLat()async{
    DetailWeather weather=await WeatherLongLatService().getWeatherLongLat();
    _publishSubject.sink.add(weather);
  }
}