import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:media_player/views/audio_player_screen.dart';
import 'package:media_player/views/home_screen.dart';
import 'package:media_player/views/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => SplashScreen()),
        GetPage(name: '/home', page: () => HomeScreen()),
        GetPage(name: '/audio', page: () => AudioPlayerScreen())
      ],
    );
  }
}
