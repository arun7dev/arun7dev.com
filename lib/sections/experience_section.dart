import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../widgets/hover_item.dart';
import '../core/constants/strings.dart';
import '../core/constants/fonts.dart';

import '../widgets/reveal_on_scroll.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 768;
    final horizontalPadding = isMobile ? 30.0 : 100.0;

    return Container(
        padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding, 
            vertical: isMobile ? 60 : 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RevealOnScroll(
              id: 'exp-title',
              slideOffset: 20.0,
              child: Row(
                children: [
                  Text(
                    AppStrings.expNumber,
                    style: AppFonts.dots(
                      color: Theme.of(context).primaryColor,
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    AppStrings.expTitle,
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(
                          fontSize: isMobile ? 24 : 32,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  if (!isMobile) ...[
                    const SizedBox(width: 20),
                    Expanded(
                      child: Container(
                        height: 1,
                        color: Theme.of(context).dividerColor.withOpacity(0.2),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 80),
            // Samsung Entry
            _buildProjectCard(
              context: context,
              role: AppStrings.expSamsungRole,
              company: AppStrings.expSamsungCompany,
              duration: AppStrings.expSamsungDuration,
              description: AppStrings.expSamsungDesc,
              techStack: ['Flutter', 'BLoC', 'AutoRouter', 'Floor DB'],
              isImageLeft: false,
              imagePath: 'assets/images/shop_app.png',
              playStoreUrl: AppStrings.expSamsungPlayStore,
              appStoreUrl: AppStrings.expSamsungAppStore,
              index: 0,
            ),
            SizedBox(height: isMobile ? 80 : 120),
            // TNPHR Entry
            _buildProjectCard(
              context: context,
              role: AppStrings.expTnphrRole,
              company: AppStrings.expTnphrCompany,
              duration: AppStrings.expTnphrDuration,
              description: AppStrings.expTnphrDesc,
              techStack: [
                'Flutter',
                'BLoC',
                'Hive DB',
                'Offline-First Architecture'
              ],
              isImageLeft: true,
              imagePath: 'assets/images/tnphr_app.png',
              playStoreUrl: AppStrings.expTnphrPlayStore,
              index: 1,
            ),
            SizedBox(height: isMobile ? 80 : 120),
            // Howdy Chats Entry
            _buildProjectCard(
              context: context,
              role: AppStrings.expHowdyRole,
              company: AppStrings.expHowdyCompany,
              duration: AppStrings.expHowdyDuration,
              description: AppStrings.expHowdyDesc,
              techStack: [
                'Flutter',
                'Real-time Messaging',
                'Social UI',
                'Firebase'
              ],
              isImageLeft: false,
              imagePath: 'assets/images/howdy_chats_app.png',
              playStoreUrl: AppStrings.expHowdyPlayStore,
              appStoreUrl: AppStrings.expHowdyAppStore,
              index: 2,
            ),
          ],
        ),
      );
  }

  Widget _buildProjectCard({
    required BuildContext context,
    required String role,
    required String company,
    required String duration,
    required String description,
    required List<String> techStack,
    required bool isImageLeft,
    required String imagePath,
    String? playStoreUrl,
    String? appStoreUrl,
    required int index,
  }) {
    final bool isMobile = MediaQuery.of(context).size.width < 768;

    final textContent = Column(
      crossAxisAlignment: (isImageLeft && !isMobile)
          ? CrossAxisAlignment.start
          : CrossAxisAlignment.end,
      children: [
        Text(
          duration,
          style: AppFonts.mono(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
            letterSpacing: 2,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          company,
          style: TextStyle(
            fontSize: isMobile ? 26 : 32,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).textTheme.displayLarge?.color,
          ),
          textAlign: isMobile
              ? TextAlign.right
              : (isImageLeft ? TextAlign.left : TextAlign.right),
        ),
        const SizedBox(height: 5),
        Text(
          role,
          style: TextStyle(
            fontSize: 18,
            color:
                Theme.of(context).textTheme.bodyLarge?.color?.withOpacity(0.7),
            fontWeight: FontWeight.w500,
          ),
          textAlign: isMobile
              ? TextAlign.right
              : (isImageLeft ? TextAlign.left : TextAlign.right),
        ),
        const SizedBox(height: 25),
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white.withOpacity(0.05)
                    : Colors.black.withOpacity(0.05),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Theme.of(context).primaryColor.withOpacity(0.2),
                  width: 1,
                ),
              ),
              child: Text(
                description,
                style: AppFonts.mono(
                  fontSize: 16,
                  color: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.color
                      ?.withOpacity(0.9),
                  height: 1.6,
                ),
                textAlign: isMobile
                    ? TextAlign.left
                    : (isImageLeft ? TextAlign.left : TextAlign.right),
              ),
            ),
          ),
        ),
        const SizedBox(height: 25),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          alignment: isMobile
              ? WrapAlignment.end
              : (isImageLeft ? WrapAlignment.start : WrapAlignment.end),
          children:
              techStack.map((tech) => _buildTechChip(context, tech)).toList(),
        ),
        const SizedBox(height: 25),
        Row(
          mainAxisAlignment: isMobile
              ? MainAxisAlignment.end
              : (isImageLeft ? MainAxisAlignment.start : MainAxisAlignment.end),
          children: [
            if (playStoreUrl != null)
              _buildStoreButton(
                  context, Icons.shop_two, 'Play Store', playStoreUrl),
            if (appStoreUrl != null) ...[
              const SizedBox(width: 15),
              _buildStoreButton(
                  context, Icons.apple, 'App Store', appStoreUrl),
            ],
          ],
        ),
      ],
    );

    final imageContent = Container(
      height: isMobile ? 250 : 400,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.05),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
            color: Theme.of(context).primaryColor.withOpacity(0.2), width: 1),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            imagePath,
            fit: BoxFit.cover,
            alignment: Alignment.topCenter,
            errorBuilder: (context, error, stackTrace) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.phone_iphone,
                        size: 80,
                        color: Theme.of(context).primaryColor.withOpacity(0.4)),
                    const SizedBox(height: 20),
                    Text(
                      'Image not found\n$imagePath',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.dotGothic16(
                        color: Theme.of(context).primaryColor.withOpacity(0.5),
                        fontSize: 14,
                        letterSpacing: 1,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          Positioned.fill(
            child: Container(
              color: Theme.of(context).primaryColor.withOpacity(0.15),
            ),
          ),
        ],
      ),
    );

    return RevealOnScroll(
      id: 'exp-card-$index',
      slideOffset: 40.0,
      child: isMobile
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                imageContent,
                const SizedBox(height: 30),
                textContent,
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (isImageLeft) ...[
                  Expanded(flex: 5, child: imageContent),
                  const SizedBox(width: 50),
                  Expanded(flex: 6, child: textContent),
                ] else ...[
                  Expanded(flex: 6, child: textContent),
                  const SizedBox(width: 50),
                  Expanded(flex: 5, child: imageContent),
                ],
              ],
            ),
    );
  }

  Widget _buildTechChip(BuildContext context, String tech) {
    return HoverItem(
      scale: 1.1,
      translate: const Offset(0, -2),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withOpacity(0.15),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
              color: Theme.of(context).primaryColor.withOpacity(0.3)),
        ),
        child: Text(
          tech,
          style: TextStyle(
            color: Theme.of(context).primaryColor.withOpacity(0.9),
            fontSize: 12,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.8,
          ),
        ),
      ),
    );
  }

  Widget _buildStoreButton(
      BuildContext context, IconData icon, String tooltip, String url) {
    return HoverItem(
      translate: const Offset(0, -4),
      child: Tooltip(
        message: tooltip,
        child: IconButton(
          onPressed: () => _launchUrl(url),
          icon: Icon(icon),
          color: Theme.of(context).primaryColor,
          iconSize: 28,
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
        ),
      ),
    );
  }

  void _launchUrl(String urlString) async {
    final Uri url = Uri.parse(urlString);
    try {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } catch (e) {
      debugPrint('Could not launch $urlString: $e');
    }
  }
}
