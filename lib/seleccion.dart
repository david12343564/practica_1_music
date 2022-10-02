import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:practica_1_music/music_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class seleccion extends StatelessWidget {
  final dynamic songData;

  seleccion({super.key, required this.songData});

  @override
  Widget build(BuildContext context) {
    dynamic spotify = songData["spotify"];
    dynamic album = spotify["album"];
    dynamic images = album["images"];

    return Scaffold(
        appBar: AppBar(
          title: const Text('Here you go'),
          actions: <Widget>[
            IconButton(
                onPressed: () {
                  if (context
                          .read<musicProvider>()
                          .getListaFavs
                          .contains(songData) ==
                      false) {
                    context.read<musicProvider>().addSong(songData);
                  } else {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                              title: Text("Eliminar de favoritos"),
                              content: Text(
                                  "El elemento será eliminado de tus favoritos ¿Quieres continuar?"),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context, "Cancelar");
                                    },
                                    child: Text("Cancelar")),
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context, "Eliminar");
                                      context
                                          .read<musicProvider>()
                                          .deleteSong(songData);
                                    },
                                    child: Text("Eliminar"))
                              ],
                            ));
                    Navigator.of(context).pop();
                  }
                },
                icon: Icon(Icons.favorite))
          ],
        ),
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.network("${images[0]["url"]}"),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${songData["title"]}",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "${songData["album"]}",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "${songData["artist"]}",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                    Text(
                      "${songData["release_date"]}",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    )
                  ],
                ),
              ),
              SizedBox(),
              Column(
                children: [
                  Text(
                    "Abrir con: ",
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                          tooltip: "Ver en spotify",
                          onPressed: () {
                            _launchLink(
                                "${songData["spotify"]["external_urls"]["spotify"]}");
                          },
                          icon: FaIcon(FontAwesomeIcons.spotify)),
                      IconButton(
                          tooltip: "Ver en Podcast",
                          onPressed: () {
                            _launchLink("${songData["song_link"]}");
                          },
                          icon: FaIcon(FontAwesomeIcons.podcast)),
                      IconButton(
                          tooltip: "Ver en Apple Music",
                          onPressed: () {
                            _launchLink("${songData["apple_music"]["url"]}");
                          },
                          icon: FaIcon(FontAwesomeIcons.apple))
                    ],
                  )
                ],
              )
            ],
          ),
        ));
  }

  Future<void> _launchLink(String url) async {
    // ignore: deprecated_member_use
    if (!await launch(url)) throw "No se pudo acceder a: $url";
  }
}
