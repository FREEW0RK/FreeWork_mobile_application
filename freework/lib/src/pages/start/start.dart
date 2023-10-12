import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';



class StartPage extends StatefulWidget {
  const StartPage({Key? key}) : super(key: key);
  static const routeName = '/home_page';

  @override
  State<StartPage> createState() => _StartPageState();
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FREEWORK',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const StartPage(),
    );
  }
}

class _StartPageState extends State<StartPage> {
  late VideoPlayerController _controller;

 
@override
void initState() {
  super.initState();
  _controller = VideoPlayerController.asset('assets/videos/1080p_places.mov')
    ..initialize().then((_) {
      setState(() {
        // Ensure the first frame is shown
      });
      // Play the video once it's initialized
      _controller.play();
    })
    ..setLooping(true);
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'FREEWORK',
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
      ),
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          _controller.value.isInitialized
              ? AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                )
              : Container(),
          GestureDetector(
            onTap: () {
              // Navigate to the '/sign_in' screen
              Navigator.pushReplacementNamed(context, '/sign_in');
            },
            child: Container(
              alignment: Alignment.center,
              child: const Text(
                '  Start Exploring',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 50.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}  