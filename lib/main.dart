import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

void main() {
   
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AudioPlayerScreen(),
    );
  }
}

class AudioPlayerScreen extends StatefulWidget {
  @override
  _AudioPlayerScreenState createState() => _AudioPlayerScreenState();
}

class _AudioPlayerScreenState extends State<AudioPlayerScreen> {
  final AssetsAudioPlayer _assetsAudioPlayer = AssetsAudioPlayer();
  
  List<String> songPaths = [
    "assets/Guitar1.mp3",
    "assets/Guitar1.mp3",
    "assets/song1.mp3",
  ];
  int currentSongIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadSong(currentSongIndex);
  }

  @override
  void dispose() {
    _assetsAudioPlayer.dispose();
    super.dispose();
  }

  void _loadSong(int index) {
    _assetsAudioPlayer.open(
      Audio(songPaths[index]),
      autoStart: true,
      showNotification: true,
    );
    currentSongIndex = index;
  }

  void _playPause() {
    if (_assetsAudioPlayer.isPlaying.value) {
      _assetsAudioPlayer.pause();
    } else {
      _assetsAudioPlayer.play();
    }
  }

  void _nextSong() {
    int nextIndex = (currentSongIndex + 1) % songPaths.length;
    _loadSong(nextIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Audio Player'),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: createAudioButton("Play/Pause", _playPause),
              ),
              SizedBox(height: 16),
              Container(
                child: createAudioButton("Next Song", _nextSong),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget createAudioButton(String label, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        primary: Colors.red, // Button color
        onPrimary: Colors.black, // Text color
        padding: EdgeInsets.all(16), // Padding around the text
        textStyle: TextStyle(fontSize: 18), // Text style
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8), // Button shape
        ),
      ),
      child: Text(label),
    );
  }
}
