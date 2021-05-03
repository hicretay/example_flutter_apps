import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Position _position; //kullanıcı konumu
  StreamSubscription<Position> _streamSubscription;
  // Gelecek pozisyona göre stream oluşturma
  Address _address; // konumun adresi

  @override
  void initState() {
    super.initState();

    //Stream Subscription ile gelen dataları dinleme
    _streamSubscription =
        Geolocator.getPositionStream().listen((Position position) {
      setState(() {
        // konumu güncelleme
        _position = position;

        //----------------Koordinatların belirlenmesi-----------------
        //latitude: enlem, longitude: boylam
        final coordinates =
            new Coordinates(position.latitude, position.longitude);
        convertToCoordinates(coordinates).then((value) => _address = value);
        //convertToCoordinates ile koordinatların adrese dönüşmesi
        //----------------------------------------------------------------
      });
    });
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Konum Uygulaması"),
        ),
        body: Column(
          children: [
            //---------------Enlem - Boylam ve adresin ekrana yazılması--------------------
            Text(
                "Enlem : ${_position?.latitude ?? ''}, Boylam : ${_position?.longitude ?? ''}"),
            Text("Adres : ${_address?.addressLine ?? ''}"),
            //------------------------------------------------------------------------------
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _streamSubscription.cancel();
    // Data dinlemenin(stream'in) sonlandırılması
  }

  //------------Enlem - Boylam'ı adrese dönüştürme metodu------------------
  Future<Address> convertToCoordinates(Coordinates coordinates) async {
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    return addresses.first;
  }
  //-----------------------------------------------------------------------
}
