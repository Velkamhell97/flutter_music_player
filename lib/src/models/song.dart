class Song {
  final String title;
  final String author;
  final String image;
  final String file;
  final List<String> letter;

  static const List<String> _letter = [
    'Hope stopped the heart',
    'Lost beaten lie',
    'Cold walk the earth',
    'Love faded white',
    'Gave up the war',
    'I\'ve realized',
    'All will become',
    'All will arise',
    'Stay with me',
    'I hear them call the tide',
    'Take me in',
    'I see the last divide',
    'Hopelessy',
    'I leave this all behind',
    'And I am paralyzed',
    'When the broken fall alive',
    'Let the light take me too',
    'When the waters turn to fire',
    'Heaven, please let me through',
    'Far away, far away',
    'Sorrow has left me here',
    'Far away, far away',
    'Let the light take me in',
    'Fight back the flood',
    'One breath of life',
    'God, take the earth',
    'Forever blind',
    'And now the sun will fade',
    'And all we are is all we made',
    'Stay with me',
    'I hear them call the tide',
    'Take me in',
    'I see the last divide',
    'Hopelessy',
    'I leave this all behind',
    'And I am paralyzed',
    'When the broken fall alive',
    'Let the light take me too',
    'When the waters…'
  ];

  static const song = Song(
    title: 'Far Away',
    author: 'Breaking Benjamin',
    image: 'assets/images/aurora.jpg',
    // file: 'assets/audios/Breaking-Benjamin-Far-Away.mp3',
    // file: 'assets/audios/example.mp3',
    // file: 'assets/audios/This_Side_of_Paradise-Coyote_Theory.mp3',
    file: 'assets/audios/The_Living_Tombstone.mp3',
    letter: _letter
  );

  const Song({
    required this.title,
    required this.author,
    required this.image,
    required this.file,
    required this.letter
  });
}