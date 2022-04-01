import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import '../models/song.dart';

class SongNotifier extends ChangeNotifier {
  final Song song;

  final _player = AudioPlayer();
  final lirycsController = ScrollController();

  Duration duration = const Duration();
  Duration get _leftDuration => duration - position;

  Duration position = const Duration();

  double progress = 0.0;
  double _maxExtent = 0.0;

  bool _completed = false;

  SongNotifier({required this.song});

  Future<void> onSongLoaded(void Function(Duration) callback) async {
    final songDuration = await _player.setAsset(song.file);

    duration = songDuration!;
    notifyListeners();

    _player.processingStateStream.listen((songState) {
      if(songState == ProcessingState.completed){
        _completed = true;
      } else if(songState == ProcessingState.ready){
        _completed = false;
      }
    });

    // Stream cuyo periodo es muy corto
    // player.positionStream.listen((songPosition) {
    //   print('position $songPosition');
    //   position = songPosition;
    // });

    _maxExtent = lirycsController.position.maxScrollExtent;

    _player.createPositionStream(
      // steps: 800,
      maxPeriod: const Duration(seconds: 1),
      minPeriod: const Duration(seconds: 1)
    ).listen((songPosition) {
      position = songPosition;
      progress = (songPosition.inSeconds / duration.inSeconds);

      notifyListeners();
    });

    callback(duration);
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  //-Al parecer no se puede poner play o pause porque se detienen hasta que la muscia termina o se pause
  void toggle() {
    if(_completed){
      _player.seek(const Duration()); //-Volver al comienzo
      return;
    }

    if(_player.playing){
     _player.pause();
    } else {
      _player.play();
    }
  }
 
  //-Como no podemos hacer el await del toggle es necesario cambiar las condiciones
  void toggleLirycs() {
    if(_completed){
      lirycsController.jumpTo(0);
      
      lirycsController.animateTo(
        _maxExtent, 
        duration: duration, 
        curve: Curves.linear
      );

      return;
    }

    if(!_player.playing){
      lirycsController.jumpTo(lirycsController.offset);
    } else {
      lirycsController.animateTo(
        _maxExtent, 
        duration: _leftDuration, 
        curve: Curves.linear
      );
    }
  }
}