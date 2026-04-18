import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
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
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeIn,
    );
    _fadeController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 768;

    return Container(
      width: double.infinity,
      height: isMobile ? MediaQuery.of(context).size.height * 0.85 : MediaQuery.of(context).size.height,
      padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 30 : 100,
          vertical: isMobile ? 40 : 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Hi text
          Text(
            AppStrings.heroHi,
            style: AppFonts.mono(
              color: Theme.of(context).primaryColor,
              fontSize: 14,
              fontWeight: FontWeight.bold,
              letterSpacing: 5,
            ),
          ).animate().fadeIn(duration: 800.ms, delay: 200.ms).slideX(begin: -0.2),
          
          const SizedBox(height: 20),
          
          // Name with Glitch
          Text(
            AppStrings.heroName,
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  fontSize: isMobile ? 60 : 100,
                  fontWeight: FontWeight.w900,
                  height: 1,
                ),
          )
          .animate()
          .fadeIn(duration: 600.ms, delay: 400.ms)
          .shimmer(duration: 2.seconds, color: Theme.of(context).primaryColor.withOpacity(0.3))
          .moveY(begin: 20, end: 0),
          
          const SizedBox(height: 10),
          
          // Title
          Text(
            AppStrings.heroSubtitle,
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  fontSize: isMobile ? 40 : 80,
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.w900,
                  height: 1,
                ),
          ).animate().fadeIn(duration: 600.ms, delay: 600.ms).moveY(begin: 20, end: 0),
          
          const SizedBox(height: 30),
          
          // Description
          SizedBox(
            width: 600,
            child: Text(
              AppStrings.heroDescription,
              style: AppFonts.mono(
                fontSize: isMobile ? 16 : 18,
                color: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.color
                    ?.withOpacity(0.7),
                height: 1.6,
              ),
            ),
          ).animate().fadeIn(duration: 800.ms, delay: 800.ms).moveY(begin: 10, end: 0),
          
          const SizedBox(height: 50),
          
          // Button
          HoverItem(
            child: OutlinedButton(
              onPressed: widget.onCheckOutPressed,
              style: OutlinedButton.styleFrom(
                foregroundColor: Theme.of(context).primaryColor,
                side: BorderSide(
                    color: Theme.of(context).primaryColor, width: 2),
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 25),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
              child: Text(
                AppStrings.heroCTA,
                style: AppFonts.mono(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
            ),
          ).animate().fadeIn(duration: 800.ms, delay: 1000.ms).scale(begin: const Offset(0.8, 0.8)),
        ],
      ),
    );
  }
}
