import 'dart:math';

import 'package:flutter/material.dart';

class IntroCard extends StatelessWidget {
  final int index;
  final double currentPage;
  final Widget? background;
  final double maxWidth;
  final double backgroundParallaxFraction;
  final LinearGradient? overlayGradient;
  final List<Widget>? children;

  const IntroCard(
      {super.key,
      required this.index,
      required this.currentPage,
      required this.maxWidth,
      this.background,
      this.backgroundParallaxFraction = 0.2,
      this.overlayGradient,
      this.children});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      key: ValueKey(index),
      clipBehavior: Clip.hardEdge,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Align(
            alignment: FractionalOffset(
                0.5 +
                    backgroundParallaxFraction *
                        max(-1, min(1, (index - currentPage))),
                0),
            child: SizedBox.expand(child: background),
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: overlayGradient ??
                  const LinearGradient(
                      colors: [Colors.black, Colors.transparent],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter),
            ),
          ),
          Align(
            alignment: Alignment.center + const Alignment(0, 0.8),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: maxWidth * 0.15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: children ?? [],
              ),
            ),
          )
        ],
      ),
    );
  }
}
