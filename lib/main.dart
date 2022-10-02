import 'package:flutter/material.dart';
import 'package:practica_1_music/music_provider.dart';
import 'package:provider/provider.dart';

import 'home.dart';

void main() => runApp(ChangeNotifierProvider(
      create: (context) => musicProvider(),
      child: const MyApp(),
    ));

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData.dark(), title: 'FindTrackApp', home: Home());
  }
}
