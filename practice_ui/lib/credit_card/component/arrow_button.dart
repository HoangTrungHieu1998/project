import 'package:flutter/material.dart';

import '../config/colors.dart';
import '../config/size.dart';

class ArrowButton extends StatelessWidget {
  final EdgeInsets? margin;
  final Widget? icon;
  const ArrowButton({Key? key, this.margin, this.icon}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var height = SizeConfig.getHeight(context);
    var width = SizeConfig.getWidth(context);
    return Expanded(
      child: Container(
        margin: margin,
        decoration: BoxDecoration(
            color: AppColors.primaryWhite,
            borderRadius: BorderRadius.circular(15),
            boxShadow: AppColors.neumorpShadow),
        alignment: Alignment.center,
        child: icon,
      ),
    );
  }
}