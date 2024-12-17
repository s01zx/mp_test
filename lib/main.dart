import 'package:flutter/material.dart';
import 'package:mp_test/resources/routes.dart';
import 'package:mp_test/resources/sizeConfig.dart';
import 'package:mp_test/screens/welcome/welcome.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return OrientationBuilder(
          builder: (context, orientation) {
            SizeConfig().init(constraints, orientation);
            return SafeArea(
              child: MaterialApp(
                title: 'MP Test',
                theme: ThemeData(
                  colorScheme:
                      ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                  useMaterial3: true,
                  fontFamily: 'Glancesans',
                ),
                home: const WelcomeScreen(),
                routes: routes,
              ),
            );
          },
        );
      },
    );
  }
}
