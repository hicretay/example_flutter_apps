import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State {
  List<String> checkedItems = [];
  Map<String, bool> language = {
    "Dart": false,
    "Java": false,
    "C#": false,
    "Python": false,
    "Delphi": false,
    "Kotlin": false,
    "HTML": false,
    "CSS": false,
    "Javascript": false,
    "PHP": false
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.amber,
          centerTitle: true,
          title: Text("Programlama Dilleri"),
        ),
        body: Container(
          child: Column(
            children: [
              SizedBox(height: 15),
              Text(
                "Bildiğiniz programlama dillerini seçiniz: ",
                style: TextStyle(fontSize: 18),
              ),
              Divider(
                thickness: 2,
              ),
              Flexible(
                child: Card(
                  elevation: 3,
                  child: ListView(
                    children: language.keys.map((String key) {
                      return CheckboxListTile(
                          title: Text(key),
                          activeColor: Colors.amber,
                          controlAffinity: ListTileControlAffinity.leading,
                          value: language[key],
                          onChanged: (bool value) {
                            setState(() {
                              language[key] = value;
                              if (value == true) {
                                checkedItems.add(key);
                              } else if (value == false) {
                                checkedItems.remove(key);
                              }
                            });
                          });
                    }).toList(),
                  ),
                ),
              ),
              Flexible(
                child: buildListView(),
              )
            ],
          ),
        ),
      ),
    );
  }

  buildListView() {
    return ListView.builder(
      itemCount: checkedItems.length,
      itemBuilder: (BuildContext context, int index) {
        return Text(
          checkedItems[index],
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 22),
        );
      },
    );
  }
}
