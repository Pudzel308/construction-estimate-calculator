import 'package:construct/widgets/visualization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

    final double text_Width = 100;

    @override
    Widget build(BuildContext context) {
        final fLen = FocusNode();
        final fWid = FocusNode();
        final fThic = FocusNode();
        final fNum = FocusNode();

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
                Container(
                    margin: const EdgeInsets.only(left: 10, right: 10, top: 30, bottom: 30),
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
                    child: Column(children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                                Column(
                                    children: [
                                        SizedBox(height: 40, child: Center(child: Text("Length: "))),
                                        SizedBox(height: 10),
                                        SizedBox(height: 40, child: Center(child: Text("Width: "))),
                                        SizedBox(height: 10),
                                        SizedBox(height: 40, child: Center(child: Text("Thickness: "))),
                                    ]),
                                Column(
                                    children: [
                                        SizedBox(
                                            width: text_Width, 
                                            height: 40, 
                                            child: TextField(
                                                focusNode: fLen,
                                                textAlign: TextAlign.center, 
                                                textAlignVertical: TextAlignVertical.center,
                                                keyboardType: const TextInputType.numberWithOptions(decimal: true), 
                                                inputFormatters: [
                                                    FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                                                ],
                                                onChanged: (value) {
                                                    widget.onLengthChanged(
                                                        double.tryParse(value) ?? 0,
                                                    );
                                                },
                                                onSubmitted: (_) {fWid.requestFocus();},
                                                decoration: const InputDecoration(
                                                    contentPadding: EdgeInsets.zero,
                                                    border: OutlineInputBorder(),
                                                    hintText: 'L(M)',
                                                    hintStyle: TextStyle(color: Colors.grey)
                                                ),
                                            )
                                        ),
                                        SizedBox(height: 10),
                                        SizedBox(
                                            width: text_Width, 
                                            height: 40, 
                                            child: TextField(
                                                focusNode: fWid,
                                                textAlign: TextAlign.center, 
                                                textAlignVertical: TextAlignVertical.center,
                                                keyboardType: const TextInputType.numberWithOptions(decimal: true), 
                                                inputFormatters: [
                                                    FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                                                ],
                                                onChanged: (value) {
                                                    widget.onWidthChanged(
                                                        double.tryParse(value) ?? 0,
                                                    );
                                                },
                                                onSubmitted: (_) {fThic.requestFocus();},
                                                decoration: const InputDecoration(
                                                    contentPadding: EdgeInsets.zero,
                                                    border: OutlineInputBorder(),
                                                    hintText: 'W(M)',
                                                    hintStyle: TextStyle(color: Colors.grey)
                                                ),
                                            )
                                        ),
                                        SizedBox(height: 10),
                                        SizedBox(
                                            width: text_Width, 
                                            height: 40, 
                                            child: TextField(
                                                focusNode: fThic,
                                                textAlign: TextAlign.center, 
                                                textAlignVertical: TextAlignVertical.center,
                                                keyboardType: const TextInputType.numberWithOptions(decimal: true), 
                                                inputFormatters: [
                                                    FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                                                ],
                                                onChanged: (value) {
                                                    widget.onThicknessChanged(
                                                        double.tryParse(value) ?? 0,
                                                    );
                                                },
                                                onSubmitted: (_) {fNum.requestFocus();},
                                                decoration: const InputDecoration(
                                                    contentPadding: EdgeInsets.zero,
                                                    border: OutlineInputBorder(),
                                                    hintText: 'T(M)',
                                                    hintStyle: TextStyle(color: Colors.grey)
                                                ),
                                            )
                                        ),
                                    ]),
                                Column(
                                    children: [
                                        SizedBox(height: 40, child: Center(child: Text("M", style: const TextStyle(fontWeight: FontWeight.bold)))),
                                        SizedBox(height: 10),
                                        SizedBox(height: 40, child: Center(child: Text("M", style: const TextStyle(fontWeight: FontWeight.bold)))),
                                        SizedBox(height: 10),
                                        SizedBox(height: 40, child: Center(child: Text("M", style: const TextStyle(fontWeight: FontWeight.bold)))),
                                    ])
                            ],
                        ),
                        SizedBox(height: 50),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                                Text(
                                    "TOTAL VOLUME OF CONCRETE:",
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(widget.vol.toStringAsFixed(2), style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
                                Text(
                                    "CU.M",
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                )
                            ]),
                        SizedBox(height: 50),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                                Column(
                                    children: [
                                        SizedBox(height: 40, child: Center(child: Text("No. of Footing:"))),
                                    ]),
                                Column(
                                    children: [
                                        SizedBox(
                                            width: text_Width, 
                                            height: 40, 
                                            child: TextField(
                                                focusNode: fNum,
                                                textAlign: TextAlign.center, 
                                                textAlignVertical: TextAlignVertical.center,
                                                keyboardType: TextInputType.number, 
                                                inputFormatters: [
                                                    FilteringTextInputFormatter.digitsOnly,
                                                ],
                                                onSubmitted: (_) {fNum.unfocus();},
                                                onChanged: (value) {
                                                    widget.onNumberChanged(
                                                        double.tryParse(value) ?? 0,
                                                    );
                                                },
                                                decoration: const InputDecoration(
                                                    contentPadding: EdgeInsets.zero,
                                                    border: OutlineInputBorder(),
                                                    hintText: 'amount',
                                                    hintStyle: TextStyle(color: Colors.grey)

                                                ),
                                            )
                                        ),
                                    ]),
                                Column(
                                    children: [
                                        SizedBox(height: 40, child: Center(child: Text("Units", style: const TextStyle(fontWeight: FontWeight.bold)))),
                                    ])
                            ],
                        ),
                        SizedBox(height: 30),
                        Divider(),
                        SizedBox(height: 30),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                                Text(
                                    "TOTAL VOLUME OF CONCRETE:",
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(widget.nvol.toStringAsFixed(2), style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
                                Text(
                                    "CU.M",
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                )
                            ]),
                    ]),
                ),
                Container(
                    margin: const EdgeInsets.only(left: 10, right: 10),
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
                    child: Column(children: [
                        Container(
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                                color: Colors.orangeAccent,
                                border: Border.all(
                                    color: Colors.brown,
                                    width: 1,
                                ),
                                borderRadius: BorderRadius.circular(16),
                            ),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                    SizedBox(
                                        width: 200,
                                        child: 
                                        Text(
                                            "NO. OF CEMENT:",
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                            ),
                                        ),
                                    ),
                                    Text(cementBags.toString(), style: TextStyle(fontWeight: FontWeight.bold)),
                                    Text("BAGS"),
                                ]
                            )
                        ),
                        Container(
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                                color: Colors.orangeAccent,
                                border: Border.all(
                                    color: Colors.brown,
                                    width: 1,
                                ),
                                borderRadius: BorderRadius.circular(16),
                            ),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                    SizedBox(
                                        width: 200,
                                        child: 
                                        Text(
                                            "VOL. OF SAND:",
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                            ),
                                        ),
                                    ),
                                    Text(volSand.toString(), style: TextStyle(fontWeight: FontWeight.bold)),
                                    Text("CU.M"),
                                ]
                            )
                        ),
                        Container(
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                                color: Colors.orangeAccent,
                                border: Border.all(
                                    color: Colors.brown,
                                    width: 1,
                                ),
                                borderRadius: BorderRadius.circular(16),
                            ),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                    SizedBox(
                                        width: 200,
                                        child: 
                                        Text(
                                            "VOL. OF 3/4\" GRAVEL:",
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                            ),
                                        ),
                                    ),
                                    Text(volGravel.toString(), style: TextStyle(fontWeight: FontWeight.bold)),
                                    Text("CU.M"),
                                ]
                            )
                        ),
                        SizedBox(height: 90,)
                    ])
                )
            ],
        );
    }
}
