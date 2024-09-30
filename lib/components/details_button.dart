import 'package:flutter/material.dart';

import '../helper/colors_helper.dart';
import '../helper/dimensn_helper.dart';
import '../helper/font_helper.dart';
import '../helper/string_helper.dart';

class DetailsButton extends StatelessWidget {
  final VoidCallback onPress;
  final Widget child;
  const DetailsButton({super.key, required this.onPress, required this.child});

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      height: DimensnHelper.dimensn_25,
      width: DimensnHelper.dimensn_80,
      child: ElevatedButton(
        onPressed: onPress,
        style: ElevatedButton.styleFrom(
            backgroundColor: ColorsHelper.greenColor),
        child: const Text(
          StringHelper.details,
          style: TextStyle(
              color: ColorsHelper.whiteColor,
              fontSize: FontHelper.dimensn_10),
        ),
      ),
    );
  }
}
