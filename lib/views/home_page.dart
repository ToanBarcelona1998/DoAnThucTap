import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:tiengviet/tiengviet.dart';
import 'package:weather_vn_app/blocs/weather_bloc.dart';
import 'package:weather_vn_app/models/entitys/daily.dart';
import 'package:weather_vn_app/models/entitys/name_city.dart';
import 'package:weather_vn_app/models/entitys/weather_name_city.dart';
import 'package:weather_vn_app/public/custom_paint_container.dart';
Future<NameCity> getNameCity() async {
  NameCity nameCity = NameCity();
  Location _location = Location();
  LocationData _data = await _location.getLocation();
  http.Response response = await http.get(
      "http://api.openweathermap.org/data/2.5/weather?lat=${_data.latitude}&lon=${_data.longitude}&appid=2fdac9584afb2d9ad8a2bd7a6ba08329");
  if (response.statusCode == 200) {
    Map map = json.decode(response.body);
    nameCity.fromJson(map);
  } else {
    throw Exception("Lỗi call server");
  }
  return nameCity;
}

Future<WeatherNameCity> getWeatherCity(String city)async{
  WeatherNameCity weatherNameCity;
  http.Response response=await http.get("http://api.openweathermap.org/data/2.5/weather?q=$city&appid=2fdac9584afb2d9ad8a2bd7a6ba08329&lang=vi&units=metric");
  if(response.statusCode==200){
    Map map=json.decode(response.body);
    weatherNameCity=WeatherNameCity.fromJson(map);
  }else{
    throw Exception("Lỗi call server");
  }
  return weatherNameCity;
}


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  WeatherBloc _weatherBloc;
  DateTime _dateTime;
  DateFormat _format;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _weatherBloc = WeatherBloc()..getWeatherLongLat();
  }

  convertTime(int timeStamp) {
    _format = DateFormat().add_Hm();
    _dateTime = DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);
    return _format.format(_dateTime);
  }

  convertToDay(int timeStamp) {
    _format = DateFormat().add_EEEE();
    _dateTime = DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);
    return _format.format(_dateTime);
  }


  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: StreamBuilder<List<Daily>>(
        stream: _weatherBloc.stream,
        builder: (context, snapshot) {
          return snapshot.hasData
              ? Container(
                  height: height,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/weather.jpg"),
                      fit: BoxFit.fill
                    ),
                  ),
                  child: Stack(
                    children: [
                      Container(
                        width: width,
                        height: double.maxFinite,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Column(
                            children: [
                              CustomPaint(
                                painter: MyPaint(listColor: [Color(0xff90afc5),Color(0xff338b67)]),
                                child: Container(
                                  width: width,
                                  height: height / 2 -
                                      AppBar().preferredSize.height -
                                      78,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      FutureBuilder(
                                        builder: (context,
                                            AsyncSnapshot<NameCity>
                                                snapShotName) {
                                          return Text(
                                            "${snapShotName.hasData ? snapShotName.data.name : "Thái Nguyên"}",
                                            style: TextStyle(fontSize: 25),
                                          );
                                        },
                                        future: getNameCity(),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "${snapshot.data[0].weather[0].description}",
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "${(snapshot.data[0].temp.day).toInt()}℃",
                                        style: TextStyle(fontSize: 30),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                              "${(snapshot.data[0].temp.max).toInt()}℃"),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                              "${(snapshot.data[0].temp.min).toInt()}℃"),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                width: width,
                                height: height / 4,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Expanded(
                                        flex: 1,
                                        child: Text(
                                          "${snapshot.data[0].weather[0].main}",
                                          style: TextStyle(fontSize: 25),
                                          textAlign: TextAlign.center,
                                        )),
                                    Expanded(
                                      flex: 1,
                                      child: Image.network(
                                        "http://openweathermap.org/img/wn/${snapshot.data[0].weather[0].icon}@4x.png",
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                color: Colors.grey,
                              ),
                              Container(
                                height: height / 4,
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: snapshot.data.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            Card(
                                                child: Text(
                                                    "${convertToDay(snapshot.data[index].dt)}")),
                                            Image.network(
                                                "http://openweathermap.org/img/wn/${snapshot.data[index].weather[0].icon}@2x.png"),
                                            Card(
                                              child: Text(
                                                  "${(snapshot.data[index].temp.day).toInt()}℃"),
                                            ),
                                          ],
                                        ),
                                      );
                                    }),
                              ),
                              Divider(
                                color: Colors.grey,
                              ),
                              Container(
                                alignment: Alignment.center,
                                width: width,
                                height: height / 16,
                                child: Text(
                                  "Hôm nay: Hiện tại ${snapshot.data[0].weather[0].description} Nhiệt độ hiện tại là ${(snapshot.data[0].temp.day).toInt()}℃",
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Divider(
                                color: Colors.grey,
                              ),
                              Table(
                                children: [
                                  TableRow(children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("Mt Mọc"),
                                          Text(
                                              "${convertTime(snapshot.data[0].sunset)} Am"),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("Mt Lặn"),
                                          Text(
                                              "${convertTime(snapshot.data[0].sunrise)} Pm"),
                                        ],
                                      ),
                                    ),
                                  ]),
                                  TableRow(children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("Nhiệt độ buổi sáng"),
                                          Text(
                                              "${(snapshot.data[0].temp.morn).toInt()}℃"),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("Nhiệt độ ban đêm"),
                                          Text(
                                              "${(snapshot.data[0].temp.night).toInt()}℃"),
                                        ],
                                      ),
                                    ),
                                  ]),
                                  TableRow(children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("Nhiệt độ cảm nhận"),
                                          Text(
                                              "${(snapshot.data[0].feelsLike.day).toInt()}℃"),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("Nhiệt độ cảm nhận sáng"),
                                          Text(
                                              "${(snapshot.data[0].feelsLike.morn).toInt()}℃"),
                                        ],
                                      ),
                                    ),
                                  ]),
                                  TableRow(children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("Nhiệt độ cảm nhận ban đêm"),
                                          Text(
                                              "${(snapshot.data[0].feelsLike.night).toInt()}℃"),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("Nhiệt độ khí quyển"),
                                          Text(
                                              "${(snapshot.data[0].dew_point).toInt()}℃"),
                                        ],
                                      ),
                                    ),
                                  ]),
                                  TableRow(children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("Gió"),
                                          Text(
                                              "${(snapshot.data[0].wind_speed) * 60} km/h"),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("Áp suất"),
                                          Text(
                                              "${snapshot.data[0].pressure} hPa"),
                                        ],
                                      ),
                                    ),
                                  ]),
                                  TableRow(children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("Độ ẩm"),
                                          Text("${snapshot.data[0].humidity}%"),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("Hướng gió"),
                                          Text(
                                              "${(snapshot.data[0].wind_deg).toInt()}°"),
                                        ],
                                      ),
                                    ),
                                  ]),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),

                      Positioned(
                        bottom: 10,right: 10,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.blueGrey[100],
                            shape: BoxShape.circle
                          ),
                          child: IconButton(
                            iconSize: 35,
                            icon: Icon(Icons.search),
                            onPressed: () async{
                              String data = await DefaultAssetBundle.of(context).loadString("assets/city.list.json");
                              List<String> listCityVn=List();
                              var jsonResult = await json.decode(data);
                              jsonResult.forEach((element) async{
                                if(element["country"]=="VN")
                                  await listCityVn.add(element["name"]);
                              });
                                showSearch(context: context, delegate: SearchWeather(listCityVn: listCityVn));
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                )
              : Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.orange,
                  ),
                );
        },
      ),
    );
  }
}
class SearchWeather extends SearchDelegate{
  List<String> listCityVn;
  SearchWeather({this.listCityVn});
  @override
  List<Widget> buildActions(BuildContext context) {
      return [];
  }

  @override
  Widget buildLeading(BuildContext context) {
      return null;
  }

  @override
  Widget buildResults(BuildContext context) {
      return Text("");
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> listgoiy=List();
    listgoiy.clear();
    listCityVn.forEach((element) {
      if((TiengViet.parse(query.toLowerCase().replaceAll(" ", "")).allMatches(TiengViet.parse(element.toLowerCase().replaceAll(" ", "")))).isNotEmpty){
        listgoiy.add(element);
      }
    });
    return ListView.builder(itemCount: listgoiy.length,itemBuilder: (context,index){
      return ListTile(
          title: Text(listgoiy[index]),
          onTap: (){

        },
      );
    });
  }

}

