

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class animatedText extends StatelessWidget {
  const animatedText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(20)),
      child: Container(
        height: 200,
        width: MediaQuery.of(context).size.width-50,
        color: Theme.of(context).cardColor,
        child: Center(
          child: AnimatedTextKit(
            animatedTexts: [
              TypewriterAnimatedText(
                'Heloka',
                textStyle: const TextStyle(
                  fontSize: 32.0,
                  fontWeight: FontWeight.bold,
                ),
                speed: const Duration(milliseconds: 1000),
              ),
            ],
          ),
        ),
      ),
    );
  }
}