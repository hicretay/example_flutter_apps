import 'package:flutter/material.dart';
import 'package:note_app/screen/note_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController userName = new TextEditingController();
  TextEditingController password = new TextEditingController();
  String admin = "admin", pass = "123";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        title: Text(
          "KULLANICI GİRİŞİ",
          style: TextStyle(fontSize: 24),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 60),
        child: Column(
          children: [
            Image.asset(
              "assets/login.png",
              width: 150,
              height: 150,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25),
              child: ListTile(
                leading: Text(
                  "Kullanıcı Adı: ",
                  style: TextStyle(fontSize: 20),
                ),
                title: TextField(
                  controller: userName,
                  autofocus: true,
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 95),
              child: ListTile(
                leading: Text(
                  "Şifre: ",
                  style: TextStyle(fontSize: 20),
                ),
                title: TextField(
                  obscureText: true,
                  controller: password,
                  autofocus: false,
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            SizedBox(height: 30),
            MaterialButton(
              height: 50,
              minWidth: 160,
              color: Colors.blue,
              child: Text("GİRİŞ",
                  style: TextStyle(fontSize: 20, color: Colors.white)),
              onPressed: () {
                if (userName.text == admin) {
                  if (password.text == pass) {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => NotePage()),
                        (route) => false);
                  }
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
