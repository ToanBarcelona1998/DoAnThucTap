class NameCity{
  String name;
  NameCity({this.name});
  fromJson(Map map){
    this.name=map["name"];
  }
}