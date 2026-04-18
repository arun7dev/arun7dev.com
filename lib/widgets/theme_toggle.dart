import 'package:flutter/material.dart';
import '../main.dart';

class ThemeToggle extends StatelessWidget {
  const ThemeToggle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (context, currentMode, _) {
            return Container(
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                    color: Theme.of(context).primaryColor.withOpacity(0.3)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildOption(
                      context, ThemeMode.light, Icons.light_mode, currentMode),
                  _buildOption(
                      context, ThemeMode.dark, Icons.dark_mode, currentMode),
                  _buildOption(context, ThemeMode.system,
                      Icons.settings_brightness, currentMode),
                ],
              ),
            );
          },
        );
  }

  Widget _buildOption(BuildContext context, ThemeMode mode, IconData icon,
      ThemeMode currentMode) {
    final isSelected = mode == currentMode;
    return GestureDetector(
      onTap: () => themeNotifier.value = mode,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color:
              isSelected ? Theme.of(context).primaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Icon(
          icon,
          size: 18,
          color: isSelected
              ? (Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Colors.white)
              : Theme.of(context).textTheme.bodyLarge?.color?.withOpacity(0.5),
        ),
      ),
    );
  }
}
