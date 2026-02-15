import 'package:blablacar/widgets/actions/bla_button.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyTestApp());
}

class MyTestApp extends StatelessWidget {
  const MyTestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Column(
          children: [
            BlaButton(text: "Primary", onPressed: () {}),
            SizedBox(height: 20),
            BlaButton(
              text: "Secondary",
              onPressed: () {},
              variant: ButtonVariant.secondary,
            ),
          ],
        ),
      ),
    );
  }
}
