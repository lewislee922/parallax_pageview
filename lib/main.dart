import 'package:flutter/material.dart';

import 'intro_card.dart';
import 'intro_item.dart';
import 'parallax_text.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  final double? width;
  const HomePage({super.key, this.width});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late PageController _controller;
  late ValueNotifier<double> _currentPageNotifier;

  @override
  void initState() {
    super.initState();
    _currentPageNotifier = ValueNotifier<double>(0.0);
    _controller = PageController(viewportFraction: 0.8)
      ..addListener(() {
        _currentPageNotifier.value = _controller.page ?? 0.0;
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    _currentPageNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.8,
            child: PageView.builder(
                controller: _controller,
                scrollDirection: Axis.horizontal,
                itemCount: sampleItems.length,
                itemBuilder: (context, index) {
                  return ValueListenableBuilder(
                      valueListenable: _currentPageNotifier,
                      builder: (context, value, child) {
                        return LayoutBuilder(builder: (context, constraints) {
                          return IntroCard(
                            maxWidth: constraints.maxWidth,
                            index: index,
                            currentPage: value,
                            background: Image.asset(
                              sampleItems[index].imageUrl,
                              fit: BoxFit.cover,
                            ),
                            children: [
                              ParallaxText(
                                text: sampleItems[index].category,
                                index: index,
                                currentPage: value,
                                parallaxFraction: 0.3,
                                cardWidth: constraints.maxWidth,
                                style: textTheme.bodySmall!.copyWith(
                                  color: Colors.white70,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 2.0,
                                  fontSize: 14.0,
                                ),
                              ),
                              SizedBox(height: constraints.maxHeight * 0.02),
                              ParallaxText(
                                text: sampleItems[index].title,
                                index: index,
                                currentPage: value,
                                cardWidth: constraints.maxWidth,
                                style: textTheme.titleSmall!.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          );
                        });
                      });
                }),
          ),
        ),
      ),
    );
  }
}
