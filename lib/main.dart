import 'package:flutter/material.dart';
import 'package:location/location.dart';

import 'views/home_page.dart';
void main()async{
      runApp(MyApp());
      await checkPermission();
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}
checkPermission() async {
  Location _location = Location();
  bool _serviceEnable;
  PermissionStatus _status;
  LocationData _data;
  //kiem tra nguoi dung da bat dich vu vi tri hay chua
  _serviceEnable = await _location.serviceEnabled();
  if (!_serviceEnable) {
    _serviceEnable = await _location.requestService();
    if (!_serviceEnable) {
      return;
    }
  }
  _status = await _location.hasPermission();
  if (_status == PermissionStatus.denied) {
    _status = await _location.requestPermission();
    if (_status == PermissionStatus.granted) {
      return;
    }
  }
}

