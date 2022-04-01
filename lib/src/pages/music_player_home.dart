import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../notifiers/song_notifier.dart';
import '../models/song.dart';
import '../widgets/song_letter.dart';
import '../widgets/music_player.dart';

class MusicPlayerHome extends StatelessWidget {
  const MusicPlayerHome({Key? key}) : super(key: key);

  static const _song = Song.song;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            //-------------------------
            // Background 1
            //-------------------------
            const Positioned.fill(
              child: _Background1()
            ),

            //-------------------------
            // Background 2
            //-------------------------
            Positioned.fill(
              bottom: size.height * 0.2,
              child: const _Background2()
            ),

            //-------------------------
            // Body
            //-------------------------
            Positioned.fill(
              child: ChangeNotifierProvider(
                create: (_) => SongNotifier(song: _song),
                // lazy: false,
                child: Column(
                  children:  const [
                    _AppBar(),
                    MusicPlayer(),
                    Expanded(
                      child: SongLetter(song: _song)
                    )
                  ],
                ),
              )
            ),
          ],
        ),
      ),
    );
  }
}

//-- Background 1
class _Background1 extends StatelessWidget {
  const _Background1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const DecoratedBox(
      decoration: BoxDecoration(
        color: Color(0xff201E28)
      ),
    );
  }
}

//-- Background 2
class _Background2 extends StatelessWidget {
  const _Background2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  const DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(60.0)),
        gradient: LinearGradient(
          //Una forma de cortar gracientes tiene un funcionamiento similar a los stops  
          begin: Alignment.centerLeft,
          end: Alignment.center,
          // stops: [0.0, 0.5],
          colors: [Color(0xff33333E), Color(0xff201E28)]
        )
      ),
    );
  }
}

//-- Appbar
class _AppBar extends StatelessWidget {
  const _AppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: (){},
          icon: const Icon(FontAwesomeIcons.chevronLeft),
        ),
        const Spacer(),
        IconButton(
          onPressed: (){},
          icon: const Icon(FontAwesomeIcons.commentAlt),
        ),
        IconButton(
          onPressed: (){},
          icon: const Icon(FontAwesomeIcons.headphonesAlt),
        ),
        IconButton(
          onPressed: (){},
          icon: const Icon(FontAwesomeIcons.externalLinkAlt),
        ),
      ],
    );
  }
}
