import 'package:construct/widgets/concreting/floor_slab.dart';
import 'package:construct/widgets/concreting/floor_slab_area.dart';
import 'package:construct/widgets/concreting/footing.dart';
import 'package:construct/widgets/concreting/wall_footing.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:in_app_calculator/in_app_calculator.dart';
import 'package:units_converter/units_converter.dart';

class Concrete extends StatefulWidget{
    const Concrete({super.key});

    @override
    State<Concrete> createState() => _ConcreteState();
}

class _ConcreteState extends State<Concrete> {
    int selected = 0;

    Widget getPanel() {
        switch (selected) {
            case 0:
                return const Footing();
            case 1:
                return const WallFooting();
            case 2:
                return const FloorSlab();
            case 3:
                return const FloorSlabArea();
            default:
                return const SizedBox();
        }

    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            floatingActionButton: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                    FloatingActionButton(
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
                    FloatingActionButton(onPressed: () {}, child: Icon(Icons.percent),)
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
                                        Text(
                                            "NO. OF CEMENT:",
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                            ),
                                        ),
                                        Text("BAGS"),
                                        Text("0.0"),
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
                                        Text(
                                            "VOL. OF SAND:",
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                            ),
                                        ),
                                        Text("CU.M"),
                                        Text("0.0"),
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
                                        Text(
                                            "VOL. OF 3/4\" GRAVEL:",
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                            ),
                                        ),
                                        Text("CU.M"),
                                        Text("0.0"),
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
