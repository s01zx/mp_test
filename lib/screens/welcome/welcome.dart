import 'package:flutter/material.dart';
import 'package:mp_test/resources/colors.dart';
import 'package:mp_test/resources/helper_functions.dart';
import 'package:mp_test/resources/helper_widgets.dart';
import 'package:mp_test/screens/welcome/components/bottom_menu.dart';
import 'package:mp_test/screens/welcome/components/grid_view_items.dart';
import 'package:mp_test/screens/welcome/components/scale_in_box.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _heightAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _heightAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _controller.forward();

    // WidgetsBinding.instance.addPostFrameCallback((_) {

    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.0, 1.0],
            colors: [gradientcolor1, gradientcolor2],
          ),
        ),
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  verticalspace(25.0),
                  AnimatedBuilder(
                    animation: _heightAnimation,
                    builder: (context, child) {
                      return ClipRect(
                        child: Align(
                          alignment: Alignment.topCenter,
                          heightFactor: _heightAnimation.value,
                          child: child,
                        ),
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: calculateSize(20, useWidth: true)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: calculateSize(15),
                                    horizontal:
                                        calculateSize(50, useWidth: true)),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.location_on,
                                      color: locationiconcolor,
                                    ),
                                    appText(
                                      "Saint Petersburg",
                                      13,
                                      color: locationiconcolor,
                                      leftmargin: 10.0,
                                    )
                                  ],
                                ),
                              ),
                              CircleAvatar(
                                child: Image.asset(
                                  "assets/images/avatar.png",
                                  width: calculateSize(100, useWidth: true),
                                  height: calculateSize(100),
                                ),
                              )
                            ],
                          ),
                          verticalspace(63.0),
                          appText(
                            "Hi, Marina",
                            25,
                            color: locationiconcolor,
                            weight: FontWeight.w600,
                          ),
                          appText("Let's, select your\nperfect place", 30,
                              color: locationiconcolor,
                              weight: FontWeight.w500,
                              align: TextAlign.start,
                              topmargin: 10.0),
                          const ScaleInBox(),
                          verticalspace(50.0),
                        ],
                      ),
                    ),
                  ),
                  const GridItems(),
                ],
              ),
            ),
            BottomMenu(),
          ],
        ),
      ),
    );
  }
}
