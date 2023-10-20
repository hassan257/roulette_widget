<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->
# Route Transitions

A simple customizable roulette widget that you only have to pass the options to be showed.


## Getting started

This package is simple to use, you only need to pass the width of the roulette, the width and height of the indicator and the list of options to be showed.

## Usage

```dart
RouletteWidget(
    widthRoulette: widthRoulette, // width of the roulette
    widthIndicator: widthIndicator, // width of the indicator
    heightIndicator: heightIndicator, // height of the indicator
    // options to be showed in the roulette, every option should to be of type RouletteElementModel
    options: [
        RouletteElementModel(text: 'Option 1', color: Colors.red),
        RouletteElementModel(text: 'Option 2', color: Colors.blue),
        RouletteElementModel(text: 'Option 3', color: Colors.orange),
        RouletteElementModel(text: 'Option 4', color: Colors.green),
        RouletteElementModel(text: 'Option 5', color: Colors.yellow),
    ],
),
```
