import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class SigninView extends StatefulWidget {
  const SigninView({Key? key}) : super(key: key);

  static const routeName = '/sign_in';

  @override
  State<SigninView> createState() => _SigninViewState();
}

class _SigninViewState extends State<SigninView> {
  late VideoPlayerController _controller;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/videos/1080p_places.mov')
      ..initialize().then((_) {
        setState(() {
          // Ensure the first frame is shown
        });
        _controller.play();
        _controller.setLooping(true);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _controller.value.isInitialized
              ? AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                )
              : Container(),
          SafeArea(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              children: <Widget>[
                const SizedBox(height: 40.0),
                Column(
                  children: <Widget>[
                    //Image.asset('assets/images/heartearth.png', width: 150),
                    const SizedBox(height: 30.0),
                    Text(
                      "Welcome to",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(
                      "FreeWork",
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ],
                ),
                const SizedBox(height: 120.0),
                // [Name]
                TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                  ),
                ),
                const SizedBox(height: 12.0),
                TextField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                  ),
                  obscureText: true,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: const Text('Forgot Password?'),
                  ),
                ),
                const SizedBox(height: 12.0),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/poll');
                  },
                  child: const Text('Sign in'),
                ),
                const SizedBox(height: 12.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Your first time here? "),
                    TextButton(
                      child: const Text('Sign up'),
                      onPressed: () {
                        Navigator.pushNamed(context, '/signup');
                      },
                    )
                  ],
                ),
              ],
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
