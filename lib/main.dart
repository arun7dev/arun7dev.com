import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'pages/home_page.dart';

// Global notifiers for theme state
final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.system);
final ValueNotifier<Color> primaryColorNotifier =
    ValueNotifier(const Color(0xFFCCFF00));
final ValueNotifier<String> gridSymbolNotifier = ValueNotifier('rect');

void main() {
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (_, ThemeMode currentMode, __) {
        return ValueListenableBuilder<Color>(
          valueListenable: primaryColorNotifier,
          builder: (_, Color currentPrimary, __) {
            return MaterialApp(
              title: 'Arun',
              debugShowCheckedModeBanner: false,
              theme: AppTheme.getLightTheme(currentPrimary),
              darkTheme: AppTheme.getDarkTheme(currentPrimary),
              themeMode: currentMode,
              home: const HomePage(),
            );
          },
        );
      },
    );
  }
}
