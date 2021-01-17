import 'package:rxdart/rxdart.dart';
import 'package:weather_vn_app/models/entitys/daily.dart';
import 'package:weather_vn_app/models/services/weather_long_lat_service.dart';

class WeatherBloc{
  PublishSubject<List<Daily>> _publishSubject=PublishSubject();
  Stream get stream=>_publishSubject.stream;

  getWeatherLongLat()async{
    List<Daily> list=await WeatherLongLatService().getWeatherLongLat();
    _publishSubject.sink.add(list);
  }
}