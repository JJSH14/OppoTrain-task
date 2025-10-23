// lib/models/truck.dart
import 'vehicle.dart';
import 'engine.dart';
import 'enums.dart';

class Truck extends Vehicle {
  double _freeWeight;
  double _fullWeight;

  // Default constructor
  Truck()
      : _freeWeight = 0.0,
        _fullWeight = 0.0,
        super();

  // Full constructor (including parent parameters)
  Truck.full(
      String manufactureCompany,
      DateTime manufactureDate,
      String model,
      Engine engine,
      int plateNum,
      GearType gearType,
      int bodySerialNum,
      int length,
      int width,
      String color,
      this._freeWeight,
      this._fullWeight,
      ) : super.full(
    manufactureCompany,
    manufactureDate,
    model,
    engine,
    plateNum,
    gearType,
    bodySerialNum,
    length,
    width,
    color,
  );

  // Getters & Setters
  double get freeWeight => _freeWeight;
  set freeWeight(double value) => _freeWeight = value;

  double get fullWeight => _fullWeight;
  set fullWeight(double value) => _fullWeight = value;

  // JSON serialization
  @override
  Map<String, dynamic> toJson() {
    final baseJson = super.toJson();
    baseJson.addAll({
      'freeWeight': _freeWeight,
      'fullWeight': _fullWeight,
    });
    return baseJson;
  }

  factory Truck.fromJson(Map<String, dynamic> json) => Truck.full(
    json['manufactureCompany'],
    DateTime.parse(json['manufactureDate']),
    json['model'],
    Engine.fromJson(json['engine']),
    json['plateNum'],
    GearType.values.firstWhere(
          (e) => e.name == json['gearType'],
      orElse: () => GearType.normal,
    ),
    json['bodySerialNum'],
    json['length'],
    json['width'],
    json['color'],
    (json['freeWeight'] as num).toDouble(),
    (json['fullWeight'] as num).toDouble(),
  );
}
