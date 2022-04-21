import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import '../models/song.dart';

class SongNotifier extends ChangeNotifier {
  final Song song;

  SongNotifier({required this.song});

  final _player = AudioPlayer();
  final lirycsController = ScrollController();

  /// Duracion de la cancion
  Duration duration = const Duration();

  /// Devuelve la duracion restante de la cancion
  Duration get _leftDuration => duration - position;

  /// Posicion de la cancion
  Duration position = const Duration();

  /// Progreso en porcentaje de la cancion
  double progress = 0.0;

  /// MaxExtent del ScrollLirycs
  double _maxExtent = 0.0;

  bool _completed = false;

  Future<void> onSongLoaded(void Function(Duration) callback) async {
    /// Setea la duracion de la cancion
    duration = (await _player.setAsset(song.file)) ?? const Duration();
    notifyListeners();

    /// Listener que actua cuando la cancion termina o comienza (o reinicia)
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

    /// Maximo extend del scroll de los lirycs
    _maxExtent = lirycsController.position.maxScrollExtent;

    /// Stream que reacciona al avance de la cancion, se puede setear los intervalos que dispra eventos
    _player.createPositionStream(
      // steps: 800,
      maxPeriod: const Duration(seconds: 1),
      minPeriod: const Duration(seconds: 1)
    ).listen((songPosition) {
      /// La posicion en tiempo y el progreso en porcentaje
      position = songPosition;
      progress = (songPosition.inSeconds / duration.inSeconds);

      notifyListeners();
    });

    /// Asiga la duracion a la animacion del disco con el controller
    callback(duration);
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  /// Al parecer no se puede poner play o pause porque se detienen hasta que la muscia termina o se pause
  void toggle() {
    /// Si esta completa la volvemos al inicio, e inicia automaticamente
    if(_completed){
      _player.seek(const Duration());
      return;
    }

    // Solo hacemos play o pause
    if(_player.playing){
     _player.pause();
    } else {
      _player.play();
    }
  }
 
  /// Como no podemos hacer el await del toggle es necesario cambiar las condiciones
  void toggleLirycs() {
    /// Si ya termino vuelve al inicio del scroll y empieza animar todo de nuevo
    if(_completed){
      lirycsController.jumpTo(0);
      
      lirycsController.animateTo(
        _maxExtent, 
        duration: duration, 
        curve: Curves.linear
      );

      return;
    }

    /// Si se pausa se detiene en la posicion actual, en cambio si reanuda continua con la animacion hasta el
    /// final del extene pero esta vez la duracion sera menor
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