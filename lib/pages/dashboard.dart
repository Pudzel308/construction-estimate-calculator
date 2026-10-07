import 'package:flutter/material.dart';
import 'concrete.dart';

class Dashboard extends StatelessWidget {
    const Dashboard({super.key});

    void _press() {

    }

    @override
    Widget build(BuildContext context) {

        final ButtonStyle dshButton = OutlinedButton.styleFrom(
            fixedSize: Size.square(180),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        );
        
        return Scaffold(
            appBar: AppBar(
                toolbarHeight: 90,
                title:const Text("Estimator")
            ),
            body: SingleChildScrollView(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                        Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                                OutlinedButton(
                                    onPressed: () {
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => const Concrete()));
                                    },
                                    style: dshButton,
                                    child: Text("CONCRETING"),
                                ),
                                SizedBox(height: 10),
                                OutlinedButton(
                                    onPressed: _press,
                                    style: dshButton,
                                    child: Text("MASONRY"),
                                ),
                                SizedBox(height: 10),
                                OutlinedButton(
                                    onPressed: _press,
                                    style: dshButton,
                                    child: Text("REINFORCEMENT"),
                                ),
                                SizedBox(height: 10),
                                OutlinedButton(
                                    onPressed: _press,
                                    style: dshButton,
                                    child: Text("CARPENTRY"),
                                ),
                            ],
                        ),
                        SizedBox(width: 10),
                        Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                                OutlinedButton(
                                    onPressed: _press,
                                    style: dshButton,
                                    child: Text("ROOFING WORKS"),
                                ),
                                SizedBox(height: 10),
                                OutlinedButton(
                                    onPressed: _press,
                                    style: dshButton,
                                    child: Text("TILING WORKS"),
                                ),
                                SizedBox(height: 10),
                                OutlinedButton(
                                    onPressed: _press,
                                    style: dshButton,
                                    child: Text("PAINTING WORKS"),
                                ),
                                SizedBox(height: 10),
                                OutlinedButton(
                                    onPressed: _press,
                                    style: dshButton,
                                    child: Text("SCAFFOLDING"),
                                ),
                            ],
                        ),
                    ],
                ),
            ),
        );

    }
}
