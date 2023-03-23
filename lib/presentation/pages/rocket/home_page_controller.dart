import 'dart:async';
import 'dart:math';

import 'package:battery_plus/battery_plus.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:screen_saver/animation_controller.dart';
import 'package:screen_saver/domain/entities/battery_charging_state.dart';
import 'package:screen_saver/domain/entities/battery_state_entity.dart';

class HomePageController extends ChangeNotifier {
  BatteryStateEntity _batteryState = const BatteryStateEntity(
    batteryLevel: 0,
    batteryChargingState: BatteryChargingState.notCharging,
  );
  double get progress => _batteryState.batteryLevel;
  final _batteryController = Battery();
  Timer? _batteryStatTimer;

  RocketAnimationController? _pageAnimationController;
  // final RiveAnimationController baseAnimationController =
  //     SimpleAnimation("base");

  @override
  void dispose() {
    _pageAnimationController?.dispose();
    _batteryStatTimer?.cancel();
    super.dispose();
  }

  void updateProgressFactor() {
    _batteryState = _batteryState.copyWith(
      batteryLevel: _batteryState.batteryLevel + 0.1,
    );
    if (_batteryState.batteryLevel > 100) {
      _batteryState = _batteryState.copyWith(batteryLevel: 0);
    }
    _pageAnimationController?.updateProgress(_batteryState.batteryLevel / 100);
    notifyListeners();
  }

  void playFillUpAnimation() {
    // _progress = null;
    // play("fillUp");
  }

  void onInit(Artboard art) {
    //TODO remove on initialization to its own widget/controller
    var ctrl = RocketAnimationController(art);
    _pageAnimationController = ctrl;
    notifyListeners();
    start();
    _startBatteryListener();
  }

  double _randomDouble() {
    final random = Random();
    return random.nextDouble();
  }

  void start() async {
    var level = await _getBatteryLevel();
    _batteryState = _batteryState.copyWith(
      batteryLevel: level,
    );
    _pageAnimationController?.start(_batteryState.batteryLevel);
    notifyListeners();
  }

  Future<double> _getBatteryLevel() async {
    const forceRandom = false;
    if (forceRandom) {
      return Future.value(_randomDouble());
    }

    final batteryLevel = await _batteryController.batteryLevel;
    return (batteryLevel) / 100;
  }

  void _startBatteryListener() async {
    _batteryStatTimer =
        Timer.periodic(const Duration(seconds: 1), (timer) async {
      //TODO create Usecase
      final batteryLevel = await _getBatteryLevel();
      final batteryState = await _batteryController.batteryState;
      final updatedBatteryState = BatteryStateEntity(
          batteryLevel: batteryLevel,
          //TODO create tests
          batteryChargingState: batteryState == BatteryState.charging
              ? BatteryChargingState.charging
              : batteryState == BatteryState.full
                  ? BatteryChargingState.full
                  : BatteryChargingState.notCharging);
      if (_batteryState == updatedBatteryState) {
        return;
      }
      _updateBatteryState(updatedBatteryState);
    });
  }

  void _updateBatteryState(BatteryStateEntity batteryStateEntity) {
    _batteryState = batteryStateEntity;
    _pageAnimationController?.updateProgress(_batteryState.batteryLevel);
    notifyListeners();
  }
}
