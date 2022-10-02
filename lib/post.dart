import 'package:http/http.dart' as http;
import 'package:practica_1_music/password.dart';

class APIRep {
  Future<dynamic> postToAPI(audio) {
    return http.post(Uri.parse("https://api.audd.io/"), body: {
      'api_token': pass,
      'return': 'spotify,deezer,apple_music',
      'audio': audio,
    });
  }
}
