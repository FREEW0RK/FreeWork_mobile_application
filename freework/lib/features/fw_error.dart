import 'package:flutter/material.dart';

class FWError extends StatelessWidget {
  const FWError(this.errorMessage, this.stacktrace, {super.key});

  final String errorMessage;
  final String stacktrace;

  @override
  Widget build(BuildContext context) {
    return Text('Error: $errorMessage\nStack trace: $stacktrace',
        style: Theme.of(context)
            .textTheme
            .bodySmall!
            .copyWith(color: Colors.white));
  }
}
