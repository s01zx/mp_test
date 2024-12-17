import 'package:flutter/material.dart';
import 'package:mp_test/resources/helper_functions.dart';
import 'package:mp_test/resources/helper_widgets.dart';

class SearchBarx extends StatefulWidget {
  const SearchBarx({super.key});

  @override
  State<SearchBarx> createState() => _SearchBarxState();
}

class _SearchBarxState extends State<SearchBarx>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutBack,
      ),
    );

    Future.delayed(Durations.medium3).then((e) => _controller.forward());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          alignment: Alignment.center,
          child: child,
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                decoration: InputDecoration(
                  isDense: true,
                  filled: true,
                  hintText: "Search",
                  prefixIcon: Icon(Icons.search),
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.transparent),
                      borderRadius: BorderRadius.circular(calculateSize(30))),
                ),
              ),
            ),
            horizontalspace(10.0),
            const CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(
                Icons.sort,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
