import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:screen_saver/widgets/timer_display_widget.dart';

class StarPage extends StatefulWidget {
  const StarPage({super.key});

  @override
  State<StarPage> createState() => _StarPageState();
}

class _StarPageState extends State<StarPage> {
  StateMachineController? _riveAnimationController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[900],
      body: Stack(
        children: [
          RiveAnimation.asset(
            "assets/rive/start.riv",
            fit: BoxFit.cover,
            artboard: "StartReminder",
            onInit: _onInit,
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

  void _onInit(Artboard artboard) {
    _riveAnimationController =
        StateMachineController.fromArtboard(artboard, 'State Machine 1')
            as StateMachineController;
    artboard.addController(_riveAnimationController!);
  }
}
