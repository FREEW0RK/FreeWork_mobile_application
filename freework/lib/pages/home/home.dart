import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';



class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static const routeName = '/home_page';

  @override
  State<HomePage> createState() => _HomePageState();
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Full-Screen Video Player',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class _HomePageState extends State<HomePage> {
  late VideoPlayerController _controller;

 
  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/videos/1080p_places.mp4')
      ..initialize().then((_) {
        // Ensure the first frame is shown
        setState(() {});
        // Play the video once it's initialized
        _controller.play();
      })
      ..setLooping(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Centered Video Player',
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
              child: Text(
                '  Start Exploring',
                style: TextStyle(
                  color: Colors.black,
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