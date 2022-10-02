import 'package:flutter/material.dart';
import 'package:practica_1_music/seleccion.dart';
import 'package:provider/provider.dart';

import 'music_provider.dart';

class cancionfav extends StatelessWidget {
  final dynamic song;

  const cancionfav({super.key, required this.song});

  @override
  Widget build(BuildContext context) {
    dynamic spotify = song["spotify"];
    dynamic album = spotify["album"];
    dynamic images = album["images"];
    return Container(
      width: 100,
      height: 400,
      child: Stack(
        children: [
          Positioned.fill(
              child: MaterialButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => seleccion(
                        songData: song,
                      )));
            },
            child: Image.network(
              "${images[0]["url"]}",
              fit: BoxFit.fill,
            ),
          )),
          Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: Container(
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 71, 145, 205),
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(25),
                        topLeft: Radius.circular(0),
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${song["title"]}",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "${song["artist"]}",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              )),
          Positioned(
              top: 20,
              left: 20,
              child: IconButton(
                  onPressed: () {
                    if (context
                            .read<musicProvider>()
                            .getListaFavs
                            .contains(song) ==
                        false) {
                      context.read<musicProvider>().addSong(song);
                    } else if (context
                            .read<musicProvider>()
                            .getListaFavs
                            .contains(song) ==
                        true) {
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
                                            .deleteSong(song);
                                      },
                                      child: Text("Eliminar"))
                                ],
                              ));
                      Navigator.of(context).pop();
                    }
                  },
                  icon: Icon(Icons.favorite)))
        ],
      ),
    );
  }
}
