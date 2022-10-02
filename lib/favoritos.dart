import 'package:flutter/material.dart';
import 'package:practica_1_music/cancion_favorita.dart';
import 'package:practica_1_music/music_provider.dart';
import 'package:provider/provider.dart';

class favoritos extends StatelessWidget {
  const favoritos({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: ListView.builder(
          itemCount: context.watch<musicProvider>().getListaFavs.length,
          itemBuilder: (BuildContext context, int index) {
            return cancionfav(
              song: context.watch<musicProvider>().getListaFavs[index],
            );
          },
        ));
  }
}
