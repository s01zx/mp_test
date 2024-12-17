import 'package:flutter/material.dart';
import 'package:mp_test/resources/colors.dart';
import 'package:mp_test/resources/helper_functions.dart';
import 'package:mp_test/resources/helper_widgets.dart';

class MarkerView extends StatefulWidget {
  const MarkerView({super.key, required this.tx});
  final String tx;

  @override
  State<MarkerView> createState() => _MarkerViewState();
}

class _MarkerViewState extends State<MarkerView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _widthAnimation;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _widthAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut, // Smooth animation curve
      ),
    );
    Future.delayed(Durations.medium4).then((_) => _controller.forward());
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _widthAnimation,
      builder: (context, child) {
        return ClipRect(
          child: Align(
            alignment: Alignment.bottomLeft,
            widthFactor: _widthAnimation.value,
            child: child,
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.all(calculateSize(12)),
        decoration: const BoxDecoration(
          color: orangelike,
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(8),
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
          ),
        ),
        child: appText(widget.tx, 12, color: Colors.white),
      ),
    );
  }
}
