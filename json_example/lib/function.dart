import 'package:json_example/consts.dart';
import 'package:json_example/model.dart';
import 'package:http/http.dart' as http;

Future<DataModel> dataList(int userId) async {
  final response = await http.post(
    Uri.parse(url),
    body: '{"userId":' + userId.toString() + '}',
    headers: {'Content-type': 'application/json'},
  );

  if (response.statusCode == 200) {
    final String responseString = response.body;
    return dataModelFromJson(responseString);
  } else {
    return null;
  }
}
