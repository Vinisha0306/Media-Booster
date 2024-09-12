import 'package:flutter/material.dart';
import 'package:media_player/views/home_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      const Duration(seconds: 3),
      () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ),
        );
      },
    );

    return Scaffold(
      backgroundColor: Colors.black87,
      body: Center(
        child: Image(
          image: AssetImage('assets/images/music_icon.jpg'),
        ),
      ),
    );
  }
}
