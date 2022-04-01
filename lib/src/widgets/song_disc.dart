import 'package:flutter/material.dart';

class SongDisc extends StatelessWidget {
  final double borderWidth;
  final String discCover;
  final double centerRadius;

  const SongDisc({
    Key? key, 
    required this.discCover, 
    this.borderWidth = 10.0, 
    this.centerRadius = 20.0
  }) : super(key: key);

  static const _centerBorderWidth = 3.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(borderWidth),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft, 
          colors: [Color(0xff484750), Color(0xff1E1C24)]
        )
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          ClipOval(child: Image.asset(discCover, fit: BoxFit.cover)),
          Container(
            width: centerRadius + _centerBorderWidth,
            height: centerRadius + _centerBorderWidth,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xff33333E),
              border: Border.all(
                color: const Color(0xFF5A5A5A), 
                width: _centerBorderWidth
              )
            ),
          ),
        ],
      )
    );
  }
}