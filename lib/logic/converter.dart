// logic/converter.dart
// Pure conversion logic. No UI dependencies.
// Takes an input value, a from-unit, and a to-unit and returns the converted result.

import '../models/unit.dart';

/// Converts a value from one unit to another.
/// Returns null if the conversion is invalid or the input cannot be performed.
double? convert(double value, Unit from, Unit to) {

  // Units must belong to the same category to convert between them.
  if (from.category != to.category) return null;

  // Temperature uses non-linear formulas so it gets its own handler.
  if (from.category == 'Temperature') {
    return _convertTemperature(value, from.name, to.name);
  }

  // For all other categories, convert to base unit first then to target unit.
  // formula: result = value × fromFactor ÷ toFactor
  final double baseValue = value * from.toBaseFactor;
  return baseValue / to.toBaseFactor;
}

/// Handles temperature conversions using direct formulas.
/// Celsius, Fahrenheit, and Kelvin cannot use a simple multiplication factor.
double? _convertTemperature(double value, String from, String to) {

  // Same unit — no conversion needed.
  if (from == to) return value;

  if (from == 'Celsius') {
    if (to == 'Fahrenheit') return (value * 9 / 5) + 32;
    if (to == 'Kelvin')     return value + 273.15;
  }

  if (from == 'Fahrenheit') {
    if (to == 'Celsius') return (value - 32) * 5 / 9;
    if (to == 'Kelvin')  return (value - 32) * 5 / 9 + 273.15;
  }

  if (from == 'Kelvin') {
    if (to == 'Celsius')    return value - 273.15;
    if (to == 'Fahrenheit') return (value - 273.15) * 9 / 5 + 32;
  }

  // Unrecognized combination.
  return null;
}