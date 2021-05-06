import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(title: "Image Dönüştürme"),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //image url
  final imageSrc =
      "https://www.researchgate.net/profile/D-Mortari/publication/220050759/figure/fig1/AS:393997429297153@1470947715385/Input-image_Q320.jpg";
  var downloadPath = "";
  Uint8List _imageBytesDecoded; // resmin byte'a çözümlenmiş hali

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
                flex: 5,
                child: Row(children: [
                  Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          Text("İnternetten çekilen resim"),
                          Expanded(child: Image.network(imageSrc)),
                        ],
                      )),
                ])),
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 160),
                    child: ElevatedButton(
                      onPressed: () {
                        downloadFile().then((imagePath) {
                          // imageın imageSrc'den indirilmesi
                          displayDownloadImage(
                              imagePath); // resmi ekrana basan fonk.
                          base64encode(
                              imagePath); // imageın base64' e dönüştürülmesi
                        });
                      },
                      child: Text("Dönüştür"),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
                flex: 5,
                child: Column(
                  children: [
                    Text("Base64'den dönüşmüş resim"),
                    Expanded(
                      child: Center(
                        child: _imageBytesDecoded != null
                            ? Image.memory(
                                _imageBytesDecoded) // image varsa imageı göster
                            : Icon(
                                Icons.image), // image yoksa image ikonu göster
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }

  displayDownloadImage(String path) {
    // indirilen resmin path ile gösterilmesi
    setState(() {
      downloadPath = path;
    });
  }

//------------------------İnternetten alınan resmi base642 dönüştürme-----------------------
  base64encode(String imagePath) async {
    var imageBytes = File(imagePath).readAsBytesSync();
    var encodedImage =
        base64.encode(imageBytes); //encodedImage: base64' e dönüşmüş resim
    debugPrint("base64: $encodedImage");

//------------------------Base64 formatındaki resmi byte'a dönüştürme-----------------------
    setState(() {
      _imageBytesDecoded =
          base64.decode(encodedImage); // base64'ü byte'a çözümleme(decode)
      debugPrint("imageBytes: $_imageBytesDecoded");
    });
  }
//------------------------------------------------------------------------------------------

//----------------------Resmin indirilmesi------------------------------
  Future downloadFile() async {
    Dio dio = Dio();
    var dir = await getApplicationDocumentsDirectory();
    //getApplicationDocumentsDirectory path_provider'dan geliyor

    var imageDownloadPath = '${dir.path}/image.jpg'; //imageDownloadPath:
    await dio.download(imageSrc,
        imageDownloadPath); // resmin kaynak ve yol kullanılarak indirilmesi
    return imageDownloadPath;
  }
//----------------------------------------------------------------------

}
