import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/play_pause_controller.dart';
import '../controller/song_audio_controller.dart';

class AudioPlayerScreen extends StatelessWidget {
  const AudioPlayerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SongAudioController songAudioController = SongAudioController();
    final PlayPauseController playPauseController = PlayPauseController();
    double max = 0;

    Map data = ModalRoute.of(context)!.settings.arguments as Map;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              CupertinoIcons.back,
              color: Colors.white,
            ),
          ),
        ),
        backgroundColor: Colors.black,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(
              () {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      // Album Art
                      Container(
                        width: 250,
                        height: 250,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                            image: NetworkImage(
                              data['image']!,
                            ), // Replace with your image
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),

                      Text(
                        data['title']!,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 30),

                      StreamBuilder(
                        stream: songAudioController.audioPlayer.currentPosition,
                        builder: (context, snapshot) {
                          double value =
                              snapshot.data?.inSeconds.toDouble() ?? 0;

                          if (songAudioController.isPlaying) {
                            max = songAudioController.audioPlayer.current.value
                                    ?.audio.duration.inSeconds
                                    .toDouble() ??
                                100;
                          }

                          return Column(
                            children: [
                              Slider(
                                min: 0,
                                max: max,
                                value: value,
                                onChanged: (val) {
                                  songAudioController.seek(
                                      seconds: val.toInt());
                                },
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '${(value.toInt() ~/ 60).toString().padLeft(2, '0')}:${(value.toInt() % 60).toString().padLeft(2, '0')}',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      '${(max.toInt() ~/ 60).toString().padLeft(2, '0')}:${(max.toInt() % 60).toString().padLeft(2, '0')}',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      ),

                      const SizedBox(height: 30),

                      // Media Controls
                      playPauseController.isPlay.value
                          ? IconButton(
                              icon: const Icon(
                                Icons.pause_circle_filled,
                                color: Colors.white,
                              ),
                              iconSize: 64,
                              onPressed: () {
                                songAudioController.pauseSong().then(
                                    (value) => playPauseController.pause());
                              },
                            )
                          : IconButton(
                              icon: const Icon(
                                Icons.play_circle_fill,
                                color: Colors.white,
                              ),
                              iconSize: 64,
                              onPressed: () {
                                songAudioController.currentAudio = data['song'];
                                if (songAudioController.currentAudio != null) {
                                  print(songAudioController.currentAudio);
                                  songAudioController.init().then(
                                        (value) => songAudioController
                                            .playSong()
                                            .then(
                                              (value) =>
                                                  playPauseController.play(),
                                            ),
                                      );
                                }
                              },
                            ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
