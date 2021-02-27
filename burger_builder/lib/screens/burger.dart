import 'package:flutter/material.dart';

class Burger extends StatefulWidget {
  const Burger({Key key}) : super(key: key);

  @override
  _BurgerState createState() => _BurgerState();
}

class _BurgerState extends State<Burger> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Expanded(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("bread-top"),
                  Text("Ingredients"),
                  Text("bread-bottom"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
