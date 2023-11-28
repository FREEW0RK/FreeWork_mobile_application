 import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


import 'package:firebase_ui_auth/firebase_ui_auth.dart' hide ForgotPasswordView;
import '../../home_view.dart';
import 'decorations.dart';
import 'forgot_password_view.dart';
import 'verify_email_view.dart';

// PROVIDER 
// Define a Riverpod provider for the video controller.
final videoControllerProvider = Provider<VideoPlayerController>((ref) {
  final controller = VideoPlayerController.asset('assets/videos/1080p_places.mp4');
  ref.onDispose(() {
    controller.dispose();
  });
  return controller;
});


final emailControllerProvider = Provider((_) => TextEditingController());
final passwordControllerProvider = Provider((_) => TextEditingController());



class SigninView extends ConsumerWidget {
  const SigninView({Key? key}) : super(key: key);
  static const routeName = '/sign_in';
  //final _formKey = GlobalKey<FormBuilderState>();
  
// NO CONTROLLER ---> RIVERPOD
/*   @override
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
  } */
 
  @override
  Widget build(BuildContext context, WidgetRef ref){ 

    // Read the video controller from the provider.
 /*    final videoController = ref.read(videoControllerProvider);
    // Initialize the video controller.
    videoController.initialize().then((_) {
      videoController.play();
      videoController.setLooping(true);
    }); */

    return SignInScreen(
          actions: [
            ForgotPasswordAction((context, email) {
              Navigator.pushNamed(
                context,
                ForgotPasswordView.routeName,
                arguments: {'email': email},
              );
            }),
            AuthStateChangeAction<SignedIn>((context, state) {
              if (!state.user!.emailVerified) {
                Navigator.pushNamed(context, VerifyEmailView.routeName);
              } else {
                Navigator.pushReplacementNamed(context, HomeView.routeName);
              }
            }),
            AuthStateChangeAction<UserCreated>((context, state) {
              if (!state.credential.user!.emailVerified) {
                Navigator.pushNamed(context, VerifyEmailView.routeName);
              } else {
                Navigator.pushReplacementNamed(context, HomeView.routeName);
              }
            }),
            AuthStateChangeAction<CredentialLinked>((context, state) {
              if (!state.user.emailVerified) {
                Navigator.pushNamed(context, VerifyEmailView.routeName);
              } else {
                Navigator.pushReplacementNamed(context, HomeView.routeName);
              }
            }),
          ],
          styles: const {
            EmailFormStyle(signInButtonVariant: ButtonVariant.filled),
          },
          headerBuilder: headerImage('assets/images/freeworklogoearthgrinsgesicht.jpg'),
          //sideBuilder: sideImage('assets/images/freeworklogoearthgrinsgesicht.jpg'),
          subtitleBuilder: (context, action) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                action == AuthAction.signIn
                    ? 'EXPLORE EARTH - ANYTIME - Please sign in.'
                    : 'New EXPLORER - create an account.',
              ),
            );
          },
          footerBuilder: (context, action) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text(
                  action == AuthAction.signIn
                      ? 'By signing in, you agree to our terms and conditions.'
                      : 'By registering, you agree to our terms and conditions.',
                  style: const TextStyle(color: Colors.grey),
                ),
              ),
            );
          },
        );
  }
}


