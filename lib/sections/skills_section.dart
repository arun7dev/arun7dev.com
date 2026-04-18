import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/hover_item.dart';
import '../core/constants/strings.dart';
import '../core/constants/fonts.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 768;
    final horizontalPadding = isMobile ? 30.0 : 100.0;

    return Container(
      padding:
          EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 80),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                AppStrings.skillsNumber,
                style: AppFonts.dots(
                  color: Theme.of(context).primaryColor,
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                AppStrings.skillsTitle,
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Container(
                  height: 1,
                  color: Theme.of(context).dividerColor.withOpacity(0.2),
                ),
              ),
            ],
          ),
          const SizedBox(height: 60),
          Flex(
            direction: isMobile ? Axis.vertical : Axis.horizontal,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!isMobile)
                Expanded(
                  flex: 4,
                  child: _buildIntro(context),
                )
              else
                _buildIntro(context),
              if (!isMobile)
                const SizedBox(width: 80)
              else
                const SizedBox(height: 40),
              if (!isMobile)
                Expanded(
                  flex: 5,
                  child: _buildSkillsGrid(context),
                )
              else
                _buildSkillsGrid(context),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildIntro(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          AppStrings.skillsIntro,
          style: TextStyle(fontSize: 18, height: 1.6),
        ),
        const SizedBox(height: 30),
        _buildSkillCategory(
          context,
          AppStrings.skillsFrameworks,
          ['Flutter', 'React', 'NodeJS', 'ExpressJS'],
        ),
      ],
    );
  }

  Widget _buildSkillsGrid(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSkillCategory(
          context,
          AppStrings.skillsLanguages,
          ['Dart', 'Python', 'Java', 'C++', 'JavaScript', 'Perl', 'C'],
        ),
        const SizedBox(height: 40),
        _buildSkillCategory(
          context,
          AppStrings.skillsDatabases,
          ['Firebase', 'SQL', 'MongoDB'],
        ),
      ],
    );
  }

  Widget _buildSkillCategory(
      BuildContext context, String title, List<String> skills) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title.toUpperCase(),
          style: GoogleFonts.dotGothic16(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
        const SizedBox(height: 20),
        Wrap(
          spacing: 15,
          runSpacing: 15,
          children:
              skills.map((skill) => _buildGlassChip(context, skill)).toList(),
        ),
      ],
    );
  }

  Widget _buildGlassChip(BuildContext context, String text) {
    return HoverItem(
      scale: 1.1,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withOpacity(0.08),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
              color: Theme.of(context).primaryColor.withOpacity(0.2)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.play_arrow,
                color: Theme.of(context).primaryColor, size: 14),
            const SizedBox(width: 8),
            Text(
              text,
              style: TextStyle(
                color: Theme.of(context).primaryColor.withOpacity(0.9),
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
