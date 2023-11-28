

import 'package:flutter/cupertino.dart';

import '../commons/consts.dart';

class ColorChangeNotifier extends ChangeNotifier {
  Color? _commonColor = Consts.commonColor;

  Color? get commonColor => _commonColor;

  set commonColor(Color? color) {
    _commonColor = color;
    notifyListeners();
  }
}
