import 'package:construct/widgets/concreting/floor_slab.dart';
import 'package:construct/widgets/concreting/floor_slab_area.dart';
import 'package:construct/widgets/concreting/footing.dart';
import 'package:construct/widgets/concreting/wall_footing.dart';
import 'package:flutter/material.dart';
import 'package:in_app_calculator/in_app_calculator.dart';
import 'package:construct/widgets/units_converter.dart';

class Concrete extends StatefulWidget{
    const Concrete({super.key});

    @override
    State<Concrete> createState() => _ConcreteState();
}

class _ConcreteState extends State<Concrete> {
    int selected = 0;

    double length = 1;
    double width = 1;
    double thickness = 0.5;
    double number = 1;

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
                    number: number,
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
                final double vol = length * width * thickness;
                final double nvol = vol * number;
                return WallFooting(
                    length: length,
                    width: width,
                    thickness: thickness,
                    vol: vol,
                    nvol: nvol,
                    number: number,
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
                                    return SizedBox(child: 
                                        Dialog(
                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                            backgroundColor: Colors.white,
                                            child: Padding(
                                                padding: const EdgeInsets.all(32),
                                                child: SizedBox(
                                                    height: 300,
                                                    child: UnitsConverter(),
                                                )
                                            ),
                                        )
                                    );

                                }
                            );
                        }, 
                        child: Icon(Icons.percent),
                    )
                ]),
            appBar: AppBar(
                toolbarHeight: 90,
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
                    getPanel(),
                ]),
            ),
        );
    }
}
