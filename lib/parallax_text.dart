
import 'dart:math';

import 'package:flutter/material.dart';

class ParallaxText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final int index;
  final double currentPage;
  final double parallaxFraction;
  final double cardWidth;

  const ParallaxText(
      {super.key,
      required this.text,
      required this.index,
      required this.currentPage,
      required this.cardWidth,
      this.style,
      this.parallaxFraction = 0.24});

  @override
  Widget build(BuildContext context) {
    return Opacity(
        opacity: 1 - max(-1, min(1, (index - currentPage))).abs().toDouble(),
        child: Transform(
          transform: Matrix4.translationValues(
              cardWidth *
                  parallaxFraction *
                  max(-1, min(1, (index - currentPage))),
              0,
              0),
          child: Text(
            text,
            style: style,
            textAlign: TextAlign.center,
          ),
        ));
  }
}
