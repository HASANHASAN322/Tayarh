import 'package:flutter/material.dart';
import 'package:tayarh/theme/dark_mode.dart';

import '../../utils/constant/colors.dart';



class Back extends StatelessWidget {
  const Back({
    super.key, required this.icon, required this.onPressed,
  });

  final IconData icon ;
  final void Function() onPressed ;
  @override
  Widget build(BuildContext context) {
    final dark = DarkMode.isDarkMode(context) ;
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 40 ,
          height: 45,
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: dark? MyColors.darkColor.withOpacity(0.8) :MyColors.whiteColor.withOpacity(0.8),
            borderRadius: BorderRadius.circular(10) ,
          ),
          child: IconButton(
            onPressed: onPressed,
            icon: Icon(icon, color:MyColors.mainColor,),
          ),
        )

      ],
    );
  }
}
