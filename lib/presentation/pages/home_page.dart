import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:screen_saver/presentation/pages/home_page_controller.dart';
import 'package:screen_saver/widgets/progress_widget.dart';
import 'package:screen_saver/widgets/timer_display_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _pageController = HomePageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          RiveAnimation.asset(
            "assets/rive/rocket.riv",
            alignment: Alignment.center,
            // animations: ["base"],
            fit: BoxFit.cover,
            // controllers: [_pageController.baseAnimationController],
            onInit: _pageController.onInit,
          ),
          Positioned(
            top: 10,
            left: 0,
            right: 0,
            child: AnimatedBuilder(
              animation: _pageController,
              builder: (context, child) => ProgressWidget(
                progress: _pageController.progress,
              ),
            ),
          ),
          const Positioned(
            top: 10,
            left: 10,
            right: 0,
            child: TimerDisplayWidget(),
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // FloatingActionButton(
          //   onPressed: _pageController.playFillUpAnimation,
          //   tooltip: 'fill',
          //   child: const Icon(Icons.filter_list),
          // ),
          // const SizedBox(height: 10),
          // FloatingActionButton(
          //   onPressed: _flareAnimationController.playPackageAnimation,
          //   tooltip: 'run',
          //   child: const Icon(Icons.run_circle),
          // ),
          // const SizedBox(height: 10),
          // FloatingActionButton(
          //   onPressed: _flareAnimationController.playIdle,
          //   tooltip: 'idle',
          //   child: const Icon(Icons.stop),
          // ),
          // const SizedBox(height: 10),
          FloatingActionButton(
            onPressed: _pageController.updateProgressFactor,
            tooltip: 'add',
            child: const Icon(Icons.add),
          ),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
