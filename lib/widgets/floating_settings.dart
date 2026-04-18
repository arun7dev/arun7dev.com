import 'package:flutter/material.dart';
import 'theme_toggle.dart';
import 'color_slider.dart';
import 'grid_symbol_selector.dart';

class FloatingSettings extends StatefulWidget {
  const FloatingSettings({Key? key}) : super(key: key);

  @override
  State<FloatingSettings> createState() => _FloatingSettingsState();
}

class _FloatingSettingsState extends State<FloatingSettings> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < 768;

    if (!isMobile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const GridSymbolSelector(),
          const SizedBox(height: 15),
          const ColorSlider(),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (_isExpanded) ...[
          const GridSymbolSelector(),
          const SizedBox(height: 15),
          const ColorSlider(),
          const SizedBox(height: 15),
        ],
        FloatingActionButton(
          onPressed: () => setState(() => _isExpanded = !_isExpanded),
          backgroundColor: Theme.of(context).primaryColor,
          child: Icon(
            _isExpanded ? Icons.close : Icons.palette,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
