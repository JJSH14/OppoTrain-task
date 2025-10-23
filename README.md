# 🚗 Vehicle Management System

A Flutter application for managing different types of vehicles (Motorcycles, Cars, and Trucks) with complete CRUD operations and persistent data storage.

## 📋 Table of Contents

- [Features](#features)
- [Project Structure](#project-structure)
- [Requirements](#requirements)
- [Installation](#installation)
- [Running the Application](#running-the-application)
- [Data Storage](#data-storage)
- [Class Hierarchy](#class-hierarchy)
- [Usage](#usage)
- [Testing on Web](#testing-on-web)

## ✨ Features

- ✅ Add, delete, and modify vehicles (Motorcycles, Cars, Trucks)
- ✅ Search functionality by company name, model, or plate number
- ✅ Display all vehicles in a unified list
- ✅ Persistent data storage using JSON files
- ✅ Clean OOP design with proper encapsulation
- ✅ Material Design 3 UI

## 📁 Project Structure

```
lib/
├── models/
│   ├── enums.dart           # FuelType & GearType enums
│   ├── engine.dart          # Engine class
│   ├── automobile.dart      # Base Automobile class
│   ├── motorcycle.dart      # Motorcycle class (extends Automobile)
│   ├── vehicle.dart         # Vehicle class (extends Automobile)
│   ├── car.dart            # Car class (extends Vehicle)
│   └── truck.dart          # Truck class (extends Vehicle)
├── services/
│   └── storage_service.dart # Data persistence service
├── ui/
│   └── home_screen.dart    # Main UI screen
└── main.dart               # Application entry point
```

## 🛠️ Requirements

- Flutter SDK: `^3.7.2`
- Dart SDK: `^3.7.2`

### Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8
  path_provider: ^2.1.4    # For file storage (Android/iOS/Desktop)
  intl: ^0.19.0            # For date formatting
```

## 📥 Installation

1. **Clone the repository:**
   ```bash
   git clone <repository-url>
   cd dart_task
   ```

2. **Install dependencies:**
   ```bash
   flutter pub get
   ```

3. **Verify Flutter setup:**
   ```bash
   flutter doctor
   ```

## 🚀 Running the Application

### On Android Emulator (Recommended)

```bash
# List available devices
flutter devices

# Run on Android
flutter run -d android
```

### On Windows Desktop

```bash
# Enable Windows desktop support (one-time)
flutter config --enable-windows-desktop

# Run on Windows
flutter run -d windows
```

### On iOS (macOS only)

```bash
flutter run -d ios
```

## 💾 Data Storage

### Default Storage Location

The application uses `path_provider` to store data as JSON files:

#### Android
```
/data/data/com.example.dart_task/app_flutter/
├── motorcycles.json
├── cars.json
└── trucks.json
```

#### Windows
```
C:\Users\<YourUsername>\Documents\
├── motorcycles.json
├── cars.json
└── trucks.json
```

#### iOS
```
~/Library/Application Support/
├── motorcycles.json
├── cars.json
└── trucks.json
```

### Accessing Saved Data on Android

Using ADB:
```bash
# View files
adb shell
cd /data/data/com.example.dart_task/app_flutter/
ls -la

# Read file content
cat motorcycles.json

# Pull files to your computer
adb pull /data/data/com.example.dart_task/app_flutter/ ./saved_data/
```

Using Android Studio:
1. **View** → **Tool Windows** → **Device File Explorer**
2. Navigate to `/data/data/com.example.dart_task/app_flutter/`
3. Right-click on files → **Save As**

## 🏗️ Class Hierarchy

```
Engine
  └── (Composition)
      
Automobile (Abstract Base)
├── Motorcycle
│   └── Fields: tierDiameter, length
│
└── Vehicle
    ├── Car
    │   └── Fields: chairNum, isFurnitureLeather
    │
    └── Truck
        └── Fields: freeWeight, fullWeight
```

### Enums

- **FuelType**: `gasoline`, `diesel`, `electric`, `hybrid`
- **GearType**: `normal`, `automatic`

## 📖 Usage

### Adding Sample Data

1. Run the application
2. Tap the **"+"** icon in the AppBar
3. Sample vehicles will be added automatically

### Searching

1. Use the search bar at the top
2. Type company name, model, or plate number
3. Results update in real-time

### Clearing Data

1. Tap the **trash icon** in the AppBar
2. All data will be deleted

## 🌐 Testing on Web

> ⚠️ **Important Note**: The default implementation uses `path_provider` which **does NOT work on web browsers**.

### Option 1: Use Android/Desktop Instead (Recommended)
Run the app on Android Emulator or Windows Desktop as shown above.

### Option 2: Switch to SharedPreferences for Web Testing

If you need to test on web, you must modify the storage implementation:

1. **Update `pubspec.yaml`:**
   ```yaml
   dependencies:
     flutter:
       sdk: flutter
     cupertino_icons: ^1.0.8
     shared_preferences: ^2.2.2  # Add this
     intl: ^0.19.0
   ```

2. **Replace `storage_service.dart`** with a web-compatible version using `shared_preferences` instead of file I/O.

3. **Run on web:**
   ```bash
   flutter pub get
   flutter run -d chrome
   ```

**Note**: Using `shared_preferences` stores data in browser's localStorage, not as JSON files, which differs from the project requirements.

## 🎨 Features Demonstration

- **Add**: Tap the "+" button to add sample vehicles
- **Search**: Type in the search bar to filter vehicles
- **View**: All vehicles displayed with emoji indicators:
  - 🏍️ Motorcycles
  - 🚗 Cars
  - 🚛 Trucks
- **Delete All**: Tap trash icon to clear all data

## 📝 Notes

- All classes use **private fields** with **getters/setters** for proper encapsulation
- Each class includes both **default** and **full constructors**
- Data is automatically saved/loaded on app close/start
- JSON serialization implemented using `toJson()` and `fromJson()` methods

## 🐛 Troubleshooting

### "No implementation found for method getApplicationDocumentsDirectory"
- You're running on web browser. Use Android/Windows instead, or switch to `shared_preferences`.

### Empty screen on startup
- Add sample data using the "+" button
- Check if model classes are properly imported

### Data not persisting
- Ensure `saveData()` is called after modifications
- Check file permissions on Android (should work by default)



---

**Built By Jihad**
