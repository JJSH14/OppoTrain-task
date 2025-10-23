// lib/models/engine.dart
import 'enums.dart';

class Engine {
  String _manufacture;
  DateTime _manufactureDate;
  String _model;
  int _capacity;
  int _cylinders;
  FuelType _fuelType;

  // Default constructor
  Engine()
      : _manufacture = '',
        _manufactureDate = DateTime.now(),
        _model = '',
        _capacity = 0,
        _cylinders = 0,
        _fuelType = FuelType.gasoline;

  // Full constructor
  Engine.full(this._manufacture, this._manufactureDate, this._model,
      this._capacity, this._cylinders, this._fuelType);

  // Getters and Setters
  String get manufacture => _manufacture;
  set manufacture(String value) => _manufacture = value;

  DateTime get manufactureDate => _manufactureDate;
  set manufactureDate(DateTime value) => _manufactureDate = value;

  String get model => _model;
  set model(String value) => _model = value;

  int get capacity => _capacity;
  set capacity(int value) => _capacity = value;

  int get cylinders => _cylinders;
  set cylinders(int value) => _cylinders = value;

  FuelType get fuelType => _fuelType;
  set fuelType(FuelType value) => _fuelType = value;

  // JSON serialization
  Map<String, dynamic> toJson() => {
    'manufacture': _manufacture,
    'manufactureDate': _manufactureDate.toIso8601String(),
    'model': _model,
    'capacity': _capacity,
    'cylinders': _cylinders,
    'fuelType': _fuelType.name,
  };

  factory Engine.fromJson(Map<String, dynamic> json) => Engine.full(
    json['manufacture'],
    DateTime.parse(json['manufactureDate']),
    json['model'],
    json['capacity'],
    json['cylinders'],
    FuelType.values
        .firstWhere((e) => e.name == json['fuelType'], orElse: () => FuelType.gasoline),
  );
}
