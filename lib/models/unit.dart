// models/unit.dart
// Defines the Unit data model and all supported unit definitions grouped by category.

/// Stores the name, category, and base conversion factor for a unit of measurement.
class Unit {
  final String name;
  final String category;

  // Conversion factor to the base unit for this category.
  // Temperature units set this to 0.0 — their logic lives in converter.dart.
  final double toBaseFactor;

  const Unit({
    required this.name,
    required this.category,
    required this.toBaseFactor,
  });
}

// Base units by category:
//   Distance    → meters
//   Weight      → grams
//   Volume      → milliliters
//   Temperature → handled separately via formulas in converter.dart

/// The full list of supported units across all categories.
const List<Unit> allUnits = [

  // Distance units
  Unit(name: 'meters',      category: 'Distance', toBaseFactor: 1.0),
  Unit(name: 'kilometers',  category: 'Distance', toBaseFactor: 1000.0),
  Unit(name: 'centimeters', category: 'Distance', toBaseFactor: 0.01),
  Unit(name: 'feet',        category: 'Distance', toBaseFactor: 0.3048),
  Unit(name: 'yards',       category: 'Distance', toBaseFactor: 0.9144),
  Unit(name: 'miles',       category: 'Distance', toBaseFactor: 1609.344),

  // Weight units
  Unit(name: 'grams',     category: 'Weight', toBaseFactor: 1.0),
  Unit(name: 'kilograms', category: 'Weight', toBaseFactor: 1000.0),
  Unit(name: 'ounces',    category: 'Weight', toBaseFactor: 28.3495),
  Unit(name: 'pounds',    category: 'Weight', toBaseFactor: 453.592),

  // Volume units
  Unit(name: 'milliliters',  category: 'Volume', toBaseFactor: 1.0),
  Unit(name: 'liters',       category: 'Volume', toBaseFactor: 1000.0),
  Unit(name: 'fluid ounces', category: 'Volume', toBaseFactor: 29.5735),
  Unit(name: 'gallons',      category: 'Volume', toBaseFactor: 3785.41),

  // Temperature units — toBaseFactor is 0.0 as a placeholder.
  // Conversion is handled by special-case formulas in converter.dart.
  Unit(name: 'Celsius',    category: 'Temperature', toBaseFactor: 0.0),
  Unit(name: 'Fahrenheit', category: 'Temperature', toBaseFactor: 0.0),
  Unit(name: 'Kelvin',     category: 'Temperature', toBaseFactor: 0.0),
];