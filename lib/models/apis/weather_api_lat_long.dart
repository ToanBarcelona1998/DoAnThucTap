import 'package:weather_vn_app/models/apis/base_weather_api.dart';

class WeatherApiLatLong extends BaseWeatherApi{
  double vituyen,trungtuyen;
  WeatherApiLatLong({this.vituyen,this.trungtuyen});
  @override
  lat() {
    return vituyen.toString();
  }

  @override
  lon() {
    // TODO: implement lon
    return trungtuyen.toString();
  }

}