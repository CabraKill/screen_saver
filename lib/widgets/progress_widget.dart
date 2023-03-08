import 'package:flutter/material.dart';

class ProgressWidget extends StatefulWidget {
  final double progress;
  const ProgressWidget({
    required this.progress,
    super.key,
  });

  @override
  State<ProgressWidget> createState() => _ProgressWidgetState();
}

class _ProgressWidgetState extends State<ProgressWidget> {
  @override
  Widget build(BuildContext context) {
    final progressText = "${(widget.progress * 100).round()} %";

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 450),
      transitionBuilder: (child, animation) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
      child: Text(
        progressText,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 32,
        ),
        key: ValueKey(progressText),
      ),
    );
  }
}
