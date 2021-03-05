import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, dynamic> data;
  List<String> country = [];
  List<String> city = [];
  String selectedCountry;
  String selectedCity;

  Future<Map<String, dynamic>> getData() async {
    String jsonString = await rootBundle.loadString('assets/countries.json');
    return jsonDecode(jsonString);
  }

  @override
  void initState() {
    super.initState();
    getData().then((value) {
      setState(() {
        this.country = value.keys.toList();
        data = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.blueGrey[300],
          appBar: AppBar(
            backgroundColor: Colors.indigo[900],
            centerTitle: true,
            title: Text("Ülke - Şehir seç"),
          ),
          body: Column(
            children: [
              buildDropdownButtonCountry(),
              SizedBox(
                height: 8,
              ),
              buildDropdownButtonCity(),
              Container(
                child: ListTile(
                  title: Text(
                    selectedCountry == null ? "" : selectedCountry,
                    style: TextStyle(fontSize: 23),
                    textAlign: TextAlign.center,
                  ),
                  subtitle: Text(
                    selectedCity == null ? "" : selectedCity,
                    style: TextStyle(fontSize: 23),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  DropdownButton buildDropdownButtonCountry() {
    return DropdownButton<String>(
      hint: Text(
        "Ülke seçiniz",
        style: TextStyle(fontSize: 20),
      ),
      isExpanded: true,
      elevation: 16,
      value: selectedCountry,
      items: country.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
            style: TextStyle(fontSize: 20),
          ),
        );
      }).toList(),
      onChanged: (country) {
        this.city = (data[country] as List)?.map((e) => e as String)?.toList();
        setState(() {
          selectedCity = null;
          selectedCountry = country;
        });
      },
    );
  }

  DropdownButton buildDropdownButtonCity() {
    return DropdownButton<String>(
      hint: Text(
        "Şehir seçiniz",
        style: TextStyle(fontSize: 20),
      ),
      isExpanded: true,
      value: selectedCity,
      elevation: 16,
      items: city.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
            style: TextStyle(fontSize: 20),
          ),
        );
      }).toList(),
      onChanged: (city) {
        setState(() {
          selectedCity = city;
        });
      },
    );
  }
}
