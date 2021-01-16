import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_vn_app/blocs/weather_bloc.dart';
import 'package:weather_vn_app/models/entitys/detail_weather.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  WeatherBloc _weatherBloc;

  FtoC(double tempF) {
    return (tempF - 273.15).toInt();
  }

  convertTime(int time) {
    var conver = DateTime.fromMicrosecondsSinceEpoch(time);
    return "${conver.hour}:${conver.minute}";
  }

  convertTimeZone(int time) {
    var conver = DateTime.fromMicrosecondsSinceEpoch(time);
    return conver.timeZoneName;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _weatherBloc = WeatherBloc();
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(milliseconds: 100))
        .then((value) => _weatherBloc.getWeatherLongLat());
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: StreamBuilder<DetailWeather>(
        stream: _weatherBloc.stream,
        builder: (context, snapshot) {
          return Container(
            height: double.maxFinite,
            width: double.maxFinite,
            child: Stack(
              children: [
                Container(
                  width: width,
                  height: double.maxFinite,
                  color: Colors.orangeAccent,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        Container(
                          width: width,
                          height: height / 2 - 50,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "${snapshot.data.name}",
                                style: TextStyle(fontSize: 25),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "${snapshot.data.listInfo[0].description}",
                                style: TextStyle(fontSize: 16),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "${FtoC(snapshot.data.listMain.temp)} ℃",
                                style: TextStyle(fontSize: 30),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                      "${FtoC(snapshot.data.listMain.temp_max)} ℃"),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                      "${FtoC(snapshot.data.listMain.temp_min)} ℃"),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Column(
                                children: [
                                  Text("Quang mây"),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Image.network(
                                "http://openweathermap.org/img/wn/${snapshot.data.listInfo[0].icon}@4x.png",
                              ),
                            ),
                          ],
                        ),
                        Divider(
                          color: Colors.grey,
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: width,
                          height: height / 16,
                          child: Text(
                              "Hôm nay: Hiện tại trời quang mây. Nhiệt độ hiện tại là ${FtoC(snapshot.data.listMain.temp)} độ"),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Mt Mọc"),
                                    Text(convertTime(
                                            snapshot.data.listSys.sunrise) +
                                        " Am"),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Mt Lặn"),
                                    Text(convertTime(
                                            snapshot.data.listSys.sunset) +
                                        " Pm"),
                                  ],
                                ),
                              ),
                            ]),
                            TableRow(children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Thời tiết"),
                                    Text("${snapshot.data.listInfo[0].main}"),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Độ ẩm"),
                                    Text("${snapshot.data.listMain.humidity}%"),
                                  ],
                                ),
                              ),
                            ]),
                            TableRow(children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Gió"),
                                    Text(
                                        "${(snapshot.data.listWind.speed * 60).toInt()} km/h"),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Nhiệt độ cảm nhận"),
                                    Text(
                                        "${FtoC(snapshot.data.listMain.feels_like)}"),
                                  ],
                                ),
                              ),
                            ]),
                            TableRow(children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Tầm nhìn xa"),
                                    Text(
                                        "${(snapshot.data.visibility) / 1000} km"),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Áp suất"),
                                    Text(
                                        "${snapshot.data.listMain.pressure} hPa"),
                                  ],
                                ),
                              ),
                            ]),
                            TableRow(children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Quốc Gia"),
                                    Text("${snapshot.data.listSys.country}"),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Múi giờ"),
                                    Text(convertTimeZone(snapshot.data.timezone)
                                        .toString()),
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
                  bottom: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Color(0xffb0cecc),Color(0xff98afb9)]
                      )
                    ),
                    width: width,
                    height: height / 15,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(Icons.add_box_rounded),
                          Icon(Icons.select_all),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
