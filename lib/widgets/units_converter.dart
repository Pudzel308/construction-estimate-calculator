import 'package:construct/widgets/num_field.dart';
import 'package:flutter/material.dart';

class UnitsConverter extends StatefulWidget {
    const UnitsConverter({super.key});

    @override
    State<UnitsConverter> createState() => _UnitsConverterState();
}

class _UnitsConverterState extends State<UnitsConverter> {
    int category = 0;

    String fromUnit = 'Meters';
    String toUnit = 'Feet';

    final TextEditingController inputController =
    TextEditingController();

    final TextEditingController outputController =
    TextEditingController();

    final FocusNode input1 = FocusNode();
    final FocusNode input2 = FocusNode();

    final List<String> categories = [
        'Length',
        'Area',
        'Volume',
        'Mass',
    ];

    final Map<String, Map<String, double>> unitFactors = {
        'Length': {
        'Meters': 1,
        'Centimeters': 0.01,
        'Millimeters': 0.001,
        'Kilometers': 1000,
        'Feet': 0.3048,
        'Inches': 0.0254,
    },
        'Area': {
        'Square meters': 1,
        'Square centimeters': 0.0001,
        'Square feet': 0.09290304,
        'Square inches': 0.00064516,
        'Hectares': 10000,
        'Acres': 4046.8564224,
    },
        'Volume': {
        'Cubic meters': 1,
        'Liters': 0.001,
        'Milliliters': 0.000001,
        'Cubic feet': 0.028316846592,
        'Cubic inches': 0.000016387064,
    },
        'Mass': {
        'Kilograms': 1,
        'Grams': 0.001,
        'Pounds': 0.45359237,
        'Ounces': 0.028349523125,
        'Metric tons': 1000,
    },
    };

    Map<String, double> get availableUnits =>
        unitFactors[categories[category]]!;

    void convertFromInput(String value) {
        final number = double.tryParse(value);

        if (number == null) {
      outputController.clear();
      return;
    }

        final factors = availableUnits;

        final result =
        number * factors[fromUnit]! / factors[toUnit]!;

        outputController.text = result.toStringAsFixed(4);
    }

    void convertFromOutput(String value) {
        final number = double.tryParse(value);

        if (number == null) {
      inputController.clear();
      return;
    }

        final factors = availableUnits;

        final result =
        number * factors[toUnit]! / factors[fromUnit]!;

        inputController.text = result.toStringAsFixed(4);
    }

    void changeCategory(int? value) {
        if (value == null) return;

        setState(() {
            category = value;

            final options = unitFactors[categories[category]]!;

            fromUnit = options.keys.first;
            toUnit = options.keys.last;
        });

        convertFromInput(inputController.text);
    }

    void changeFromUnit(String? value) {
        if (value == null) return;

        setState(() {
            fromUnit = value;
        });

        convertFromInput(inputController.text);
    }

    void changeToUnit(String? value) {
        if (value == null) return;

        setState(() {
            toUnit = value;
        });

        convertFromInput(inputController.text);
    }

    Widget unitDropdown({
        required String value,
        required ValueChanged<String?> onChanged,
    }) {
        return DropdownButton<String>(
            value: value,
            isExpanded: true,
            underline: const SizedBox.shrink(),
            items: availableUnits.keys.map((unitName) {
                return DropdownMenuItem<String>(
                    value: unitName,
                    child: Text(
                        unitName,
                        overflow: TextOverflow.ellipsis,
                    ),
                );
            }).toList(),
            onChanged: onChanged,
        );
    }

    @override
    void dispose() {
        inputController.dispose();
        outputController.dispose();
        input1.dispose();
        input2.dispose();
        super.dispose();
    }

    @override
    Widget build(BuildContext context) {
        return Column(
            children: [
                const Text(
                    'Unit Converter',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                    ),
                ),

                const Divider(),

                const SizedBox(height: 20),

                SizedBox(
                    width: 200,
                    child: DropdownButtonFormField<int>(
                    initialValue: category,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                        ),
                    ),
                    items: List.generate(categories.length, (index) {
                        return DropdownMenuItem<int>(
                            value: index,
                            child: Text(categories[index]),
                        );
                    }),
                    onChanged: changeCategory,
                ),
                ),

                const SizedBox(height: 30),

                // Input value and source unit.
                Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                        Expanded(
                            flex: 3,
                            child: NumField(
                                hint: '0.0',
                                label: 'From:',
                                focusNode: input1,
                                controller: inputController,
                                onChanged: convertFromInput,
                            ),
                        ),

                        const SizedBox(width: 12),

                        Expanded(
                            flex: 2,
                            child: unitDropdown(
                                value: fromUnit,
                                onChanged: changeFromUnit,
                            ),
                        ),
                    ],
                ),

                const SizedBox(height: 20),

                // Output value and destination unit.
                Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                        Expanded(
                            flex: 3,
                            child: NumField(
                                hint: '0.0',
                                label: 'To:',
                                focusNode: input2,
                                controller: outputController,
                                onChanged: convertFromOutput,
                            ),
                        ),

                        const SizedBox(width: 12),

                        Expanded(
                            flex: 2,
                            child: unitDropdown(
                                value: toUnit,
                                onChanged: changeToUnit,
                            ),
                        ),
                    ],
                ),
            ],
        );
    }
}
