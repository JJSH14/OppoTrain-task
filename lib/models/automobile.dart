// lib/models/automobile.dart
import 'engine.dart';
import 'enums.dart';

class Automobile {
  String _manufactureCompany;
  DateTime _manufactureDate;
  String _model;
  Engine _engine;
  int _plateNum;
  GearType _gearType;
  int _bodySerialNum;

  // Default constructor
  Automobile()
      : _manufactureCompany = '',
        _manufactureDate = DateTime.now(),
        _model = '',
        _engine = Engine(),
        _plateNum = 0,
        _gearType = GearType.normal,
        _bodySerialNum = 0;

  // Full constructor
  Automobile.full(
      this._manufactureCompany,
      this._manufactureDate,
      this._model,
      this._engine,
      this._plateNum,
      this._gearType,
      this._bodySerialNum,
      );

  // Getters & Setters
  String get manufactureCompany => _manufactureCompany;
  set manufactureCompany(String value) => _manufactureCompany = value;

  DateTime get manufactureDate => _manufactureDate;
  set manufactureDate(DateTime value) => _manufactureDate = value;

  String get model => _model;
  set model(String value) => _model = value;

  Engine get engine => _engine;
  set engine(Engine value) => _engine = value;

  int get plateNum => _plateNum;
  set plateNum(int value) => _plateNum = value;

  GearType get gearType => _gearType;
  set gearType(GearType value) => _gearType = value;

  int get bodySerialNum => _bodySerialNum;
  set bodySerialNum(int value) => _bodySerialNum = value;

  // JSON serialization
  Map<String, dynamic> toJson() => {
    'manufactureCompany': _manufactureCompany,
    'manufactureDate': _manufactureDate.toIso8601String(),
    'model': _model,
    'engine': _engine.toJson(),
    'plateNum': _plateNum,
    'gearType': _gearType.name,
    'bodySerialNum': _bodySerialNum,
  };

  factory Automobile.fromJson(Map<String, dynamic> json) => Automobile.full(
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
  );
}
