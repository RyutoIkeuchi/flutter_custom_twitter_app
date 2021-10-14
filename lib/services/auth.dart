import 'dart:convert';
import 'package:http/http.dart' as http;

import '../config.dart';

Future<dynamic> postApi() async {
  final base64encoded =
      base64.encode(latin1.encode('$TWITTER_API_KEY:$TWITTER_API_KEY_SECRET'));
  final res = await http.post(
    Uri.parse('https://api.twitter.com/oauth2/token'),
    headers: {'Authorization': 'Basic $base64encoded'},
    body: {'grant_type': 'client_credentials'},
  );

  final dynamic data = jsonDecode(res.body);
  print(data);
  return data;
}
