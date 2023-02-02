import 'package:flutter/material.dart';

import '../../constants.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      height: 80,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          BottomNavItem(
            title: "Today",
            svgScr: "assets/icons/calendar.png",
          ),
          BottomNavItem(
            title: "All Exercises",
            svgScr: "assets/icons/gym.png",
            isActive: true,
          ),
          BottomNavItem(
            title: "Settings",
            svgScr: "assets/icons/Settings.png",
          ),
        ],
      ),
    );
  }
}

class BottomNavItem extends StatelessWidget {
  final String? svgScr;
  final String? title;
  final GestureTapCallback? press;
  final bool? isActive;
  const BottomNavItem({
    Key? key,
    this.svgScr,
    this.title,
    this.press,
    this.isActive = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Image.asset(
            svgScr!,
            color: isActive! ? kActiveIconColor : kTextColor,
            width: 25,
          ),
          Text(
            title!,
            style: TextStyle(color: isActive! ? kActiveIconColor : kTextColor),
          ),
        ],
      ),
    );
  }
}