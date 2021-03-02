import 'package:flutter/material.dart';

import 'services.dart';
import 'users.dart';

class JsonParse extends StatefulWidget {
  @override
  _JsonParseState createState() => _JsonParseState();
}

class _JsonParseState extends State<JsonParse> {
  List<User> _users;
  bool _loading;

  @override
  void initState() {
    super.initState();
    _loading = true;
    Services.getUsers().then((users) {
      setState(() {
        _users = users;
        _loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text(_loading ? 'Loading...' : 'Kullanıcılar'),
      ),
      body: Container(
        color: Colors.purple[100],
        child: ListView.builder(
            itemCount: null == _users ? 0 : _users.length,
            itemBuilder: (context, index) {
              User user = _users[index];
              return ListTile(
                title: Text(user.name),
                subtitle: Text(user.email),
              );
            }),
      ),
    );
  }
}
