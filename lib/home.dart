import 'dart:async';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:practica_1_music/favoritos.dart';
import 'package:practica_1_music/music_provider.dart';
import 'package:practica_1_music/seleccion.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String mensaje = "Toque para escuchar";
  bool animar = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.only(top: 70),
              child: Text(
                "${context.watch<musicProvider>().escuchando}",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            AvatarGlow(
              animate: context.watch<musicProvider>().animar,
              glowColor: Color.fromARGB(255, 211, 159, 176),
              child: MaterialButton(
                child: CircleAvatar(
                  radius: 80,
                  backgroundImage: AssetImage('img/music.png'),
                ),
                onPressed: () async {
                  context.read<musicProvider>().Escuchar();
                  context.read<musicProvider>().animacion();
                  await context.read<musicProvider>().recording();
                  Timer(Duration(seconds: 4), () async {
                    context.read<musicProvider>().dejarEscuchar();
                    context.read<musicProvider>().animacion();
                  });
                  if (context.read<musicProvider>().getCancion != null) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => seleccion(
                              songData:
                                  context.read<musicProvider>().getCancion,
                            )));
                  }
                },
                shape: CircleBorder(),
              ),
              endRadius: 200.0,
            ),
            FloatingActionButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const favoritos()));
              },
              backgroundColor: Colors.white,
              tooltip: "Ver favoritos",
              child: Icon(
                Icons.favorite,
                color: Colors.black,
                size: 35,
              ),
            )
          ],
        ),
      ),
    ));
  }
}
