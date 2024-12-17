import 'package:flutter/material.dart';
import 'package:mp_test/models/generic_models.dart';
import 'package:mp_test/resources/helper_functions.dart';
import 'package:mp_test/resources/helper_widgets.dart';

class Mapmenu extends StatefulWidget {
  const Mapmenu({super.key});

  @override
  State<Mapmenu> createState() => _MapmenuState();
}

class _MapmenuState extends State<Mapmenu> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late List<GenericModels> items;

  @override
  void initState() {
    super.initState();

    items = [
      GenericModels(
        title: "Cosy areas",
        icon: Icons.check_circle_outline,
      ),
      GenericModels(
          title: "Price", icon: Icons.account_balance_wallet_outlined),
      GenericModels(
        title: "Infrastructure",
        icon: Icons.delete_outlined,
      ),
      GenericModels(title: "Without any", icon: Icons.layers_outlined),
    ];

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
    return SizedBox(
      height: calculateSize(250),
      width: calculateSize(250),
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            alignment: Alignment.bottomLeft,
            child: child,
          );
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
          decoration: BoxDecoration(
            color: const Color(0xfffdf6ed),
            borderRadius: BorderRadius.circular(16),
          ),
          child: ListView.builder(
            itemCount: items.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, i) => _menuItem(items[i]),
          ),
        ),
      ),
    );
  }

  Widget _menuItem(GenericModels m) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
      child: Row(
        children: [
          Icon(
            m.icon,
            color: Colors.grey,
          ),
          const SizedBox(width: 15),
          appText(m.title!, 16, color: Colors.grey),
        ],
      ),
    );
  }
}
