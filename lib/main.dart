import 'package:construct/pages/dashboard.dart';
import 'package:flutter/material.dart';

void main() {
    runApp(const MaterialApp(
        home: dashboard(),
    ));
}

class dashboard extends StatelessWidget {
    const dashboard({super.key});


    @override
    Widget build(BuildContext context) {
        return MaterialApp(
            theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(
                    seedColor: Colors.orangeAccent,
                ),
            ),
            home: Dashboard(),
        );
    }
}
