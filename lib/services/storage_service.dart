// lib/services/storage_service.dart
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../models/motorcycle.dart';
import '../models/car.dart';
import '../models/truck.dart';

class StorageService {
  // Singleton pattern (to have one instance app-wide)
  static final StorageService _instance = StorageService._internal();
  factory StorageService() => _instance;
  StorageService._internal();

  // File names
  final String _motorcyclesFile = 'motorcycles.json';
  final String _carsFile = 'cars.json';
  final String _trucksFile = 'trucks.json';

  // Data lists
  List<Motorcycle> motorcycles = [];
  List<Car> cars = [];
  List<Truck> trucks = [];

  // --- Helper: get app directory ---
  Future<Directory> _getAppDirectory() async {
    final directory = await getApplicationDocumentsDirectory();
    return directory;
  }

  // --- Save all lists to JSON files ---
  Future<void> saveData() async {
    final dir = await _getAppDirectory();

    // Convert each list to JSON
    final motorcycleJson = jsonEncode(motorcycles.map((m) => m.toJson()).toList());
    final carJson = jsonEncode(cars.map((c) => c.toJson()).toList());
    final truckJson = jsonEncode(trucks.map((t) => t.toJson()).toList());

    // Write files
    await File('${dir.path}/$_motorcyclesFile').writeAsString(motorcycleJson);
    await File('${dir.path}/$_carsFile').writeAsString(carJson);
    await File('${dir.path}/$_trucksFile').writeAsString(truckJson);
  }

  // --- Load all lists from JSON files ---
  Future<void> loadData() async {
    final dir = await _getAppDirectory();

    motorcycles = await _loadList<Motorcycle>(
      File('${dir.path}/$_motorcyclesFile'),
          (data) => Motorcycle.fromJson(data),
    );

    cars = await _loadList<Car>(
      File('${dir.path}/$_carsFile'),
          (data) => Car.fromJson(data),
    );

    trucks = await _loadList<Truck>(
      File('${dir.path}/$_trucksFile'),
          (data) => Truck.fromJson(data),
    );
  }

  // --- Generic loader ---
  Future<List<T>> _loadList<T>(File file, T Function(Map<String, dynamic>) fromJson) async {
    if (await file.exists()) {
      final content = await file.readAsString();
      final List<dynamic> data = jsonDecode(content);
      return data.map((e) => fromJson(e)).toList();
    } else {
      return [];
    }
  }

  // --- Utility: clear all data ---
  Future<void> clearAll() async {
    motorcycles.clear();
    cars.clear();
    trucks.clear();
    final dir = await _getAppDirectory();
    await File('${dir.path}/$_motorcyclesFile').delete().catchError((_) {});
    await File('${dir.path}/$_carsFile').delete().catchError((_) {});
    await File('${dir.path}/$_trucksFile').delete().catchError((_) {});
  }
}
