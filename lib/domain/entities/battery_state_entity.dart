import 'package:equatable/equatable.dart';
import 'package:screen_saver/domain/entities/battery_charging_state.dart';

class BatteryStateEntity extends Equatable {
  final double batteryLevel;
  final BatteryChargingState batteryChargingState;

  const BatteryStateEntity({
    required this.batteryLevel,
    required this.batteryChargingState,
  });

  BatteryStateEntity copyWith({
    double? batteryLevel,
    BatteryChargingState? batteryChargingState,
  }) {
    return BatteryStateEntity(
      batteryLevel: batteryLevel ?? this.batteryLevel,
      batteryChargingState:
          batteryChargingState ?? this.batteryChargingState,
    );
  }

  @override
  List<Object?> get props => [
        batteryLevel,
        batteryChargingState,
      ];
}
