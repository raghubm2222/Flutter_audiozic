import 'dart:ui';

import 'package:audiozic/pages/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  ValueNotifier<double>? _sliderNotifier;

  @override
  void initState() {
    super.initState();
    _sliderNotifier = ValueNotifier<double>(1.0);
  }

  @override
  void dispose() {
    _sliderNotifier!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            color: Color(0xFFFF060DD9),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: SizedBox(
              height: size.height * 0.6,
              child: Image.asset('assets/person.png'),
            ),
          ),
          Container(
            color: Color(0xFF060DD9).withOpacity(0.5),
          ),
          Positioned(
            top: size.height * 0.15,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.camera_sharp, color: Colors.white),
                Text(
                  'Audiozic',
                  style: TextStyle(
                    fontSize: 22.0,
                    letterSpacing: 2.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
          Positioned(
            bottom: size.width * 0.25,
            width: size.width * 0.8,
            child: Container(
              height: 40.0,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(40.0),
              ),
              child: SliderTheme(
                data: SliderThemeData(
                  thumbColor: Colors.white,
                  activeTrackColor: Colors.transparent,
                  inactiveTickMarkColor: Colors.transparent,
                  thumbShape: CustomSliderThumbCircle(),
                  trackHeight: 0,
                ),
                child: Stack(
                  alignment: Alignment.centerLeft,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Text(
                        'swipe to access',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                    ValueListenableBuilder<double>(
                      valueListenable: _sliderNotifier!,
                      builder: (context, _notifierValue, _) {
                        return Slider(
                          divisions: 100,
                          value: _notifierValue,
                          onChanged: (value) {
                            _sliderNotifier!.value = value;
                          },
                          onChangeEnd: (_) {
                            _sliderNotifier!.value = 0;
                            Navigator.pushAndRemoveUntil(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => HomePage(),
                              ),
                              (route) => false,
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class CustomSliderThumbCircle extends SliderComponentShape {
  final double thumbRadius;
  final int min;
  final int max;

  const CustomSliderThumbCircle({
    this.thumbRadius = 18.0,
    this.min = 0,
    this.max = 10,
  });

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(thumbRadius);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    final Canvas canvas = context.canvas;

    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    TextSpan span = new TextSpan(
      style: new TextStyle(
        fontSize: thumbRadius * .8,
        fontWeight: FontWeight.w700,
        color: sliderTheme.thumbColor,
      ),
    );

    TextPainter tp = new TextPainter(
        text: span,
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr);
    tp.layout();
    Offset textCenter =
        Offset(center.dx - (tp.width / 2), center.dy - (tp.height / 2));
    Offset _pointsOne = Offset(center.dx - 5.0, center.dy);
    Offset _pointsTwo = Offset(center.dx + 3, center.dy - 6.0);
    Offset _pointsTheree = Offset(center.dx + 3, center.dy + 6.0);
    canvas.drawCircle(center, thumbRadius * .9, paint);
    canvas.drawPoints(
      PointMode.polygon,
      [
        _pointsTwo,
        _pointsOne,
        _pointsTheree,
      ],
      Paint()
        ..color = Color(0xFFFF060DD9)
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round
        ..strokeWidth = 2.0,
    );
    tp.paint(canvas, textCenter);
  }
}
