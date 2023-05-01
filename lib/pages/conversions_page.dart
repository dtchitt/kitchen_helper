import 'package:flutter/material.dart';
import 'package:kitchen_helper/data/conversion.dart';

class ConversionsPage extends StatefulWidget {
  const ConversionsPage({Key? key}) : super(key: key);

  @override
  State<ConversionsPage> createState() => _ConversionsPageState();
}

class _ConversionsPageState extends State<ConversionsPage>
    with AutomaticKeepAliveClientMixin {
  final _inputController = TextEditingController();

  final _measurementTypes = {
    'cups': {
      'ounces': 8,
      'ml': 236.588,
      'tbsp': 16,
      'tsp': 48,
      'pints': 0.5,
      'quarts': 0.25,
      'gallons': 0.0625,
    },
    'ounces': {
      'cups': 0.125,
      'ml': 29.5735,
      'tbsp': 2,
      'tsp': 6,
      'pints': 0.0625,
      'quarts': 0.03125,
      'gallons': 0.0078125,
      'grams': 28.3495,
      'milligrams': 28349.5,
      'kilograms': 0.0283495,
      'pounds': 0.0625,
    },
    'ml': {
      'cups': 0.00422675,
      'ounces': 0.033814,
      'tbsp': 0.067628,
      'tsp': 0.202884,
      'pints': 0.00175975,
      'quarts': 0.000879877,
      'gallons': 0.000219969,
    },
    'tbsp': {
      'cups': 0.0625,
      'ounces': 0.5,
      'ml': 14.7868,
      'tsp': 3,
      'pints': 0.03125,
      'quarts': 0.015625,
      'gallons': 0.00390625,
    },
    'tsp': {
      'cups': 0.0208333,
      'ounces': 0.166667,
      'ml': 4.92892,
      'tbsp': 0.333333,
      'pints': 0.0104167,
      'quarts': 0.00520833,
      'gallons': 0.00130208,
    },
    'pints': {
      'cups': 2,
      'ounces': 16,
      'ml': 473.176,
      'tbsp': 32,
      'tsp': 96,
      'quarts': 0.5,
      'gallons': 0.125,
    },
    'quarts': {
      'cups': 4,
      'ounces': 32,
      'ml': 946.353,
      'tbsp': 64,
      'tsp': 192,
      'pints': 2,
      'gallons': 0.25,
    },
    'gallons': {
      'cups': 16,
      'ounces': 128,
      'ml': 3785.41,
      'tbsp': 256,
      'tsp': 768,
      'pints': 8,
      'quarts': 4,
    },
    'grams': {
      'milligrams': 1000,
      'kilograms': 0.001,
      'pounds': 0.00220462,
      'ounces': 0.035274,
    },
    'milligrams': {
      'grams': 0.001,
      'kilograms': 1e-6,
      'pounds': 2.20462e-6,
      'ounces': 3.5274e-5,
    },
    'kilograms': {
      'grams': 1000,
      'milligrams': 1e+6,
      'pounds': 2.20462,
      'ounces': 35.274,
    },
    'pounds': {
      'grams': 453.592,
      'milligrams': 453592,
      'kilograms': 0.453592,
      'ounces': 16,
    },
  };

  String? _measurementType;
  final _conversions = <Conversion>[];

  Conversion? _getConversion(double quantity, String fromUnit, String toUnit) {
    final baseTypeMap = _measurementTypes[fromUnit]!;

    final factor = baseTypeMap[toUnit];

    if (factor == null) return null;

    final result = quantity * factor;

    return Conversion(toUnit, result);
  }

  void _updateConversions() {
    final quantity = double.tryParse(_inputController.text) ?? 0;
    final measurementTypeMap = _measurementTypes[_measurementType]!;

    // Remove target unit (ex. no cups to cups)
    final resultUnits = measurementTypeMap.entries.map((e) => e.key).toList()
      ..removeWhere((type) => type == _measurementType);

    _conversions.clear();
    resultUnits
        .map((e) => _getConversion(quantity, _measurementType!, e))
        .where((e) => e != null)
        .forEach((element) {
      _conversions.add(element!);
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: [
        // Input
        Card(
          margin: const EdgeInsets.all(16),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: SizedBox(
                    width: 50,
                    child: TextField(
                      controller: _inputController,
                      keyboardType: const TextInputType.numberWithOptions(
                          decimal: true, signed: true),
                      textAlign: TextAlign.center,
                      onChanged: (value) {
                        _updateConversions();
                        setState(() {});
                      },
                    ),
                  ),
                ),
                DropdownButton(
                  underline: Container(),
                  value: _measurementType,
                  items: _measurementTypes.entries
                      .map((e) => DropdownMenuItem(
                            value: e.key,
                            child: Text(e.key),
                          ))
                      .toList(),
                  onChanged: (value) {
                    _measurementType = value;
                    _updateConversions();
                    setState(() {});
                  },
                ),
              ],
            ),
          ),
        ),

        // Output
        Padding(
          padding: const EdgeInsets.all(16),
          child: Table(
            border: TableBorder.all(),
            children: _conversions
                .map((e) => TableRow(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(4),
                          child: Text(
                              num.parse(e.value.toStringAsFixed(4)).toString()),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4),
                          child: Text(e.unit),
                        ),
                      ],
                    ))
                .toList(),
          ),
        )
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
