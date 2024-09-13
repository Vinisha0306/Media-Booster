import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:media_player/constsnt/list.dart';
import 'package:media_player/controller/pageController.dart';

import '../controller/play_pause_controller.dart';
import '../controller/song_audio_controller.dart';

class AudioPlayerScreen extends StatefulWidget {
  const AudioPlayerScreen({super.key});

  @override
  State<AudioPlayerScreen> createState() => _AudioPlayerScreenState();
}

final SongAudioController songAudioController = SongAudioController();

class _AudioPlayerScreenState extends State<AudioPlayerScreen> {
  final PlayPauseController playPauseController = PlayPauseController();
  final PageControlController pageController = PageControlController();

  @override
  void initState() {
    print('print init :: ${songAudioController.currentAudio}');
    songAudioController.init();
    super.initState();
  }

  @override
  void dispose() {
    songAudioController.audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double max = 0;

    int dataIndex = ModalRoute.of(context)!.settings.arguments as int;
    pageController.index.value = dataIndex;
    int index = pageController.index.value;
    Map data = trendingSongList[index];
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            Positioned(
              left: 0,
              top: 0,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                  print('is pop');
                },
                icon: const Icon(
                  CupertinoIcons.back,
                  color: Colors.white,
                ),
              ),
            ),
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    'https://i.pinimg.com/236x/29/1f/00/291f00701307392e8d5cd3735cbf201f.jpg',
                  ),
                  fit: BoxFit.fitWidth,
                  opacity: 0.5,
                ),
              ),
              child: Column(
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
                                  opacity: 0.8,
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
                              stream: songAudioController
                                  .audioPlayer.currentPosition,
                              builder: (context, snapshot) {
                                double value =
                                    snapshot.data?.inSeconds.toDouble() ?? 0;

                                if (songAudioController.isPlaying) {
                                  max = songAudioController.audioPlayer.current
                                          .value?.audio.duration.inSeconds
                                          .toDouble() ??
                                      100;
                                }

                                return Column(
                                  children: [
                                    Slider(
                                      activeColor: Colors.blueAccent,
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
                                            style: const TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                          Text(
                                            '${(max.toInt() ~/ 60).toString().padLeft(2, '0')}:${(max.toInt() % 60).toString().padLeft(2, '0')}',
                                            style: const TextStyle(
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.skip_previous),
                                  iconSize: 48,
                                  color:
                                      index == 0 ? Colors.grey : Colors.white,
                                  onPressed: index == 0
                                      ? () {}
                                      : () {
                                          pageController.decrement(data: index);
                                        },
                                ),
                                playPauseController.isPlay.value
                                    ? IconButton(
                                        icon: const Icon(
                                          Icons.pause_circle_filled,
                                          color: Colors.white,
                                        ),
                                        iconSize: 64,
                                        onPressed: () {
                                          print(
                                              'print data :: ${songAudioController.currentAudio}');
                                          songAudioController.pauseSong().then(
                                              (value) =>
                                                  playPauseController.pause());
                                        },
                                      )
                                    : IconButton(
                                        icon: const Icon(
                                          Icons.play_circle_fill,
                                          color: Colors.white,
                                        ),
                                        iconSize: 64,
                                        onPressed: () {
                                          print(
                                              'print data :: ${songAudioController.currentAudio}');
                                          songAudioController.playSong().then(
                                                (value) =>
                                                    playPauseController.play(),
                                              );
                                        },
                                      ),
                                IconButton(
                                  icon: const Icon(Icons.skip_next),
                                  iconSize: 48,
                                  color: index == trendingSongList.length - 1
                                      ? Colors.grey
                                      : Colors.white,
                                  onPressed: index ==
                                          trendingSongList.length - 1
                                      ? () {}
                                      : () {
                                          pageController.increment(data: index);
                                        },
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
