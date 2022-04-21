import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/song.dart';
import '../notifiers/song_notifier.dart';

class SongLetter extends StatelessWidget {
  final Song song;

  const SongLetter({Key? key, required this.song}) : super(key: key);

  static const _letterStyle = TextStyle(color: Colors.white70, fontSize: 20);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: ListWheelScrollView.useDelegate(
        controller: context.read<SongNotifier>().lirycsController,
        physics: const NeverScrollableScrollPhysics(),
        itemExtent: 40,
        diameterRatio: 1.5,
        childDelegate: ListWheelChildBuilderDelegate(
          childCount: song.letter.length,
          builder: (context, index) {
            final line = song.letter[index];
            return Align(child: Text(line, style: _letterStyle));
          },
        ),
      ),
    );
  }
}

