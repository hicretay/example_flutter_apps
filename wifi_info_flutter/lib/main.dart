import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wifi_info_flutter/wifi_info_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String name = "Unknown";
  WifiInfo _wifiInfo = new WifiInfo();
  Future<void> getName() async {
    var aa = await _wifiInfo.getWifiName();
    setState(() {
      name = aa.toString();
    });
  }

  Future<void> getPermission() async {
    var status = await Permission.locationWhenInUse.status;
    if (!status.isGranted) {
      PermissionStatus permissionStatus =
          await Permission.locationWhenInUse.request();
      print("PermissionStatus ${permissionStatus.isGranted}");
    } else if (status.isDenied) {
      Permission.locationWhenInUse.request();
    }
  }

  @override
  void initState() {
    setState(() {
      getPermission();
      getName();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getName();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Wifi Adı Sorgulama'),
        ),
        body: Center(
          child: Container(
            child: Text("Wifi Adı: " + name),
          ),
        ),
      ),
    );
  }
}
