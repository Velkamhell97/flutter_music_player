import 'package:flutter/material.dart';

import 'src/pages/music_player_home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        iconTheme: const IconThemeData(
          color: Colors.white38
        ),
        textTheme: const TextTheme(
          bodyText2: TextStyle(
            color: Colors.white38
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: Colors.orange,
            onPrimary: Colors.black
          )
        ),
      ),
      home: const MusicPlayerHome()
    );
  }
}
