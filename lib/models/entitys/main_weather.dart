class MainWeather{
  double temp;
  double feels_like;
  double temp_min;
  double temp_max;
  double pressure;
  double humidity;
  MainWeather({this.temp,this.feels_like,this.temp_min,this.temp_max,this.pressure,this.humidity});
  fromJsonMain(Map<dynamic,dynamic> map){
    this.temp=double.parse(map["temp"].toString().trim());
    this.feels_like=double.parse(map["feels_like"].toString().trim());
    this.temp_min=double.parse(map["temp_min"].toString().trim());
    this.temp_max=double.parse(map["temp_max"].toString().trim());
    this.pressure=double.parse(map["pressure"].toString().trim());
    this.humidity=double.parse(map["humidity"].toString().trim());
  }

}