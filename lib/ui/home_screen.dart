// lib/ui/home_screen.dart
import 'package:flutter/material.dart';
import '../models/motorcycle.dart';
import '../models/car.dart';
import '../models/truck.dart';
import '../models/engine.dart';
import '../models/enums.dart';
import '../services/storage_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final StorageService storage = StorageService();
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    await storage.loadData();
    setState(() {});
  }

  Future<void> _saveData() async {
    await storage.saveData();
  }

  void _addSampleData() {
    // Just for quick demo
    final engine = Engine.full("Yamaha", DateTime.now(), "YZF-R3", 300, 2, FuelType.gasoline);
    storage.motorcycles.add(Motorcycle.full(
      "Yamaha",
      DateTime(2023, 1, 1),
      "R3",
      engine,
      111,
      GearType.normal,
      1001,
      17.0,
      2.05,
    ));

    final carEngine = Engine.full("Toyota", DateTime(2022, 6, 1), "Corolla", 1800, 4, FuelType.gasoline);
    storage.cars.add(Car.full(
      "Toyota",
      DateTime(2022, 6, 1),
      "Corolla",
      carEngine,
      222,
      GearType.automatic,
      2001,
      4500,
      1700,
      "White",
      5,
      true,
    ));

    final truckEngine = Engine.full("Volvo", DateTime(2021, 5, 10), "FH16", 16000, 6, FuelType.diesel);
    storage.trucks.add(Truck.full(
      "Volvo",
      DateTime(2021, 5, 10),
      "FH16",
      truckEngine,
      333,
      GearType.normal,
      3001,
      7000,
      2500,
      "Blue",
      8000.0,
      20000.0,
    ));

    _saveData();
    setState(() {});
  }

  void _deleteAll() async {
    await storage.clearAll();
    setState(() {});
  }

  // --- Search filtering ---
  bool _matchesSearch(String text) =>
      _searchQuery.isEmpty || text.toLowerCase().contains(_searchQuery.toLowerCase());

  @override
  Widget build(BuildContext context) {
    final allVehicles = [
      ...storage.motorcycles.map((m) => "🏍️ ${m.manufactureCompany} ${m.model} (${m.plateNum})"),
      ...storage.cars.map((c) => "🚗 ${c.manufactureCompany} ${c.model} (${c.plateNum})"),
      ...storage.trucks.map((t) => "🚛 ${t.manufactureCompany} ${t.model} (${t.plateNum})"),
    ].where(_matchesSearch).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Vehicle Management System"),
        backgroundColor: Colors.blueAccent,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _addSampleData,
            tooltip: 'Add sample data',
          ),
          IconButton(
            icon: const Icon(Icons.delete_forever),
            onPressed: _deleteAll,
            tooltip: 'Clear all data',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search by Company/Model/Plate',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onChanged: (val) => setState(() => _searchQuery = val),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: allVehicles.isEmpty
                  ? const Center(child: Text("No vehicles available"))
                  : ListView.builder(
                itemCount: allVehicles.length,
                itemBuilder: (context, index) {
                  return Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: ListTile(
                      leading: const Icon(Icons.directions_car),
                      title: Text(allVehicles[index]),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
