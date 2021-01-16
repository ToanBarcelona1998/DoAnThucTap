
class WindWeather{
  double speed;
  double deg;
  WindWeather({this.speed,this.deg});
  fromJsonWind(Map map){
    this.speed=double.parse(map["speed"].toString().trim());
    this.deg=double.parse(map["deg"].toString().trim());
  }

}