import 'package:construct/widgets/visualization.dart';
import 'package:flutter/material.dart';
import 'package:construct/widgets/num_field.dart';

class Footing extends StatefulWidget {
    final ValueChanged<double> onLengthChanged;
    final ValueChanged<double> onWidthChanged;
    final ValueChanged<double> onThicknessChanged;
    final ValueChanged<double> onNumberChanged;

    final double length;
    final double width;
    final double thickness;
    final double number;
    final double vol;
    final double nvol;

    const Footing({
        super.key,
        required this.onLengthChanged,
        required this.onWidthChanged,
        required this.onThicknessChanged,
        required this.onNumberChanged,
        required this.length,
        required this.width,
        required this.thickness,
        required this.number,
        required this.vol,
        required this.nvol,
    });

    @override
    State<Footing> createState() => _FootingState();
}

class _FootingState extends State<Footing> {
    final fLen = FocusNode();
    final fWid = FocusNode();
    final fThic = FocusNode();
    final fNum = FocusNode();

    double get volume {
        return (widget.length * widget.width * widget.thickness) * widget.number;
    }
    double roundUp1(double value) {
        return (value * 10).ceil() / 10;
    }
    double get cementBags {
        return ( volume * 9 ).ceilToDouble();
    }

    double get volSand {
        return roundUp1(volume * 0.5);
    }

    double get volGravel {
        return roundUp1(volume * 1);
    }

    final double textwidth = 100;

    @override
    Widget build(BuildContext context) {
        return Column(
            children: [
                IsometricBox(length: widget.length, width: widget.width, thickness: widget.thickness),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                        Text("Formula:"),
                        Text(
                            "VOLUME = L * W * T",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18
                            ),
                        )
                    ],),
                StandardContainer(
                    child: Column(children: [
                        Table(
                            columnWidths: {2: FixedColumnWidth(80)},
                            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                            children: [
                                TableRow(children: [
                                    Text('Length:'),
                                    NumField(
                                        width: textwidth,
                                        focusNode: fLen,
                                        onSubmitted: (_) {fWid.requestFocus();},
                                        onChanged: (value) {
                                            widget.onWidthChanged(double.tryParse(value) ?? 0);
                                        },
                                        hint: 'L(m)',
                                    ),
                                    Unit(text: 'm')
                                ]
                                ),
                                cellSeparator(10),
                                TableRow(children: [
                                    Text('Width:'),
                                    NumField(
                                        width: textwidth,
                                        focusNode: fWid,
                                        onSubmitted: (_) {fThic.requestFocus();},
                                        onChanged: (value) {
                                            widget.onLengthChanged(double.tryParse(value) ?? 0);
                                        },
                                        hint: 'W(m)',
                                    ),
                                    Unit(text: 'm')
                                ]
                                ),
                                cellSeparator(10),
                                TableRow(children: [
                                    Text('Thickness:'),
                                    NumField(
                                        width: textwidth,
                                        focusNode: fThic,
                                        onSubmitted: (_) {fNum.requestFocus();},
                                        onChanged: (value) {
                                            widget.onThicknessChanged(double.tryParse(value) ?? 0);
                                        },
                                        hint: 'T(m)',
                                    ),
                                    Unit(text: 'm')
                                ]
                                ),
                                cellSeparator(10),
                                TableRow(
                                    children: [
                                        Text("Total Volume of Concrete:"),
                                        Center(child: 
                                            Text(widget.vol.toStringAsFixed(2), style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
                                        ),
                                        Unit(text: "CU.M")
                                    ]),
                                cellSeparator(10),
                                TableRow(children: [
                                    Text('No. of Footing:'),
                                    NumField(
                                        width: textwidth,
                                        focusNode: fNum, 
                                        onSubmitted: (_) {fNum.unfocus();},
                                        onChanged: (value) {
                                            widget.onNumberChanged(double.tryParse(value) ?? 0);
                                        },
                                        hint: 'number',
                                    ),
                                    Unit(text: "UNITS")
                                ]
                                )
                            ],
                        ),
                        SizedBox(height: 30),
                        Divider(),
                        SizedBox(height: 30),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                                Unit(text: "TOTAL VOLUME OF CONCRETE:"),
                                Text(widget.nvol.toStringAsFixed(2), style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
                                Unit(text: "CU.M")
                            ]),
                    ]),
                ),
                StandardContainer(
                    child: Column(children: [
                        InfoRow(firstColumn: 'NO. OF CEMENT:', secondColumn: cementBags.toString(), thirdColumn: 'BAGS'),
                        InfoRow(firstColumn: 'VOL. OF SAND:', secondColumn: volSand.toString(), thirdColumn: 'CU.M'),
                        InfoRow(firstColumn: 'VOL. OF 3/4" GRAVEL:', secondColumn: volGravel.toString(), thirdColumn: 'CU.M'),
                        SizedBox(height: 90,)
                    ])
                )
            ],
        );
    }
}
