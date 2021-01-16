class Weather{
  int id;
  String main;
  String description;
  String icon;
  Weather({this.id, this.main, this.description, this.icon});
  fromJsonInfo(Map<dynamic, dynamic> map) {
      this.id=int.parse(map["id"].toString().trim());
      this.main=map["main"];
      this.description=map["description"];
      this.icon=map["icon"];
  }




}