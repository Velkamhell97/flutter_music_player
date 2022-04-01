import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../extensions/duration_api.dart';
import '../models/song.dart';
import '../notifiers/song_notifier.dart';
import '../widgets/song_disc.dart';

class MusicPlayer extends StatefulWidget {
  const MusicPlayer({Key? key}) : super(key: key);

  @override
  _MusicPlayerState createState() => _MusicPlayerState();
}

class _MusicPlayerState extends State<MusicPlayer> with TickerProviderStateMixin {
  late final SongNotifier _songNotifier;
  
  late final AnimationController _controller;
  late final AnimationController _playController;

  static const _playDuration = Duration(milliseconds: 300);

  @override
  void initState() {
    super.initState();

    _songNotifier = Provider.of<SongNotifier>(context, listen: false);

    _controller = AnimationController(vsync: this);
    _playController = AnimationController(vsync: this, duration: _playDuration);

    _songNotifier.onSongLoaded((songDuration) {
      _controller.duration = songDuration;
    });

    _controller.addStatusListener((status) {
      if(status == AnimationStatus.completed){
        _playController.reverse();
        _controller.reset();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _playController.dispose();
    super.dispose();
  }

  void _togglePlay() {
    if(_controller.isAnimating){
      _controller.stop();
    } else {
      _controller.forward();
    }

    if(_playController.isCompleted){
      _playController.reverse();
    } else {
      _playController.forward();
    }
  }

  Future<void> _playerToggle() async {
    _songNotifier.toggle();
    _songNotifier.toggleLirycs();
    _togglePlay();
  }

  static const _song = Song.song;

  static const _padding = 20.0;
  static const _textSpacing = 8.0;

  static const _titleStyle = TextStyle(color: Colors.white, fontSize: 30);
  static const _subtitleStyle = TextStyle(color: Colors.white38, fontSize: 16);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final discRadius = size.height * 0.25;

    return Column(
      children: [
        //-------------------------
        // Disc And Player
        //-------------------------
        Padding(
          padding: const EdgeInsets.symmetric(vertical: _padding),
          child: Row(
            children: [
              //-------------------------
              // Disc
              //-------------------------
              Expanded(
                flex: 4,
                child: RotationTransition(
                  turns: Tween(begin: 0.0, end: 10.0).animate(_controller),
                  child: SizedBox.square(
                    dimension: discRadius,
                    child: SongDisc(discCover: _song.image),
                  ),
                ),
              ),

              //-------------------------
              // Player
              //-------------------------
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Selector<SongNotifier, Duration>(
                      selector: (_, model) => model.duration,
                      builder: (_, duration, __) => Text(duration.toMinutes()), 
                    ),
                    const SizedBox(height: _textSpacing),
                    SizedBox(
                      height: discRadius + 20,
                      child: RotatedBox(
                        quarterTurns: 3,
                        child: Selector<SongNotifier, double>(
                          selector: (_, model) => model.progress,
                          builder: (_, progress, __) => LinearProgressIndicator(
                            minHeight: 4,
                            value: progress,
                            backgroundColor: Colors.white10,
                            color: Colors.white70,
                          )
                        ),
                      ),
                    ),
                    const SizedBox(height: _textSpacing),
                    Selector<SongNotifier, Duration>(
                      selector: (_, model) => model.position,
                      builder: (_, position, __) => Text(position.toMinutes()), 
                    ),
                  ],
                ),
              )
            ],
          ),
        ),

        //-------------------------
        // Info And Button
        //-------------------------
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Row(
            children: [
              //-------------------------
              // Info
              //-------------------------
              Expanded(
                flex: 4,
                child: Column(
                  children: [
                    Text(_song.title, style: _titleStyle),
                    Text('-${_song.author}-', style: _subtitleStyle)
                  ],
                ),
              ),

              //-------------------------
              // Button
              //-------------------------
              Expanded(
                flex: 2,
                child: ElevatedButton(
                  onPressed: _playerToggle,
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(), 
                    padding: const EdgeInsets.all(12.0)
                  ),
                  child: AnimatedIcon(
                    progress: _playController,
                    icon: AnimatedIcons.play_pause,
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
