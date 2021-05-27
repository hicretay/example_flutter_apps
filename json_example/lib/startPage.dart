import 'package:flutter/material.dart';
import 'package:json_example/consts.dart';
import 'package:json_example/function.dart';
import 'package:json_example/homePage.dart';
import 'package:json_example/model.dart';

class StartPage extends StatefulWidget {
  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  DataModel incomingData; //DataModel sınıfı türünde değişken

  circularProgres() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: MaterialButton(
          color: Colors.blue,
          child: Text("Listele"),
          onPressed: () async {
            // final DataModel incomingData = await dataList(userId); 
            // Yukarıda Datamodel tanımlanmadığında yazılabilir
            // DataModel tanımlanmışsa this.incomingData şeklinde verilebilir
            this.incomingData = await dataList(userId); 
            //incomingData: dataList fonksiyonundan nesne. id parametre alacak
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MyHomePage(
                  //MyHomePage iki constructor değişkeni alıyor, sayfa geçişinde aktarılıyor
                  incomingData: incomingData, 
                  //incomingData constructor değişkenine dataList fonk.dan türetilen değişken atanıyor
                  title: "Veri Listesi", //Sayfa başlığı
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
