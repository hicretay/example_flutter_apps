import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:simply_wifi/simply_wifi.dart';
import 'package:wifi_iot/wifi_iot.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String name = "Unknown";
  List<WifiNetwork> _wifiNetworks = [];
  // wifi_iot pluginin WifiNetwork classı türünde liste

  Future<void> getWifiList() async {
    var list = await SimplyWifi.getListOfWifis();
    setState(() {
      this._wifiNetworks = list;
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
      getWifiList();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.refresh),
          onPressed: () {
            setState(() {
              getWifiList();
            });
          },
        ),
        appBar: AppBar(
          centerTitle: true,
          title: Text("Yakındaki Wifi'lar"),
        ),
        body: Center(
          child: ListView.builder(
              itemCount: _wifiNetworks.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(_wifiNetworks[index].ssid),
                  subtitle: Text(_wifiNetworks[index].bssid),
                );
              }),
        ),
      ),
    );
  }
}
