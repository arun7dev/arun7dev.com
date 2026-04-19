import 'package:flutter/material.dart';
import 'dart:ui';
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
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        _buildToggleButton(),
        if (_isExpanded) ...[
          const SizedBox(height: 15),
          _buildExpandedPanel(),
        ],
      ],
    );
  }

  Widget _buildToggleButton() {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.8),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: Theme.of(context).primaryColor.withOpacity(0.3),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).primaryColor.withOpacity(0.1),
            blurRadius: 20,
            spreadRadius: 5,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: InkWell(
            onTap: () => setState(() => _isExpanded = !_isExpanded),
            borderRadius: BorderRadius.circular(28),
            child: Center(
              child: Icon(
                _isExpanded ? Icons.close : Icons.palette_outlined,
                color: Theme.of(context).primaryColor,
                size: 24,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildExpandedPanel() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOutQuart,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.8),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: Theme.of(context).primaryColor.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                GridSymbolSelector(),
                SizedBox(height: 15),
                ColorSlider(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
