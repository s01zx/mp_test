import 'package:flutter/material.dart';
import 'package:mp_test/resources/colors.dart';
import 'package:mp_test/resources/helper_functions.dart';
import 'package:mp_test/resources/helper_widgets.dart';
import 'package:mp_test/screens/welcome/components/animated_text.dart';

class ScaleInBox extends StatefulWidget {
  const ScaleInBox({super.key});

  @override
  State<ScaleInBox> createState() => _ScaleInBoxState();
}

class _ScaleInBoxState extends State<ScaleInBox>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
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
    return Row(
      children: [
        Expanded(
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: Container(
              height: calculateSize(250),
              //padding: EdgeInsets.symmetric(horizontal: 60),
              decoration:
                  const BoxDecoration(shape: BoxShape.circle, color: orangelike
                      // borderRadius: BorderRadius.circular(200)
                      ),
              child: Column(
                children: [
                  appText(
                    "Buy",
                    22,
                    weight: FontWeight.w600,
                    color: const Color(0xfffbf5eb),
                    bottommargin: 60.0,
                    topmargin: 30.0,
                  ),
                  // appText(
                  //   "2 212",
                  //   30,
                  //   weight: FontWeight.w600,
                  //   color: const Color(0xfffbf5eb),
                  //   bottommargin: 10.0,
                  // ),
                  const AnimatedText(targetValue: 2212),
                  appText(
                    "offers",
                    22,
                    weight: FontWeight.w400,
                    color: const Color(0xfffbf5eb),
                  ),
                ],
              ),
            ),
          ),
        ),
        horizontalspace(25.0),
        Expanded(
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: Container(
              height: calculateSize(250),
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(30)),
              child: Column(
                children: [
                  appText(
                    "Rent",
                    22,
                    weight: FontWeight.w600,
                    color: locationiconcolor,
                    bottommargin: 60.0,
                    topmargin: 30.0,
                  ),
                  const AnimatedText(
                    targetValue: 2212,
                    isloactioncolor: true,
                  ),
                  appText(
                    "offers",
                    22,
                    weight: FontWeight.w400,
                    color: locationiconcolor,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
