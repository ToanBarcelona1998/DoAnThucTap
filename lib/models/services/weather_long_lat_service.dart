import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:weather_vn_app/models/apis/base_weather_api.dart';
import 'package:weather_vn_app/models/apis/weather_api_lat_long.dart';
import 'package:weather_vn_app/models/entitys/daily.dart';

class WeatherLongLatService{
  BaseWeatherApi _api;
  Future<List<Daily>> getWeatherLongLat()async{
    List<Daily> listDaily;
    Location _location=Location();
    LocationData _data=await _location.getLocation();
    _api=WeatherApiLatLong(trungtuyen: _data.longitude,vituyen: _data.latitude);
    http.Response _response=await _api.getResponse();
    if(_response.statusCode==200){
      Map map=json.decode(_response.body);
      var list=map["daily"] as List;
      listDaily=list.map((e) => Daily.fromJson(e)).toList();
    }else{
      throw Exception("Không thể kết nối đến server");
    }
    return listDaily;
  }
}