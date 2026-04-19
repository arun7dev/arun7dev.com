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
          width: 250,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: symbols.map((s) {
              final bool isSelected = currentSymbol == s['value'];
              return HoverItem(
                child: InkWell(
                  onTap: () => gridSymbolNotifier.value = s['value']!,
                  borderRadius: BorderRadius.circular(8),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: isSelected 
                          ? Theme.of(context).primaryColor.withOpacity(0.15)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      s['icon']!,
                      style: TextStyle(
                        fontSize: 16,
                        color: isSelected ? Colors.white : Colors.white.withOpacity(0.4),
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
