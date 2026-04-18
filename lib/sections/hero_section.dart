import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/hover_item.dart';
import '../core/constants/strings.dart';
import '../core/constants/fonts.dart';

class HeroSection extends StatefulWidget {
  final VoidCallback onCheckOutPressed;

  const HeroSection({Key? key, required this.onCheckOutPressed})
      : super(key: key);

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
          parent: _controller,
          curve: const Interval(0.0, 0.6, curve: Curves.easeOut)),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero).animate(
      CurvedAnimation(
          parent: _controller,
          curve: const Interval(0.2, 1.0, curve: Curves.easeOutCubic)),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 768;
    final horizontalPadding = isMobile ? 30.0 : 100.0;

    return Container(
      constraints:
          BoxConstraints(minHeight: MediaQuery.of(context).size.height * 0.9),
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FadeTransition(
            opacity: _fadeAnimation,
            child: Text(
              AppStrings.heroHi,
              style: AppFonts.mono(
                color: Theme.of(context).primaryColor,
                fontSize: 14,
                fontWeight: FontWeight.bold,
                letterSpacing: 5,
              ),
            ),
          ),
          const SizedBox(height: 20),
          SlideTransition(
            position: _slideAnimation,
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Text(
                AppStrings.heroName,
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      fontSize: isMobile ? 50 : 80,
                      fontWeight: FontWeight.w900,
                    ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          SlideTransition(
            position: _slideAnimation,
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Text(
                AppStrings.heroSubtitle,
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      fontSize: isMobile ? 32 : 70,
                      fontWeight: FontWeight.w800,
                      color: Theme.of(context)
                          .textTheme
                          .displayLarge
                          ?.color
                          ?.withOpacity(0.5),
                    ),
              ),
            ),
          ),
          const SizedBox(height: 30),
          SlideTransition(
            position: _slideAnimation,
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: SizedBox(
                width: 600,
                child: Text(
                  AppStrings.heroDescription,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        height: 1.6,
                        fontSize: isMobile ? 16 : 20,
                      ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 50),
          SlideTransition(
            position: _slideAnimation,
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: HoverItem(
                child: OutlinedButton(
                  onPressed: widget.onCheckOutPressed,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Theme.of(context).primaryColor,
                    side: BorderSide(
                        color: Theme.of(context).primaryColor, width: 2),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 20),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  child: Text(
                    AppStrings.heroCTA,
                    style: GoogleFonts.dotGothic16(
                      fontSize: 18,
                      letterSpacing: 2,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