/* 
  final formKey = GlobalKey<FormBuilderState>();
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          children: <Widget>[
            const SizedBox(height: 40.0),
            Column(
              children: <Widget>[
                Image.asset('assets/images/freeworklogoearthgrinsgesicht.jpg', width: 100),
                const SizedBox(height: 16.0),
                Text(
                  "Welcome to",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Text(
                  "FREEWORK",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                Text(
                  "EXPLORE EARTH",
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                Text(
                "ANYTIME",
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ],
            ),
            const SizedBox(height: 120.0),
            // [Name]
            FormBuilder(
              key: formKey,
              // autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  FormBuilderTextField(
                    name: 'email',
                    decoration: const InputDecoration(labelText: 'Email'),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      FormBuilderValidators.email(),
                    ]),
                  ),
                  const SizedBox(height: 10),
                  FormBuilderTextField(
                    name: 'password',
                    decoration: const InputDecoration(labelText: 'Password'),
                    obscureText: true,
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                child: const Text('Forgot Password?'),
              ),
            ),
            const SizedBox(height: 12.0),
            SizedBox(
              height: 40,
              child: ElevatedButton(
                  onPressed: () {
                    bool validEmailAndPassword =
                        formKey.currentState?.saveAndValidate() ?? false;
                    User user = ref.read(userProvider);

                    if (validEmailAndPassword) {
                      String email = formKey.currentState?.value['email'];
                      if (user.isUserEmail(email)) {
                        String userID = user.getUserID(email);
                        ref.read(currentUserID.notifier).state = userID;
                        Navigator.pushReplacementNamed(context, '/home');
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                              "Unknown User, try one of: ${user.getAllEmails().join(', ')}"),
                          duration: const Duration(seconds: 10),
                        ));
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Invalid Email or Password.'),
                        duration: Duration(seconds: 2),
                      ));
                    }
                  },
                  child: const Text('Sign in')),
            ),
            const SizedBox(height: 12.0),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Text("Don't have an account? "),
              TextButton(
                child: const Text('Sign up'),
                onPressed: () {
                  // Eventually: pushReplacementNamed
                  Navigator.pushNamed(context, '/signup');
                },
              )
            ]),
          ],
        ),
      ),
    );
  }
}




 */





/* 
  static const routeName = '/';
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          children: <Widget>[
            const SizedBox(height: 40.0),
            Column(
              children: <Widget>[
                Image.asset('assets/images/vegetables.png', width: 100),
                const SizedBox(height: 16.0),
                Text(
                  "Welcome to",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Text(
                  "Agile Garden Club",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ],
            ),
            const SizedBox(height: 120.0),
            // [Name]
            FormBuilder(
              key: _formKey,
              // autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  FormBuilderTextField(
                    name: 'email',
                    decoration: const InputDecoration(labelText: 'Email'),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      FormBuilderValidators.email(),
                    ]),
                  ),
                  const SizedBox(height: 10),
                  FormBuilderTextField(
                    name: 'password',
                    decoration: const InputDecoration(labelText: 'Password'),
                    obscureText: true,
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                child: const Text('Forgot Password?'),
              ),
            ),
            const SizedBox(height: 12.0),
            SizedBox(
              height: 40,
              child: ElevatedButton(
                  onPressed: () {
                    bool validEmailAndPassword =
                        _formKey.currentState?.saveAndValidate() ?? false;
                    User user = ref.read(userProvider);

                    if (validEmailAndPassword) {
                      String email = _formKey.currentState?.value['email'];
                      if (user.isUserEmail(email)) {
                        String userID = user.getUserID(email);
                        ref.read(currentUserIDProvider.notifier).state = userID;
                        Navigator.pushReplacementNamed(context, '/home');
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                              "Unknown User, try one of: ${user.getAllEmails().join(', ')}"),
                          duration: const Duration(seconds: 10),
                        ));
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Invalid Email or Password.'),
                        duration: Duration(seconds: 2),
                      ));
                    }
                  },
                  child: const Text('Sign in')),
            ),
            const SizedBox(height: 12.0),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Text("Don't have an account? "),
              TextButton(
                child: const Text('Sign up'),
                onPressed: () {
                  // Eventually: pushReplacementNamed
                  Navigator.pushNamed(context, '/signup');
                },
              )
            ]),
          ],
        ),
      ),
    );
  }
}
    final emailController = ref.watch(emailControllerProvider);
    final passwordController = ref.watch(passwordControllerProvider);


    return Scaffold(
      body: Stack(
        children: <Widget>[
          videoController.value.isInitialized
              ? AspectRatio(
                  aspectRatio: videoController.value.aspectRatio,
                  child: VideoPlayer(videoController),
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
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                  ),
                ),
                const SizedBox(height: 12.0),
                TextField(
                  controller: passwordController,
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
 */