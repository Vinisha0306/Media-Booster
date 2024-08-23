import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:media_player/page/audio_player.dart';
import 'package:media_player/page/video_player.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: MediaPlayerHome(),
    );
  }
}

class MediaPlayerHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Media Player'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Audio Player', icon: Icon(Icons.audiotrack)),
              Tab(text: 'Video Player', icon: Icon(Icons.videocam)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            AudioPlayer(),
            VideoPlayer(),
          ],
        ),
      ),
    );
  }
}
