import 'package:http/http.dart' as http;

abstract class BaseWeatherApi{
  String domain="https://api.openweathermap.org/data/2.5/onecall?";
  String exclude="exclude=hourly,current,minutely,alerts";
  lat();
  lon();
  String dauva="&";
  String ApiKey="2fdac9584afb2d9ad8a2bd7a6ba08329";
  String lang="lang=vi";

  getResponse()async{
    String url=domain+"lat="+lat()+dauva+"lon="+lon()+dauva+exclude+dauva+"appid="+ApiKey+dauva+lang+dauva+"units=metric";
    http.Response response=await http.get(url);
    return response;
  }
}