import 'package:flutter/material.dart';

import '../Utils/app_layout.dart';
import '../utils/app_styles.dart';

class MyButton extends StatelessWidget {
  final String lable;
  final Function() onTap;
  final double bWidth;
  final double bHight;

  const MyButton({super.key, required this.lable, required this.onTap, required this.bWidth, required this.bHight});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: onTap,
    child: Container(
      alignment: Alignment.center,
      width: Applayout.getWidth(bWidth),
      height: Applayout.getHeight(bHight),
decoration: BoxDecoration(
  color: Styles.kakiColor,
  borderRadius: BorderRadius.circular(10)),
  child: Text(lable,style: Styles.headLineStyle3.copyWith(color:Styles.textColor),textAlign: TextAlign.center,),
    ),
    
    );
  }
}