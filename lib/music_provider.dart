import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'package:practica_1_music/password.dart';
import 'package:practica_1_music/post.dart';
import 'package:record/record.dart';
import 'package:http/http.dart' as http;

class musicProvider with ChangeNotifier {
  final List<dynamic> _favoritos = [];
  Record _record = Record();
  String _escuchando = "Toque para escuchar";
  bool _animar = false;
  dynamic _cancion;
  APIRep peticion = APIRep();

  bool get animar => _animar;
  String get escuchando => _escuchando;

  void setCancion(dynamic song) {
    _cancion = song;
    notifyListeners();
  }

  dynamic get getCancion => _cancion;

  void Escuchar() {
    _escuchando = "Escuchando...";
    notifyListeners();
  }

  void dejarEscuchar() {
    _escuchando = "Toque para escuchar";
    notifyListeners();
  }

  void animacion() {
    _animar = !animar;
    notifyListeners();
  }

  List<dynamic> get getListaFavs => _favoritos;

  //Para agregar y borrar de favoritos
  void addSong(dynamic song) {
    _favoritos.add(song);
    notifyListeners();
  }

  void deleteSong(dynamic song) {
    _favoritos.remove(song);
    notifyListeners();
  }

  Future<dynamic> recording() async {
    Directory? dir = await getTemporaryDirectory();
    if (await _record.hasPermission()) {
      await _record.start(
        path: '${dir.path}/maybeASong.m4a',
      );
    }

    bool isRecording = await _record.isRecording();
    if (isRecording) {
      Timer(Duration(seconds: 4), () async {
        String? filePath = await _record.stop();
        File audioFile = File(filePath!);
        Uint8List audioBytes = audioFile.readAsBytesSync();
        String audioBinary = base64Encode(audioBytes);
        var response = await peticion.postToAPI(audioBinary);
        if (response.statusCode == 200) {
          setCancion(jsonDecode(response.body)["result"]);

          print(_cancion);
          notifyListeners();
        } else {
          notifyListeners();
          return null;
        }
      });
    }
  }
}
