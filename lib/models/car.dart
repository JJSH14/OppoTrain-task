// lib/models/car.dart
import 'vehicle.dart';
import 'engine.dart';
import 'enums.dart';

class Car extends Vehicle {
  int _chairNum;
  bool _isFurnitureLeather;

  // Default constructor
  Car()
      : _chairNum = 0,
        _isFurnitureLeather = false,
        super();

  // Full constructor (including parent parameters)
  Car.full(
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
      this._chairNum,
      this._isFurnitureLeather,
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
  int get chairNum => _chairNum;
  set chairNum(int value) => _chairNum = value;

  bool get isFurnitureLeather => _isFurnitureLeather;
  set isFurnitureLeather(bool value) => _isFurnitureLeather = value;

  // JSON serialization
  @override
  Map<String, dynamic> toJson() {
    final baseJson = super.toJson();
    baseJson.addAll({
      'chairNum': _chairNum,
      'isFurnitureLeather': _isFurnitureLeather,
    });
    return baseJson;
  }

  factory Car.fromJson(Map<String, dynamic> json) => Car.full(
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
    json['chairNum'],
    json['isFurnitureLeather'],
  );
}
