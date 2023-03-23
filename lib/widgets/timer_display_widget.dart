import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TimerDisplayWidget extends StatefulWidget {
  const TimerDisplayWidget({super.key});

  @override
  State<TimerDisplayWidget> createState() => _TimerDisplayWidgetState();
}

class _TimerDisplayWidgetState extends State<TimerDisplayWidget> {
  final _streamController = StreamController<DateTime>.broadcast();
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _initializeTimer();
  }

  void _initializeTimer() {
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      _onTimerCallback,
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _streamController.stream,
      builder: (context, snapshot) {
        DateTime time = DateTime.now();
        String timeFormatted = _getTimeFormatted(time);
        return Text(timeFormatted,
            style: GoogleFonts.pacifico(
              textStyle: const TextStyle(
                // color: Color(0xFF1EAF00),
                color: Colors.white,
                fontSize: 72,
              ),
            ));
      },
    );
  }

  void _onTimerCallback(Timer _) {
    _streamController.sink.add(DateTime.now());
    setState(() {});
  }

  //TODO call it from time converter utils and add test for it
  String _getTimeFormatted(DateTime time) {
    var hour = time.hour.toString().padLeft(2, "0");
    var minute = time.minute.toString().padLeft(2, "0");
    var second = time.second.toString().padLeft(2, "0");
    var timeFormatted = '$hour:$minute:$second';
    return timeFormatted;
  }
}
