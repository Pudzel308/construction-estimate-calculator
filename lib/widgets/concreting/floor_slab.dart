import 'package:flutter/material.dart';

class FloorSlab extends StatelessWidget {
    const FloorSlab({super.key});

    final double text_Width = 100;

    @override
    Widget build(BuildContext context) {
        return Column(
            children: [
                Divider(),
                SizedBox(height: 30,),
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
                                        SizedBox(height: 10),
                                        SizedBox(height: 40, child: Center(child: Text("Concrete(CLASS)"))),
                                    ]),
                                Column(
                                    children: [
                                        SizedBox(height: 40, child: Center(child: Text("L(M)", style: const TextStyle(fontWeight: FontWeight.bold)))),
                                        SizedBox(height: 10),
                                        SizedBox(height: 40, child: Center(child: Text("W(M)", style: const TextStyle(fontWeight: FontWeight.bold)))),
                                        SizedBox(height: 10),
                                        SizedBox(height: 40, child: Center(child: Text("T(M)", style: const TextStyle(fontWeight: FontWeight.bold)))),
                                        SizedBox(height: 10),
                                        SizedBox(height: 40, child: Center(child: Text("AA, A, or E", style: const TextStyle(fontWeight: FontWeight.bold)))),
                                    ]),
                                Column(
                                    children: [
                                        SizedBox(
                                            width: text_Width, 
                                            height: 40, 
                                            child: TextField(
                                                textAlign: TextAlign.center, 
                                                textAlignVertical: TextAlignVertical.center,
                                                decoration: const InputDecoration(
                                                    contentPadding: EdgeInsets.zero,
                                                    border: OutlineInputBorder()
                                                ),
                                            )
                                        ),
                                        SizedBox(height: 10),
                                        SizedBox(
                                            width: text_Width, 
                                            height: 40, 
                                            child: TextField(
                                                textAlign: TextAlign.center, 
                                                textAlignVertical: TextAlignVertical.center,
                                                decoration: const InputDecoration(
                                                    contentPadding: EdgeInsets.zero,
                                                    border: OutlineInputBorder()
                                                ),
                                            )
                                        ),
                                        SizedBox(height: 10),
                                        SizedBox(
                                            width: text_Width, 
                                            height: 40, 
                                            child: TextField(
                                                textAlign: TextAlign.center, 
                                                textAlignVertical: TextAlignVertical.center,
                                                decoration: const InputDecoration(
                                                    contentPadding: EdgeInsets.zero,
                                                    border: OutlineInputBorder()
                                                ),
                                            )
                                        ),
                                        SizedBox(height: 10),
                                        SizedBox(
                                            width: text_Width, 
                                            height: 40, 
                                            child: TextField(
                                                textAlign: TextAlign.center, 
                                                textAlignVertical: TextAlignVertical.center,
                                                decoration: const InputDecoration(
                                                    contentPadding: EdgeInsets.zero,
                                                    border: OutlineInputBorder()
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
                                        SizedBox(height: 10),
                                        SizedBox(height: 40, child: Center(child: Text("1:2:4", style: const TextStyle(fontWeight: FontWeight.bold)))),
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
                                Text("0.0"),
                                Text(
                                    "CU.M",
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                )
                            ]),
                    ]),
                )
            ],
        );
    }
}
