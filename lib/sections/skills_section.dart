import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../widgets/hover_item.dart';
import '../core/constants/strings.dart';
import '../core/constants/fonts.dart';

class SkillsSection extends StatefulWidget {
  const SkillsSection({Key? key}) : super(key: key);

  @override
  State<SkillsSection> createState() => _SkillsSectionState();
}

class _SkillsSectionState extends State<SkillsSection> {
  bool _isVisible = false;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 768;
    final horizontalPadding = isMobile ? 30.0 : 100.0;

    return VisibilityDetector(
      key: const Key('skills-section'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.1 && !_isVisible) {
          setState(() => _isVisible = true);
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(
            vertical: isMobile ? 60 : 100, 
            horizontal: isMobile ? 30 : 100),
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
                ).animate(target: _isVisible ? 1 : 0).fadeIn().slideX(begin: -0.2),
                const SizedBox(width: 10),
                Text(
                  AppStrings.skillsTitle,
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        fontSize: isMobile ? 24 : 32,
                        fontWeight: FontWeight.bold,
                      ),
                ).animate(target: _isVisible ? 1 : 0).fadeIn(delay: 200.ms).slideY(begin: 0.2),
                if (!isMobile) ...[
                  const SizedBox(width: 20),
                  Expanded(
                    child: Container(
                      height: 1,
                      color: Theme.of(context).dividerColor.withOpacity(0.2),
                    ).animate(target: _isVisible ? 1 : 0).fadeIn(delay: 400.ms).scaleX(begin: 0),
                  ),
                ],
              ],
            ),
            const SizedBox(height: 50),
            if (isMobile)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildIntro(context),
                  const SizedBox(height: 40),
                  _buildSkillsGrid(context),
                ],
              )
            else
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 4,
                    child: _buildIntro(context),
                  ),
                  const SizedBox(width: 80),
                  Expanded(
                    flex: 5,
                    child: _buildSkillsGrid(context),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildIntro(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.skillsIntro,
          style: const TextStyle(fontSize: 18, height: 1.6),
        ).animate(target: _isVisible ? 1 : 0).fadeIn(delay: 500.ms),
      ],
    );
  }

  Widget _buildSkillsGrid(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SkillCategory(
          title: AppStrings.skillsFrameworks,
          skills: ['Flutter', 'React', 'NodeJS', 'ExpressJS'],
          categoryIndex: 0,
        ),
        const SizedBox(height: 40),
        const _SkillCategory(
          title: AppStrings.skillsLanguages,
          skills: ['Dart', 'Python', 'Java', 'C++', 'JavaScript', 'Perl', 'C'],
          categoryIndex: 1,
        ),
        const SizedBox(height: 40),
        const _SkillCategory(
          title: AppStrings.skillsDatabases,
          skills: ['Firebase', 'SQL', 'MongoDB'],
          categoryIndex: 2,
        ),
      ],
    );
  }
} // Close _SkillsSectionState

class _SkillCategory extends StatefulWidget {
  final String title;
  final List<String> skills;
  final int categoryIndex;

  const _SkillCategory({
    Key? key,
    required this.title,
    required this.skills,
    required this.categoryIndex,
  }) : super(key: key);

  @override
  State<_SkillCategory> createState() => _SkillCategoryState();
}

class _SkillCategoryState extends State<_SkillCategory> {
  bool _isVisible = false;

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key('skill-category-${widget.categoryIndex}'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.1 && !_isVisible) {
          if (mounted) {
            setState(() => _isVisible = true);
          }
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title.toUpperCase(),
            style: AppFonts.mono(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
              color: Theme.of(context).primaryColor.withOpacity(0.8),
            ),
          ).animate(target: _isVisible ? 1 : 0).fadeIn(delay: 200.ms),
          const SizedBox(height: 20),
          Wrap(
            spacing: 15,
            runSpacing: 15,
            children: widget.skills.asMap().entries.map((entry) {
              return _buildGlassChip(context, entry.value)
                  .animate(target: _isVisible ? 1 : 0)
                  .fadeIn(delay: (300 + (entry.key * 50)).ms)
                  .scale(begin: const Offset(0.8, 0.8), curve: Curves.easeOutBack);
            }).toList(),
          ),
        ],
      ),
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
                    color: Theme.of(context).primaryColor, size: 14)
                .animate(onPlay: (c) => c.repeat(reverse: true))
                .scale(begin: const Offset(0.8, 0.8), end: const Offset(1.2, 1.2)),
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
