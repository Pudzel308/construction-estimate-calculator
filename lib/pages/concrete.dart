import 'package:construct/widgets/concreting/floor_slab.dart';
import 'package:construct/widgets/concreting/floor_slab_area.dart';
import 'package:construct/widgets/concreting/footing.dart';
import 'package:construct/widgets/concreting/wall_footing.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:in_app_calculator/in_app_calculator.dart';
import 'package:units_converter/units_converter.dart';
import 'package:construct/widgets/visualization.dart';
import 'dart:math' as math;

class Concrete extends StatefulWidget{
    const Concrete({super.key});

    @override
    State<Concrete> createState() => _ConcreteState();
}

class _ConcreteState extends State<Concrete> {
    int selected = 0;
    int unit = 0;

    double length = 100;
    double width = 100;
    double thickness = 10;
    double number = 1;

    double get volume {
        return (length * width * thickness) * number;
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

    Widget getPanel() {
        switch (selected) {
            case 0:
                final double vol = length * width * thickness;
                final double nvol = vol * number;
                return Footing(
                    length: length,
                    width: width,
                    thickness: thickness,
                    vol: vol,
                    nvol: nvol,
                    onLengthChanged: (value) {
                        setState(() {
                            length = value;
                        });
                    },
                    onWidthChanged: (value) {
                        setState(() {
                            width = value;
                        });
                    },
                    onThicknessChanged: (value) {
                        setState(() {
                            thickness = value;
                        });
                    },
                    onNumberChanged: (value) {
                        setState(() {
                            number = value;
                        });
                    },
                );
            case 1:
                return const WallFooting();
            case 2:
                return const FloorSlab();
            case 3:
                return const FloorSlabArea();
            default:
                return const SizedBox(height: 80, child: Column(children: [SizedBox(height: 30), Text("There's nothing here.")]));
        }

    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            floatingActionButton: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                    FloatingActionButton(
                        heroTag: null,
                        onPressed: () {
                            showDialog(
                                context: context, 
                                builder: (context) {
                                    return Dialog(
                                        backgroundColor: Colors.transparent,
                                        child: 
                                        InAppCalculator(isDarkMode: false, onResultCalculated: (result) {
                                        }),
                                    );
                                }
                            );
                        },
                        child: const Icon(Icons.calculate),
                    ),
                    SizedBox(width: 20,),
                    FloatingActionButton(
                        heroTag: null,
                        onPressed: () {
                            showDialog(
                                context: context, 
                                builder: (context) {
                                    return Dialog(
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                        backgroundColor: Colors.white,
                                        child: Padding(
                                            padding: const EdgeInsets.all(32),
                                            child: SizedBox(
                                                height: 300,
                                                child: Column(
                                                    children: [
                                                        Text(
                                                            "Unit Converter",
                                                            style: TextStyle(fontWeight:FontWeight.bold),
                                                        ),
                                                        SizedBox(height: 30),
                                                        Divider(),
                                                        SizedBox(width: 30,),
                                                        SizedBox(
                                                            height: 50,
                                                            width: 200,
                                                            child: DropdownButtonFormField<int>(
                                                            initialValue: unit,
                                                            decoration: InputDecoration(
                                                                border: OutlineInputBorder(
                                                                    borderRadius: BorderRadius.circular(4),
                                                                ),
                                                                filled: true,
                                                                fillColor: Colors.white,
                                                            ),
                                                            items: [
                                                                DropdownMenuItem(
                                                                    value: 0,
                                                                    child: Text("Length")
                                                                ),
                                                                DropdownMenuItem(
                                                                    value: 1,
                                                                    child: Text("Area")
                                                                ),
                                                                DropdownMenuItem(
                                                                    value: 2,
                                                                    child: Text("Volume")
                                                                ),
                                                                DropdownMenuItem(
                                                                    value: 3,
                                                                    child: Text("Mass")
                                                                ),
                                                            ], 
                                                            onChanged: (value) {
                                                                setState(() {
                                                                    unit = value!;
                                                                });
                                                            }
                                                        ),
                                                        ),
                                                        SizedBox(height: 50,),
                                                        Container(
                                                            height: 40,
                                                            padding: const EdgeInsets.all(6),
                                                            margin: const EdgeInsets.only(bottom: 10),
                                                            decoration: BoxDecoration(
                                                                border: Border.all(
                                                                    color: Colors.brown,
                                                                    width: 1,
                                                                ),
                                                                borderRadius: BorderRadius.circular(6),
                                                            ),
                                                            child: Row(
                                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                children: [
                                                                    Text("From:"),
                                                                    SizedBox(width: 100,child: TextField()),
                                                                    Text("Meters")
                                                                ])
                                                        ),
                                                        SizedBox(height: 20,),
                                                        Container(
                                                            height: 40,
                                                            padding: const EdgeInsets.all(6),
                                                            margin: const EdgeInsets.only(bottom: 10),
                                                            decoration: BoxDecoration(
                                                                border: Border.all(
                                                                    color: Colors.brown,
                                                                    width: 1,
                                                                ),
                                                                borderRadius: BorderRadius.circular(6),
                                                            ),
                                                            child: Row(
                                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                children: [
                                                                    Text("To:"),
                                                                    SizedBox(width: 100,child: TextField()),
                                                                    Text("Feet")
                                                                ])
                                                        ),
                                                    ]
                                                ),
                                            )
                                        ),
                                    );
                                }
                            );
                        }, 
                        child: Icon(Icons.percent),)
                ]),
            appBar: AppBar(
                toolbarHeight: 90,
                title:const Text("Concreting"), 
                backgroundColor: Colors.orangeAccent,
                actions: [
                    SizedBox(
                        width: 290,
                        child: 
                        DropdownButtonFormField<int>(
                        initialValue: selected,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                        ),
                        items: [
                            DropdownMenuItem(
                                value: 0,
                                child: Text("Footing"),
                            ),
                            DropdownMenuItem(
                                value: 1,
                                child: Text("Wall Footing"),
                            ),
                            DropdownMenuItem(
                                value: 2,
                                child: Text("Floor Slab"),
                            ),
                            DropdownMenuItem(
                                value: 3,
                                child: Text("Floor Slab - By Area"),
                            ),
                            DropdownMenuItem(
                                value: 4,
                                child: Text("Concrete Columns Rectangular"),
                            ),
                            DropdownMenuItem(
                                value: 5,
                                child: Text("Concrete Columns Circular"),
                            ),
                            DropdownMenuItem(
                                value: 6,
                                child: Text("Concrete Beams"),
                            ),
                            DropdownMenuItem(
                                value: 7,
                                child: Text("Concrete Stairs"),
                            ),
                        ],
                        onChanged: (value) {
                            setState(() {
                                selected = value!;
                            });
                        },
                    ),
                    ),
                    SizedBox(width: 50)
                ],),
            body: SingleChildScrollView(
                child: Column(children: [
                    IsometricBox(length: length, width: width, thickness: thickness),
                    getPanel(),
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
                ]),
            ),
        );
    }
}
