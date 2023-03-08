import 'package:flutter/material.dart';

class TimerDisplayWidget extends StatefulWidget {
  const TimerDisplayWidget({super.key});

  @override
  State<TimerDisplayWidget> createState() => _TimerDisplayWidgetState();
}

class _TimerDisplayWidgetState extends State<TimerDisplayWidget> {
  //stream for timer
  final _timerStream =
      Stream<DateTime>.periodic(const Duration(seconds: 1), (x) {
    return DateTime.now();
  });

  @override
  void dispose() {
    _timerStream.drain();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _timerStream,
      builder: (context, snapshot) {
        DateTime time = DateTime.now();
        return Text(
          '${time.hour}:${time.minute}:${time.second}',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 60,
          ),
        );
      },
    );
  }
}
