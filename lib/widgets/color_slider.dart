import 'package:flutter/material.dart';
import '../main.dart';

class ColorSlider extends StatelessWidget {
  const ColorSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Color>(
      valueListenable: primaryColorNotifier,
      builder: (context, currentColor, _) {
        final hsvColor = HSVColor.fromColor(currentColor);
        
        return Container(
          width: 250,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: [
              const Icon(Icons.palette_outlined, size: 18),
              const SizedBox(width: 10),
              Expanded(
                  child: Slider(
                    value: hsvColor.hue,
                    min: 0,
                    max: 360,
                    activeColor: Theme.of(context).primaryColor,
                    inactiveColor: Theme.of(context).primaryColor.withOpacity(0.2),
                    onChanged: (value) {
                      primaryColorNotifier.value = HSVColor.fromAHSV(1.0, value, 0.65, 1.0).toColor();
                    },
                  ),
              ),
            ],
          ),
        );
      },
    );
  }
}
