import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:screen_saver/widgets/timer_display_widget.dart';

class CactusPage extends StatefulWidget {
  const CactusPage({super.key});

  @override
  State<CactusPage> createState() => _CactusPageState();
}

class _CactusPageState extends State<CactusPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: const [
          RiveAnimation.asset(
            "assets/rive/cactus.riv",
            fit: BoxFit.cover,
            artboard: "New Artboard",
          ),
          Positioned(
            top: 10,
            left: 10,
            right: 0,
            child: TimerDisplayWidget(),
          ),
        ],
      ),
    );
  }
}
