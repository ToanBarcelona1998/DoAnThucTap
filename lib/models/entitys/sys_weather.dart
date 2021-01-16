class SysWeather{
  int type;
  int id;
  String country;
  int sunrise;
  int sunset;
  fromJsonSys(Map<dynamic,dynamic> map){
    this.type=int.parse(map["type"].toString().trim());
    this.id=int.parse(map["id"].toString().trim());
    this.country=map["country"];
    this.sunrise=int.parse(map["sunrise"].toString().trim());
    this.sunset=int.parse(map["sunset"].toString().trim());
  }
}