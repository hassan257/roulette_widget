library roulette_widget;

import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

/// Main class,
/// [widthRoulette] is the width which the roulette will have
/// [widthIndicator] is the width of the indicator
/// [heightIndicator] is the height of the indicator
/// [options] the list of options using the type RouletteElementModel that the roulette draw
/// [otherActions] a void function to add custom actions to the tap and drag actions
/// [heightCentralWidget] a double value to define the central widget's height
/// [widthCentralWidget] a double value to define the central widget's width
/// [centralWidget] a widget to place in the center of the roulette
/// [borderWidth] a double value to define border's width
/// [borderColor] a Color value to define border's color
class RouletteWidget extends StatelessWidget {
  const RouletteWidget({
    Key? key,
    required this.widthRoulette,
    required this.widthIndicator,
    required this.heightIndicator,
    required this.options,
    this.otherActions,
    this.heightCentralWidget,
    this.widthCentralWidget,
    this.centralWidget,
    this.borderWidth,
    this.borderColor,
  }) : super(key: key);

  final double widthRoulette;
  final double widthIndicator;
  final double heightIndicator;
  final List<RouletteElementModel> options;
  final void Function()? otherActions;
  final double? heightCentralWidget;
  final double? widthCentralWidget;
  final Widget? centralWidget;
  final double? borderWidth;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Center(
        child: Stack(
          children: [
            CustomRoulette(
              width: widthRoulette,
              options: options,
              otherActions: otherActions,
              borderWidth: borderWidth,
              borderColor: borderColor,
            ),
            Positioned(
              left: widthRoulette / 2 - widthIndicator / 2,
              top: 0,
              child: Transform.rotate(
                  angle: 160.2,
                  child: TriangleWidget(
                      width: widthIndicator, height: heightIndicator)),
            ),
            Positioned(
              top: 100 -
                  (heightCentralWidget != null ? heightCentralWidget! / 2 : 50),
              left: widthRoulette / 2 -
                  (widthCentralWidget != null ? widthCentralWidget! / 2 : 0),
              child: SizedBox(
                height: heightCentralWidget,
                width: widthCentralWidget,
                child: centralWidget,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// The circle that is showed to spin
class CustomRoulette extends StatefulWidget {
  final double? width;
  final List<RouletteElementModel> options;
  final void Function()? otherActions;
  final double? borderWidth;
  final Color? borderColor;
  const CustomRoulette(
      {Key? key,
      this.width,
      required this.options,
      this.otherActions,
      this.borderWidth,
      this.borderColor})
      : super(key: key);

  @override
  State<CustomRoulette> createState() => _CustomRouletteState();
}

class _CustomRouletteState extends State<CustomRoulette>
    with SingleTickerProviderStateMixin {
  bool isSpinning = false;
  double rotationAngle = 0;

  // ignore: unused_field
  late AnimationController _animationController;
  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    super.initState();
  }

  void _spinRoulette() {
    if (!isSpinning) {
      setState(() {
        isSpinning = true;
      });

      // Simula una espera para la animación
      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          isSpinning = false;
          final rand = Random();
          rotationAngle = rand.nextInt(360) * 2 * pi / 360;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    const double heightRoulette = 200;
    double widthRoulette = widget.width ?? 200;

    return GestureDetector(
      onTap: () {
        _spinRoulette();
        if (widget.otherActions != null) {
          widget.otherActions!();
        }
      },
      onVerticalDragEnd: (_) {
        _spinRoulette();
        if (widget.otherActions != null) {
          widget.otherActions!();
        }
      },
      onHorizontalDragEnd: (_) {
        _spinRoulette();
        if (widget.otherActions != null) {
          widget.otherActions!();
        }
      },
      child: Column(
        children: [
          Roulette(
            animate: isSpinning,
            spins: 10,
            duration: const Duration(seconds: 3),
            child: SizedBox(
              height: heightRoulette,
              width: widthRoulette,
              child: Transform.rotate(
                angle: rotationAngle,
                child: CustomPaint(
                  painter: RoulettePainter(
                      options: widget.options,
                      borderColor: widget.borderColor,
                      borderWidth: widget.borderWidth),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// The painter of the circle
class RoulettePainter extends CustomPainter {
  List<RouletteElementModel> options;
  final double? borderWidth;
  final Color? borderColor;
  RoulettePainter({this.borderColor, this.borderWidth, required this.options});
  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    final centerY = size.height / 2;
    final radius = size.width / 2;

    final sectionAngle = 2 * pi / options.length;

    double startAngle = -pi / 2;

    // Dibuja el borde exterior
    final borderPaint = Paint()
      ..color = borderColor ?? Colors.white // Puedes ajustar el color del borde
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth ?? 0; // Puedes ajustar el ancho del borde

    canvas.drawCircle(
      Offset(centerX, centerY),
      radius,
      borderPaint,
    );

    for (int i = 0; i < options.length; i++) {
      final paint = Paint()..color = options[i].color;
      canvas.drawArc(
          Rect.fromCircle(center: Offset(centerX, centerY), radius: radius),
          startAngle,
          sectionAngle,
          true,
          paint);

      startAngle += sectionAngle;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

/// The painter of the indicator
class TrianglePainter extends CustomPainter {
  final Offset p1;
  final Offset p2;
  final Offset p3;
  final Color? color;

  TrianglePainter(
      {required this.p1, required this.p2, required this.p3, this.color});

  @override
  void paint(Canvas canvas, Size size) {
    // Define el color y el estilo del lápiz
    final paint = Paint()
      ..color = color ?? Colors.black
      ..style = PaintingStyle.fill
      ..strokeWidth = 4.0;

    // Crea un objeto Path y agrega las líneas del triángulo
    final path = Path();
    path.moveTo(p1.dx, p1.dy); // Mueve el lápiz al primer punto
    path.lineTo(p2.dx, p2.dy); // Dibuja una línea al segundo punto
    path.lineTo(p3.dx, p3.dy); // Dibuja una línea al tercer punto
    path.close(); // Cierra el path para formar un polígono

    // Dibuja el path en el canvas
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

/// The indicator class
class TriangleWidget extends StatelessWidget {
  final double width;
  final double height;

  const TriangleWidget({Key? key, required this.width, required this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Calcula los puntos del triángulo según el ancho y el alto del widget
    final p1 = Offset(0, height); // Punto inferior izquierdo
    final p2 = Offset(width / 2, 0); // Punto superior medio
    final p3 = Offset(width, height); // Punto inferior derecho

    return CustomPaint(
      painter: TrianglePainter(p1: p1, p2: p2, p3: p3),
      size: Size(width, height),
    );
  }
}

/// Model of the elements to be showed in the roulette
class RouletteElementModel {
  final String text;
  final Color color;
  RouletteElementModel({required this.text, required this.color});
}
