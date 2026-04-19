import 'dart:ui';
import 'package:flutter/material.dart';
import 'hover_item.dart';
import '../core/constants/fonts.dart';

class FloatingNavbar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const FloatingNavbar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 768;
    
    final List<String> items = isMobile 
        ? ['Home', 'Skills', 'Exp', 'Work', 'Actv', 'Mail'] 
        : ['Home', 'Skills', 'Experience', 'Projects', 'Activity', 'Contact'];

    
    return Container(
      margin: EdgeInsets.only(bottom: isMobile ? 15 : 30),
      height: isMobile ? 50 : 60,
      constraints: BoxConstraints(maxWidth: screenWidth * 0.95),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.6),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: Theme.of(context).primaryColor.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(items.length, (index) {
                final bool isActive = currentIndex == index;
                
                return HoverItem(
                  translate: const Offset(0, -4),
                  child: GestureDetector(
                    onTap: () => onTap(index),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      padding: EdgeInsets.symmetric(
                        horizontal: isMobile ? 12 : 20, 
                        vertical: isMobile ? 8 : 10
                      ),
                      margin: const EdgeInsets.symmetric(horizontal: 2),
                      decoration: BoxDecoration(
                        color: isActive 
                            ? Theme.of(context).primaryColor.withOpacity(0.15)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(20),
                      ),
                        child: Text(
                          items[index],
                          style: AppFonts.mono(
                            color: isActive 
                                ? Theme.of(context).primaryColor 
                                : Colors.white.withOpacity(0.6),
                            fontSize: isMobile ? 12 : 14,
                            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                            letterSpacing: 1,
                          ),
                        ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
