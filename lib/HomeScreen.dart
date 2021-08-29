
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = 'homeScreen';
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(color: Colors.white),
          child: Image.asset(
            'assets/TopScreen.png',
            fit: BoxFit.fill,
            width: double.infinity,
            height: double.infinity,
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          floatingActionButton: FloatingActionButton(
            onPressed: (){
            },
            child: Icon(Icons.add),
          ),
        ),
      ],
    );
  }
}
