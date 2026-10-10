import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NumField extends StatelessWidget {
    final TextInputType keyboardType;
    final TextEditingController? controller;
    final List<TextInputFormatter>? inputFormatters;
    final FocusNode? focusNode;
    final ValueChanged<String>? onSubmitted;
    final ValueChanged<String>? onChanged;
    final String? hint;
    final String? label;
    final String? suffix;
    final double? height;
    final double? width;

    const NumField({
        super.key,
        this.keyboardType = TextInputType.text,
        this.inputFormatters,
        this.focusNode,
        this.onSubmitted,
        this.onChanged,
        this.hint,
        this.label,
        this.suffix,
        this.height = 40,
        this.width,
        this.controller,

    });

    @override
    Widget build(BuildContext context) {
        return SizedBox(
            height: height,
            width: width,
            child: TextField(
                focusNode: focusNode,
                controller: controller,
                textAlign: TextAlign.center, 
                textAlignVertical: TextAlignVertical.center,
                keyboardType: TextInputType.numberWithOptions(decimal: true), 
                inputFormatters: [
                    FilteringTextInputFormatter.allow(
                        RegExp(r'^\d*\.?\d*'),
                    ),
                ],
                onChanged: onChanged,
                onSubmitted: onSubmitted,
                onTapOutside: (_) {focusNode?.unfocus();},
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.zero,
                    border: OutlineInputBorder(),
                    labelText: label,
                    labelStyle: TextStyle(fontWeight: FontWeight.bold),
                    hintText: hint,
                    hintStyle: TextStyle(color: Colors.grey),
                    suffixText: suffix
                ),
            )
        );
    }
}

class InfoRow extends StatelessWidget {
    final String firstColumn;
    final String secondColumn;
    final String thirdColumn;

    const InfoRow({
        super.key,
        required this.firstColumn,
        required this.secondColumn,
        required this.thirdColumn,
    });

    @override
    Widget build(BuildContext context) {
        return Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
                color: Colors.orangeAccent,
                border: Border.all(
                    color: Colors.brown,
                    width: 1,
                ),
                borderRadius: BorderRadius.circular(24),
            ),
            child: Table(
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                columnWidths: {0:FixedColumnWidth(210)},
                children: [
                    TableRow(
                        children: [
                            Text(firstColumn, style: TextStyle(fontWeight: FontWeight.bold),),
                            Text(secondColumn, style: TextStyle(fontWeight: FontWeight.bold)),
                            Text(thirdColumn),
                        ]
                    )
                ],
            ),
        );
    }
}

class Unit extends StatelessWidget {
    final String text;

    const Unit({
        super.key,
        required this.text,
    });

    @override
    Widget build(BuildContext context) {
        return SizedBox(
            height: 40, 
            child: Center(
                child: Text(text, 
                    style: const TextStyle(
                        fontWeight: FontWeight.bold
                    )
                )
            )
        );
    }
}

class StandardContainer extends StatelessWidget {
    final Widget child;

    const StandardContainer({
        super.key,
        required this.child,
    });

    @override
    Widget build(BuildContext context) {
        return Container(
            margin: const EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                    BoxShadow(
                        color: Colors.black26,
                        blurRadius: 4,
                        offset: Offset(0, 4),
                    ),
                ],
                border: Border.all(
                    color: Colors.black26,
                    width: 1,
                ),
                borderRadius: BorderRadius.circular(6),
            ),
            child: child,
        );
    }
}

TableRow cellSeparator(double height) {
    return TableRow(children: [
        SizedBox(height: height),
        SizedBox(height: height),
        SizedBox(height: height)
    ]);
}
