import 'package:flutter/material.dart';

class DefaultPadding extends StatelessWidget {
  final Widget child;
  const DefaultPadding({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: child,
    );
  }
}
