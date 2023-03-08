import 'package:flare_flutter/flare.dart';
import 'package:flare_flutter/base/math/mat2d.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controller.dart';
import 'package:flutter/material.dart';
import 'package:screen_saver/animation_controller.dart';
import 'package:screen_saver/widgets/progress_widget.dart';
import 'package:screen_saver/widgets/timer_display_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _progress = 0;
  FlutterColorFill? _fill;
  // FlutterActorArtboard? _artboard;

  final _flareAnimationController = FlareAnimationController();

  void _updateProgressFactor() {
    _progress += 10;
    if (_progress > 100) {
      _progress = 0;
    }
    setState(() {
      _flareAnimationController.updateProgress(_progress / 100);
    });
  }

  @override
  void dispose() {
    _flareAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      body: Stack(
        children: [
          FlareActor(
            "assets/flare/test.flr",
            alignment: Alignment.center,
            controller: _flareAnimationController,
            fit: BoxFit.cover,
            animation: "idle",
          ),
          Positioned(
            top: 10,
            left: 0,
            right: 0,
            child: ProgressWidget(
              progress: _progress / 100,
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
          FloatingActionButton(
            onPressed: _flareAnimationController.playFillUpAnimation,
            tooltip: 'fill',
            child: const Icon(Icons.filter_list),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            onPressed: _flareAnimationController.playPackageAnimation,
            tooltip: 'run',
            child: const Icon(Icons.run_circle),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            onPressed: _flareAnimationController.playIdle,
            tooltip: 'idle',
            child: const Icon(Icons.stop),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            onPressed: _updateProgressFactor,
            tooltip: 'add',
            child: const Icon(Icons.add),
          ),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  // @override
  // bool advance(FlutterActorArtboard artboard, double elapsed) {
  //   // advance is called whenever the flare artboard is about to update (before it draws).
  //   // Color nextColor = exampleColors[_counter % exampleColors.length];

  //   //   _fill?.uiColor = nextColor;

  //   // Return false as we don't need to be called again. You'd return true if you wanted to manually animate some property.
  //   return false;
  // }

  // @override
  // void initialize(FlutterActorArtboard artboard) {
  //   // Find our "Num 2" shape and get its fill so we can change it programmatically.
  //   FlutterActorShape? shape = artboard.getNode("Num 2");
  //   _fill = shape?.fill as FlutterColorFill?;
  //   _flareAnimationController.initialize(artboard);
  //   _artboard = artboard;
  // }

  // @override
  // void setViewTransform(Mat2D viewTransform) {
  //   // TODO: implement setViewTransform
  // }
}
