import 'package:weather_vn_app/models/entitys/main_weather.dart';
import 'package:weather_vn_app/models/entitys/sys_weather.dart';
import 'package:weather_vn_app/models/entitys/weather.dart';
import 'package:weather_vn_app/models/entitys/wind_weather.dart';

class DetailWeather{
  List<Weather> listInfo;
  MainWeather listMain;
  WindWeather listWind;
  SysWeather listSys;
  int timezone;
  String name;
  int visibility;
  fromJsonDetail(Map map){
    var listJsonWt=map["weather"] as List;
    List<Weather> listWt=listJsonWt.map((e) => Weather()..fromJsonInfo(e)).toList();
    this.listInfo=listWt;
    this.listMain=MainWeather()..fromJsonMain(map["main"]);
    this.listWind=WindWeather()..fromJsonWind(map["wind"]);
    this.listSys=SysWeather()..fromJsonSys(map["sys"]);
    this.timezone=int.parse(map["timezone"].toString().trim());
    this.name=map["name"];
    this.visibility=int.parse(map["visibility"].toString().trim());
  }
}