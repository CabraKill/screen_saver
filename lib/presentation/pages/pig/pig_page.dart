import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:screen_saver/widgets/timer_display_widget.dart';

class PigPage extends StatefulWidget {
  const PigPage({super.key});

  @override
  State<PigPage> createState() => _PigPageState();
}

class _PigPageState extends State<PigPage> {
  StateMachineController? _riveAnimationController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan[200],
      body: Stack(
        children: [
          RiveAnimation.asset(
            "assets/rive/pig.riv",
            fit: BoxFit.cover,
            artboard: "pig",
            onInit: _onInit,
          ),
          const Positioned(
            // top: 10,
            left: 0,
            right: 50,
            child: TimerDisplayWidget(),
          ),
        ],
      ),
    );
  }

  void _onInit(Artboard artboard) {
    _riveAnimationController =
        StateMachineController.fromArtboard(artboard, 'State Machine 1')
            as StateMachineController;
    artboard.addController(_riveAnimationController!);
  }
}
