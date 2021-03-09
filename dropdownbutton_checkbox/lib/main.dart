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
  String selectedItem = "TextBox";
  TextEditingController input = TextEditingController();
  bool ctrlTextField = false;
  bool ctrlCheckBox = false;
  bool _checked = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xFFDEB2A7),
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Anket",
            style: TextStyle(fontSize: 25),
          ),
          backgroundColor: Colors.deepOrangeAccent,
        ),
        body: Column(
          children: [
            Center(
              child: DropdownButton(
                value: selectedItem,
                onChanged: (String value) {
                  setState(() {
                    selectedItem = value;
                    if (selectedItem == "TextBox") {
                      ctrlTextField = true;
                      ctrlCheckBox = false;
                    } else if (selectedItem == "CheckBox") {
                      ctrlCheckBox = true;
                      ctrlTextField = false;
                    }
                  });
                },
                items: <String>["TextBox", "CheckBox"]
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    child: Text(value),
                    value: value,
                  );
                }).toList(),
              ),
            ),
            buildTextField(),
            buildCheckBoxListTile(),
          ],
        ),
      ),
    );
  }

  buildTextField() {
    if (ctrlTextField == true) {
      return TextField(
        controller: input,
        decoration: InputDecoration(
            hintText: "Kurs konusundaki düşüncelerinizi giriniz"),
        onChanged: (value) {
          print(input.text);
        },
      );
    } else if (ctrlTextField == false) {
      return Container();
    }
  }

  buildCheckBoxListTile() {
    if (ctrlCheckBox == true) {
      return CheckboxListTile(
          title: Text("Kurs Tamamlandı"),
          value: _checked,
          activeColor: Colors.deepOrangeAccent,
          onChanged: (value) {
            setState(() {
              _checked = value;
            });
          });
    } else if (ctrlCheckBox == false) {
      return Container();
    }
  }
}
