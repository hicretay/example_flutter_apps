import 'package:http/http.dart' as http;

import 'users.dart';

class Services {
  static const String url = 'http://jsonplaceholder.typicode.com/users';
  static Future<List<User>> getUsers() async {
    try {
      final response = await http.get(url);
      if (200 == response.statusCode) {
        final List<User> users = usersFromJson(response.body);
        return users;
      } else {
        return List<User>();
      }
    } catch (e) {
      return List<User>();
    }
  }
}
