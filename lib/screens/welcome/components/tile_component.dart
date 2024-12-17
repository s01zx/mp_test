import 'package:flutter/material.dart';
import 'package:mp_test/resources/colors.dart';
import 'package:mp_test/resources/helper_functions.dart';
import 'package:mp_test/resources/helper_widgets.dart';

class Tile extends StatefulWidget {
  Tile({super.key, required this.imgassest, required this.text});

  String imgassest;
  String text;

  @override
  State<Tile> createState() => _TileState();
}

class _TileState extends State<Tile> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _widthAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _widthAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    Future.delayed(const Duration(milliseconds: 1500))
        .then((_) => _controller.forward());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        alignment: Alignment.bottomCenter,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(widget.imgassest), fit: BoxFit.cover),
        ),
        child: Align(
          alignment: Alignment.bottomLeft,
          child: AnimatedBuilder(
            animation: _widthAnimation,
            builder: (context, child) {
              return ClipRect(
                child: Align(
                  alignment: Alignment.bottomLeft,
                  widthFactor:
                      _widthAnimation.value, // Reveal width dynamically
                  child: child,
                ),
              );
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                //color: Colors.white.withOpacity(0.9), // Semi-transparent white
                borderRadius: BorderRadius.circular(16),
                gradient: const LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  stops: [0.0, 1.0],
                  colors: [gradientcolor1, gradientcolor2],
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox.shrink(),
                  appText(widget.text, 12, rightmargin: 15.0),
                  CircleAvatar(
                    radius: calculateSize(16),
                    backgroundColor: Colors.white,
                    child: const Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
