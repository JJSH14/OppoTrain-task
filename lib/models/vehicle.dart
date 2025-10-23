// lib/models/vehicle.dart
import 'automobile.dart';
import 'engine.dart';
import 'enums.dart';

class Vehicle extends Automobile {
  int _length;
  int _width;
  String _color;

  // Default constructor
  Vehicle()
      : _length = 0,
        _width = 0,
        _color = '',
        super();

  // Full constructor
  Vehicle.full(
      String manufactureCompany,
      DateTime manufactureDate,
      String model,
      Engine engine,
      int plateNum,
      GearType gearType,
      int bodySerialNum,
      this._length,
      this._width,
      this._color,
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
  int get length => _length;
  set length(int value) => _length = value;

  int get width => _width;
  set width(int value) => _width = value;

  String get color => _color;
  set color(String value) => _color = value;

  // JSON serialization
  @override
  Map<String, dynamic> toJson() {
    final baseJson = super.toJson();
    baseJson.addAll({
      'length': _length,
      'width': _width,
      'color': _color,
    });
    return baseJson;
  }

  factory Vehicle.fromJson(Map<String, dynamic> json) => Vehicle.full(
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
  );
}
