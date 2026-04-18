import 'package:flutter/material.dart';
import '../main.dart';
import 'hover_item.dart';

class GridSymbolSelector extends StatelessWidget {
  const GridSymbolSelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> symbols = [
      {'icon': '⬜', 'value': 'rect'},
      {'icon': '❤️', 'value': 'heart'},
      {'icon': '⭕', 'value': 'circle'},
      {'icon': '💎', 'value': 'diamond'},
      {'icon': '✨', 'value': '✨'},
      {'icon': '⚡', 'value': '⚡'},
    ];

    return ValueListenableBuilder<String>(
      valueListenable: gridSymbolNotifier,
      builder: (context, currentSymbol, _) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.5),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Theme.of(context).primaryColor.withOpacity(0.3),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: symbols.map((s) {
              final bool isSelected = currentSymbol == s['value'];
              return HoverItem(
                child: GestureDetector(
                  onTap: () => gridSymbolNotifier.value = s['value']!,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: isSelected 
                          ? Theme.of(context).primaryColor.withOpacity(0.2)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      s['icon']!,
                      style: TextStyle(
                        fontSize: 18,
                        color: isSelected ? Colors.white : Colors.white.withOpacity(0.5),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
