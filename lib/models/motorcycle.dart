// lib/models/motorcycle.dart
import 'automobile.dart';
import 'engine.dart';
import 'enums.dart';

class Motorcycle extends Automobile {
  double _tierDiameter;
  double _length;

  // Default constructor
  Motorcycle()
      : _tierDiameter = 0.0,
        _length = 0.0,
        super();

  // Full constructor (including parent parameters)
  Motorcycle.full(
      String manufactureCompany,
      DateTime manufactureDate,
      String model,
      Engine engine,
      int plateNum,
      GearType gearType,
      int bodySerialNum,
      this._tierDiameter,
      this._length,
      ) : super.full(
    manufactureCompany,
    manufactureDate,
    model,
    engine,
    plateNum,
    gearType,
    bodySerialNum,
  );

  // Getters & Setters
  double get tierDiameter => _tierDiameter;
  set tierDiameter(double value) => _tierDiameter = value;

  double get length => _length;
  set length(double value) => _length = value;

  // JSON serialization
  @override
  Map<String, dynamic> toJson() {
    final baseJson = super.toJson();
    baseJson.addAll({
      'tierDiameter': _tierDiameter,
      'length': _length,
    });
    return baseJson;
  }

  factory Motorcycle.fromJson(Map<String, dynamic> json) => Motorcycle.full(
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
    (json['tierDiameter'] as num).toDouble(),
    (json['length'] as num).toDouble(),
  );
}
