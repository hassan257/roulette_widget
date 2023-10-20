import 'package:flutter/material.dart';

import 'package:roulette_widget/roulette_widget.dart';


void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double heightIndicator = 30;
    const double widthIndicator = 30;
    const double widthRoulette = 200;
    
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                RouletteWidget(
                  widthRoulette: widthRoulette, 
                  widthIndicator: widthIndicator, 
                  heightIndicator: heightIndicator, 
                  options: [
                    RouletteElementModel(text: 'Option 1', color: Colors.red),
                    RouletteElementModel(text: 'Option 2', color: Colors.blue),
                    RouletteElementModel(text: 'Option 3', color: Colors.orange),
                    RouletteElementModel(text: 'Option 4', color: Colors.green),
                    RouletteElementModel(text: 'Option 5', color: Colors.yellow),
                  ],
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.info, color: Colors.blueAccent,),
                    Text('Tap or Drag to Spin', style: TextStyle(fontWeight: FontWeight.w500, color: Colors.blueAccent),),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

