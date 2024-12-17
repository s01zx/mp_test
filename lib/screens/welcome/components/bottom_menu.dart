import 'package:flutter/material.dart';
import 'package:mp_test/models/generic_models.dart';
import 'package:mp_test/resources/colors.dart';
import 'package:mp_test/resources/helper_functions.dart';
import 'package:mp_test/screens/map/map_screen.dart';

class BottomMenu extends StatefulWidget {
  BottomMenu({super.key, this.initialindex = 2, this.ishomepage = true});
  int initialindex;
  bool ishomepage;

  @override
  State<BottomMenu> createState() => _BottomMenuState();
}

class _BottomMenuState extends State<BottomMenu>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;

  List<GenericModels> items = [
    GenericModels(icon: Icons.search, title: "Search"),
    GenericModels(icon: Icons.chat_bubble_outline, title: "Chat"),
    GenericModels(icon: Icons.home, title: "Home"),
    GenericModels(icon: Icons.favorite_border, title: "Fav"),
    GenericModels(icon: Icons.person_outlined, title: "Profile"),
  ];

  //int activeindex = 2;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: const Offset(0, 0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 2000))
          .then((_) => _controller.forward());
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SlideTransition(
        position: _slideAnimation,
        child: Container(
            margin: EdgeInsets.only(bottom: calculateSize(20)),
            padding: EdgeInsets.symmetric(
                horizontal: calculateSize(20, useWidth: true),
                vertical: calculateSize(10)),
            decoration: BoxDecoration(
              color: const Color(0xff2b2b2b),
              borderRadius: BorderRadius.circular(50),
            ),
            child: SizedBox(
              height: calculateSize(50),
              child: ListView.builder(
                itemCount: items.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemBuilder: (ctx, i) => GestureDetector(
                  onTap: () {
                    //make shift function since not all the icons are responsive
                    // and take you to designated views
                    widget.initialindex = i;
                    setState(() {});
                    if ((widget.ishomepage && i == 2) ||
                        (!widget.ishomepage && i == 0)) {
                      return; //do nothing...already on desired page.
                    }
                    if (widget.initialindex == 0 && widget.ishomepage) {
                      Future.delayed(Durations.short4).then(
                          (_) => //delay to see the active color shown on the selected icon before navigating
                              Navigator.of(context)
                                  .pushNamed(MapScreen.routeName));
                    }
                    if (widget.initialindex == 2 && !widget.ishomepage) {
                      Future.delayed(Durations.short4)
                          .then((_) => Navigator.of(context).pop());
                    }
                  },
                  child: _menuItem(items[i].icon!,
                      isActive: widget.initialindex == i),
                ),
              ),
            )

            // Row(
            //   mainAxisSize: MainAxisSize.min,
            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //   children: items.map((e) => GestureDetector(child: _menuItem(e.icon!))).toList(),
            //   // [
            //   //   _menuItem(Icons.search),
            //   //   _menuItem(Icons.chat_bubble_outline),
            //   //   _menuItem(Icons.home, isActive: true),
            //   //   _menuItem(Icons.favorite_border),
            //   //   _menuItem(Icons.person_outline),
            //   // ],
            // ),
            ),
      ),
    );
  }

  Widget _menuItem(IconData icon, {bool isActive = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: calculateSize(15, useWidth: true),
      ),
      child: CircleAvatar(
        radius: isActive ? 25 : 20,
        backgroundColor: isActive ? orangelike : Colors.black,
        child: Icon(
          icon,
          color: isActive ? Colors.white : Colors.white70,
          size: calculateSize(23),
        ),
      ),
    );
  }
}
