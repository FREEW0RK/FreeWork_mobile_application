import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';

import '../../home_view.dart';
import 'decorations.dart';
import 'login_view_video.dart';

/// Builds the page to support email verification.
class VerifyEmailView extends StatelessWidget {
  const VerifyEmailView({Key? key}) : super(key: key);

  static const routeName = '/verify-email';

  @override
  Widget build(BuildContext context) {
    return EmailVerificationScreen(
      headerBuilder: headerIcon(Icons.verified),
      sideBuilder: sideIcon(Icons.verified),
      actions: [
        EmailVerifiedAction(() {
          Navigator.pushReplacementNamed(context, HomeView.routeName);
        }),
        AuthCancelledAction((context) {
          FirebaseUIAuth.signOut(context: context);
          Navigator.pushReplacementNamed(context, SigninView.routeName);
        }),
      ],
    );
  }
}
