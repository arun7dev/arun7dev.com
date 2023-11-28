import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/change_color_provider.dart';
import '../consts.dart';

class ChangeColor extends StatelessWidget {
  final double height;

  const ChangeColor({
    Key? key,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        ColorChangeNotifier colorChangeNotifier = Provider.of<ColorChangeNotifier>(context, listen: false);
        Random random = Random();
        Color randomColor = Consts.listColors[random.nextInt(Consts.listColors.length)];
        colorChangeNotifier.commonColor = randomColor;
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CircleAvatar(
          radius: height / 20,
          backgroundColor: Consts.OAC,
          child: CircleAvatar(
            radius: MediaQuery.of(context).size.width<610?(height / 22):(height / 50),
            backgroundColor: Provider.of<ColorChangeNotifier>(context).commonColor,
          ),
        ),
      ),
    );
  }
}