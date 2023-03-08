import 'dart:async';

import 'package:flare_flutter/flare.dart';
import 'package:flare_flutter/flare_controls.dart';

class FlareAnimationController extends FlareControls {
  static const _progressBarNodeName = "progress-bar-controll";

  FlutterActorArtboard? _artboard;
  double? _progress;
  bool _isFlying = false;
  bool _pillarsOn = false;
  Timer? _sendPackageTimer;

  void _onSendPackageTimerCallback(Timer _) {
    if (!_isFlying) {
      playPackageAnimation();
    }
  }

  @override
  void initialize(FlutterActorArtboard artboard) {
    super.initialize(artboard);
    _artboard = artboard;
    _initializeSendPackageTimer();
  }

  void _initializeSendPackageTimer() {
    _sendPackageTimer = Timer.periodic(
      const Duration(seconds: 5),
      _onSendPackageTimerCallback,
    );
  }

  void dispose() {
    _sendPackageTimer?.cancel();
  }

  void playIdle() {
    _progress = null;
    play("idle");
  }

  void playPackageAnimation() {
    play("package");
  }

  void playFillUpAnimation() {
    _progress = null;
    play("fillUp");
  }

  void updateProgress(double progress) {
    _progress = progress;
    if (_progress == 1) {
      _isFlying = true;
      playAcceleration();
    }
    if (progress >= 0.5 && !_pillarsOn) {
      _play50PercentOfProgressAnimation();
    }
    if (_isFlying && progress <= 0.95) {
      _isFlying = false;
      _decelerate();
    }
    // _artboard?.
  }

  double? get _progressNormalized {
    final progress = _progress;
    if (progress == null) {
      return null;
    }
    final node = _artboard?.getNode(_progressBarNodeName);
    if (node == null) {
      return null;
    }

    return 297 - ((297 - (-180)) * progress).abs();
  }

  void playRotationWithStartTime(String name, double startTime) {
    // play(name);
    _artboard?.animations;
    final animation = _artboard?.getAnimation(name);
    // _artboard?.getAnimation(name).
    animation?.apply(5, _artboard!, 1);
    isActive.value = true;
  }

  void playRotationWithStartTime_old(String name, double startTime) {
    _artboard?.advance(5);
    // return;
    // final artboard = _artboard?.actor.artboard;
    // if (artboard == null) {
    //   return;
    // }
    // artboard.initializeGraphics();
    // var flutterArtboard = artboard.makeInstance() as FlutterActorArtboard;
    // flutterArtboard.initializeGraphics();
    // flutterArtboard.advance(5);
    // _artboard = flutterArtboard;
    // // return flutterArtboard;
  }

  @override
  bool advance(FlutterActorArtboard artboard, double elapsed) {
    var progressNormalized = _progressNormalized;
    if (progressNormalized != null) {
      _artboard?.getNode(_progressBarNodeName)?.y = progressNormalized;
    }
    return super.advance(artboard, elapsed);
  }

  void playAcceleration() {
    play("acceleration");
    Future.delayed(const Duration(seconds: 2)).then((value) => playFlying());
  }

  void playFlying() {
    play("flying");
  }

  void _decelerate() {
    _playDeceleration();
    Future.delayed(const Duration(seconds: 2)).then((value) => playIdle());
  }

  void _play50PercentOfProgressAnimation() async {
    _pillarsOn = true;
    play("pillars");

    await Future.delayed(const Duration(milliseconds: 1011));
    play("pillarsFlying");
  }

  void _playDeceleration() {
    play("deceleration");
  }
}
