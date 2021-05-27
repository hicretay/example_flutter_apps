import 'package:flutter/material.dart';
import 'package:json_example/consts.dart';
import 'package:json_example/model.dart';
import 'package:json_example/function.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title, this.incomingData}) : super(key: key);

  final DataModel incomingData; // model sınıfı türünde gelen veri değişkeni
  final String title; //Scaffold başlığı

  @override
  _MyHomePageState createState() =>
      _MyHomePageState(incomingData: incomingData);
  //MyHomePage'den alınan incomingData değişkeni _MyHomePageState sınıfına aktarılıyor
}

class _MyHomePageState extends State<MyHomePage> {
  DataModel incomingData; // model sınıfı türünde gelen veri değişkeni
  _MyHomePageState({this.incomingData});

//------------------------------Veri Yenileme Fonksiyonu---------------------------------
  Future refreshList(int id) async {
    //userId = 1'i parametre alacak
    final DataModel list =
        await dataList(id); //dataModel türünde datalist Fonk. değişken
    setState(() {
      incomingData = list;
      //list, başta aldığımız aynı türdeki incomingData değişkenine atanıyor
      //list verileri incomingData' dan daha sonra çektiği için değişen veriler güncellenmiş oluyor
    });
  }
//---------------------------------------------------------------------------------------

  @override
  void initState() {
    super.initState();
    refreshList(userId);
    //Sayfa yüklenirken veriler refreshList fonk. ile güncelleniyor
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh),
        onPressed: () {
          //Yenile floatingActionButton'a basıldığında veriler güncellenecek
          refreshList(userId);
        },
      ),
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: [
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                    itemCount: incomingData.document.length,
                    //gelen verilerden document listesinin uzunluğu kadar eleman sayısı
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(incomingData.document[index].name),
                        //gelen verilerden document listesinin indexinin name değişkeni text'e veriliyor
                        leading: Text(
                          "id: " + incomingData.document[index].id.toString(),
                        //gelen verilerden document listesinin indexinin id değişkeni text'e veriliyor
                        ),
                      );
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
