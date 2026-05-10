// screens/converter_screen.dart
// The main UI screen. Handles user input, dropdown filtering,
// and displays the conversion result.

import 'package:flutter/material.dart';
import '../models/unit.dart';
import '../logic/converter.dart';

/// The primary screen of the app containing all conversion controls.
class ConverterScreen extends StatefulWidget {
  const ConverterScreen({super.key});

  @override
  State<ConverterScreen> createState() => _ConverterScreenState();
}

/// Manages the mutable state for the converter screen.
class _ConverterScreenState extends State<ConverterScreen> {

  // Text controller watches the input field for changes.
  final TextEditingController _inputController = TextEditingController();

  // Tracks the currently selected from and to units.
  Unit _fromUnit = allUnits[0];
  Unit _toUnit   = allUnits[1];

  // Holds the conversion result string to display. Null means no result yet.
  String? _resultText;

  // Returns only units that share the same category as the from unit.
  List<Unit> get _filteredToUnits {
    return allUnits
        .where((u) => u.category == _fromUnit.category && u.name != _fromUnit.name)
        .toList();
  }

  // Called when the user changes the from unit dropdown.
  // Resets the to unit to the first valid option in the new category.
  void _onFromUnitChanged(Unit? selected) {
    if (selected == null) return;
    setState(() {
      _fromUnit = selected;
      _toUnit   = _filteredToUnits.first;
      _resultText = null;
    });
  }

  // Called when the user changes the to unit dropdown.
  void _onToUnitChanged(Unit? selected) {
    if (selected == null) return;
    setState(() {
      _toUnit     = selected;
      _resultText = null;
    });
  }

  // Runs the conversion and updates the result display.
  void _onConvertPressed() {
    final double? inputValue = double.tryParse(_inputController.text);

    // Show an error if the input is empty or not a valid number.
    if (inputValue == null) {
      setState(() => _resultText = 'Please enter a valid number.');
      return;
    }

    final double? result = convert(inputValue, _fromUnit, _toUnit);

    if (result == null) {
      setState(() => _resultText = 'Conversion not available.');
      return;
    }

    // Format to 4 decimal places and trim unnecessary trailing zeros.
    final String formatted = double.parse(result.toStringAsFixed(4)).toString();

    setState(() {
      _resultText = '${_inputController.text} ${_fromUnit.name} '
          'is $formatted ${_toUnit.name}';
    });
  }

  @override
  // Frees the text controller from memory when the screen is removed.
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Unit Converter'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            // Numeric input field for the value to convert.
            TextField(
              controller: _inputController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Value',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            // Dropdown for selecting the from unit.
            DropdownButtonFormField<Unit>(
              value: _fromUnit,
              decoration: const InputDecoration(
                labelText: 'From',
                border: OutlineInputBorder(),
              ),
              items: allUnits.map((unit) {
                return DropdownMenuItem(
                  value: unit,
                  child: Text('${unit.name} (${unit.category})'),
                );
              }).toList(),
              onChanged: _onFromUnitChanged,
            ),

            const SizedBox(height: 20),

            // Dropdown for selecting the to unit.
            // Filtered to only show units in the same category as the from unit.
            DropdownButtonFormField<Unit>(
              value: _toUnit,
              decoration: const InputDecoration(
                labelText: 'To',
                border: OutlineInputBorder(),
              ),
              items: _filteredToUnits.map((unit) {
                return DropdownMenuItem(
                  value: unit,
                  child: Text(unit.name),
                );
              }).toList(),
              onChanged: _onToUnitChanged,
            ),

            const SizedBox(height: 24),

            // Triggers the conversion calculation.
            ElevatedButton(
              onPressed: _onConvertPressed,
              child: const Text('Convert'),
            ),

            const SizedBox(height: 24),

            // Displays the result or an error message after conversion.
            if (_resultText != null)
              Text(
                _resultText!,
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
          ],
        ),
      ),
    );
  }
}