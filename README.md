# Unit Converter

A multiplatform unit converter built with Flutter and Dart. Runs natively on iOS, Android, web, Linux, macOS, and Windows from a single codebase.

Built as part of MSCS 533 — Software Engineering and Multiplatform App Development at the University of the Cumberlands.

---

## Supported Conversions

| Category    | Units |
|-------------|-------|
| Distance    | meters, kilometers, centimeters, feet, yards, miles |
| Weight      | grams, kilograms, ounces, pounds |
| Volume      | milliliters, liters, fluid ounces, gallons |
| Temperature | Celsius, Fahrenheit, Kelvin |

Temperature conversions use direct formulas. All other categories convert through a base unit (meters, grams, milliliters) using a stored conversion factor.

---

## Architecture

```
lib/
├── main.dart                  # App entry point
├── models/
│   └── unit.dart              # Unit data model and all unit definitions
├── logic/
│   └── converter.dart         # Pure conversion logic, no UI dependencies
└── screens/
    └── converter_screen.dart  # Main UI — input, dropdowns, result display
```

The `to` unit dropdown filters dynamically to only show units in the same category as the selected `from` unit, preventing invalid conversion attempts at the UI level.

---

## Running the App

**Requirements:** Flutter SDK 3.x+

```bash
# Install dependencies
flutter pub get

# Run on connected device or simulator
flutter run

# Run on a specific platform
flutter run -d chrome     # web
flutter run -d macos      # macOS desktop
```

---

## Key Implementation Notes

- `Unit` stores a `toBaseFactor` for linear conversions. Temperature units set this to `0.0` as a placeholder — their logic is handled separately by `_convertTemperature()` in `converter.dart`.
- Conversion formula for linear units: `result = value × fromFactor ÷ toFactor`
- Result is formatted to 4 decimal places with trailing zeros trimmed.
