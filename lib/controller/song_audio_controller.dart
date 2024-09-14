import 'package:assets_audio_player/assets_audio_player.dart';

class SongAudioController {
  AssetsAudioPlayer audioPlayer = AssetsAudioPlayer();
  String? currentAudio;

  Future<void> init() async {
    await audioPlayer
        .open(
          Audio(
            currentAudio ?? 'assets/audio/dynamite.mp3',
            metas: Metas(title: 'Song'),
          ),
          autoStart: false,
          loopMode: LoopMode.playlist,
        )
        .then(
          (value) => print('data init'),
        );
  }

  Future<void> playSong() async {
    await audioPlayer.play();
  }

  Future<void> pauseSong() async {
    await audioPlayer.pause();
  }

  Future<void> seek({required int seconds}) async {
    await audioPlayer.seek(
      Duration(seconds: seconds),
    );
  }

  bool get isPlaying => audioPlayer.isPlaying.value;
}
