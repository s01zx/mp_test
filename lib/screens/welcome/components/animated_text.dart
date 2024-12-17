import 'package:flutter/material.dart';
import 'package:mp_test/resources/colors.dart';
import 'package:mp_test/resources/helper_widgets.dart';

class AnimatedText extends StatefulWidget {
  final int targetValue;
  final bool isloactioncolor;

  const AnimatedText(
      {super.key, required this.targetValue, this.isloactioncolor = false});

  @override
  State<AnimatedText> createState() => _AnimatedTextState();
}

class _AnimatedTextState extends State<AnimatedText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<int> _counterAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _counterAnimation = IntTween(begin: 0, end: widget.targetValue).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.1, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _counterAnimation,
      builder: (context, child) {
        return ScaleTransition(
          scale: _scaleAnimation,
          child: appText(
            _counterAnimation.value.toString(),
            30,
            weight: FontWeight.w600,
            color: widget.isloactioncolor
                ? locationiconcolor
                : const Color(0xfffbf5eb),
            bottommargin: 10.0,
          ),
        );
      },
    );
  }
}
