import 'dart:async';
import 'package:rive/rive.dart';

class RocketAnimationController {
  Artboard? _artboard;
  double? _progress;
  bool _isFlying = false;
  bool _pillarsOn = false;
  Timer? _sendPackageTimer;
  late StateMachineController _riveAnimationController;

  bool get isActive => _riveAnimationController.isActive;
  set isActive(bool value) => _riveAnimationController.isActive = value;

  RocketAnimationController(Artboard artboard) {
    _artboard = artboard;
    _initializeSendPackageTimer();
    //TODO update name
    _riveAnimationController =
        StateMachineController.fromArtboard(artboard, 'State Machine 1')
            as StateMachineController;
    artboard.addController(_riveAnimationController);
    _riveAnimationController.isActive = false;
  }

  void start(double batteryLevel) async {
    _riveAnimationController.isActive = true;
    _progress = batteryLevel;
    _controlProgressBar(batteryLevel);
  }

  void _controlProgressBar(double progressFactor) {
    final batteryInput =
        _riveAnimationController.findInput<double>('batteryInput') as SMINumber;
    batteryInput.change(progressFactor * 100);
  }

  void _onSendPackageTimerCallback(Timer _) {
    if (!_isFlying) {
      playPackageAnimation();
    }
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
    // play("idle");
  }

  void playPackageAnimation() {
    // play("package");
  }

  void playFillUpAnimation() {
    // _progress = null;
    // play("fillUp");
  }

  void updateProgress(double progress) {
    _progress = progress;
    _controlProgressBar(progress);
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
  }

  double? get _progressNormalized {
    final progress = _progress;
    if (progress == null) {
      return null;
    }

    return 297 - ((297 - (-180)) * progress).abs();
  }

  void playRotationWithStartTime(String name, double startTime) {
    // _artboard?.animations;
    // final animation = _artboard?.getAnimation(name);
    // animation?.apply(5, _artboard!, 1);
    // isActive.value = true;
  }

  // @override
  // bool advance(FlutterActorArtboard artboard, double elapsed) {
  //   var progressNormalized = _progressNormalized;
  //   if (progressNormalized != null) {
  //     _artboard?.getNode(_progressBarNodeName)?.y = progressNormalized;
  //   }
  //   return super.advance(artboard, elapsed);
  // }

  void playAcceleration() {
    // play("acceleration");
    // Future.delayed(const Duration(seconds: 2)).then((value) => playFlying());
  }

  void playFlying() {
    // play("flying");
  }

  void _decelerate() {
    // _playDeceleration();
    // Future.delayed(const Duration(seconds: 2)).then((value) => playIdle());
  }

  void _play50PercentOfProgressAnimation() async {
    // _pillarsOn = true;
    // play("pillars");

    // await Future.delayed(const Duration(milliseconds: 1011));
    // play("pillarsFlying");
  }

  void _playDeceleration() {
    // play("deceleration");
  }
}
