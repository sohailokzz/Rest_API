import 'dart:convert';

import 'package:http/http.dart' as http;

class PostServices {
  String baseUrl = "http://10.0.2.2:5000/";
  Future<List> getPosts() async {
    try {
      var response = await http.get(
        Uri.parse(baseUrl),
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        // services
        return Future.error('Services Error !');
      }
    } catch (SocketException) {
      //fetching error
      return Future.error('Error Fetching Data !');
    }
  }
}
