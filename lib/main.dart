import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:media_player/constant/list.dart';
import 'package:media_player/controller/play_pause_controller.dart';
import 'package:media_player/controller/song_audio_controller.dart';
import 'package:media_player/page/video_player.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: MediaPlayerScreen(),
      getPages: [
        GetPage(
          name: '/video',
          page: () => VideoPlayer(),
        ),
      ],
    );
  }
}

class MediaPlayerScreen extends StatelessWidget {
  final SongAudioController songAudioController = SongAudioController();
  final PlayPauseController playPauseController = PlayPauseController();
  double max = 0;
  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: Colors.grey[850],
        title: const Text(
          'Media Player',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => VideoPlayer());
            },
            icon: const Icon(
              Icons.video_collection,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: PageView.builder(
        controller: pageController,
        onPageChanged: (val) async {
          songAudioController.currentAudio = songList[val];
          if (songAudioController.currentAudio != null) {
            await songAudioController.init();
            playPauseController.pause();
          }
        },
        itemCount: songList.length,
        itemBuilder: (context, index) => Obx(() {
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
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black54,
                        blurRadius: 8,
                        spreadRadius: 3,
                      ),
                    ],
                    image: const DecorationImage(
                      image: AssetImage(
                          'lib/assets/main_image.jpg'), // Replace with your image
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                Text(
                  nameList[index],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30),

                StreamBuilder(
                  stream: songAudioController.audioPlayer.currentPosition,
                  builder: (context, snapshot) {
                    double value = snapshot.data?.inSeconds.toDouble() ?? 0;

                    if (songAudioController.isPlaying) {
                      max = songAudioController.audioPlayer.current.value?.audio
                              .duration.inSeconds
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
                            songAudioController.seek(seconds: val.toInt());
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${(value.toInt() ~/ 60).toString().padLeft(2, '0')}:${(value.toInt() % 60).toString().padLeft(2, '0')}',
                                style: const TextStyle(color: Colors.white),
                              ),
                              Text(
                                '${(max.toInt() ~/ 60).toString().padLeft(2, '0')}:${(max.toInt() % 60).toString().padLeft(2, '0')}',
                                style: const TextStyle(color: Colors.white),
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
                  children: <Widget>[
                    IconButton(
                      icon: const Icon(Icons.skip_previous),
                      iconSize: 48,
                      color: index == 0 ? Colors.grey : Colors.white,
                      onPressed: index == 0
                          ? () {}
                          : () {
                              pageController.animateToPage(
                                index - 1,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            },
                    ),
                    playPauseController.isPlay.value
                        ? IconButton(
                            icon: const Icon(Icons.pause_circle_filled),
                            iconSize: 64,
                            color: Colors.white,
                            onPressed: () {
                              songAudioController
                                  .pauseSong()
                                  .then((value) => playPauseController.pause());
                            },
                          )
                        : IconButton(
                            icon: const Icon(Icons.play_circle_fill),
                            iconSize: 64,
                            color: Colors.white,
                            onPressed: () {
                              songAudioController.playSong().then(
                                    (value) => playPauseController.play(),
                                  );
                            },
                          ),
                    IconButton(
                      icon: const Icon(Icons.skip_next),
                      iconSize: 48,
                      color: index == songList.length - 1
                          ? Colors.grey
                          : Colors.white,
                      onPressed: index == songList.length - 1
                          ? () {}
                          : () {
                              pageController.animateToPage(
                                index + 1,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            },
                    ),
                  ],
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
