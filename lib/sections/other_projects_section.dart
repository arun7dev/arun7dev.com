import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/constants/strings.dart';
import '../core/constants/fonts.dart';

// ─────────────────────────────────────────────
// Data model
// ─────────────────────────────────────────────
class ProjectData {
  final String num;
  final String title;
  final String desc;
  final List<String> tags;
  final String link;
  final String imagePath;
  final Color accentColor;
  final Color splashColor;

  const ProjectData({
    required this.num,
    required this.title,
    required this.desc,
    required this.tags,
    required this.link,
    required this.imagePath,
    required this.accentColor,
    required this.splashColor,
  });
}

// ─────────────────────────────────────────────
// Section widget
// ─────────────────────────────────────────────
class OtherProjectsSection extends StatefulWidget {
  const OtherProjectsSection({Key? key}) : super(key: key);

  @override
  State<OtherProjectsSection> createState() => _OtherProjectsSectionState();
}

class _OtherProjectsSectionState extends State<OtherProjectsSection> {
  int? _expandedIndex;

  static const _projects = [
    ProjectData(
      num: '01',
      title: 'TimesMed',
      desc:
          'Contributed to an in-house project for online doctor video consultations. Managed both UI design and API integration for the Flutter mobile app, ensuring a smooth experience for patients and doctors.',
      tags: ['Flutter', 'Healthcare', 'API'],
      link:
          'https://play.google.com/store/apps/details?id=com.timesmed&hl=en_US',
      imagePath: 'assets/images/timesmed_app.png',
      accentColor: Color(0xFF00B894),
      splashColor: Color(0xFF55EFC4),
    ),
    ProjectData(
      num: '02',
      title: 'Kauvery Hospital',
      desc:
          'A token generation system for Kauvery Hospital in Chennai, exclusively for patients visiting daily. Plays a crucial role in facilitating seamless token generation during hospital visits.',
      tags: ['Mobile', 'Healthcare', 'System'],
      link: '',
      imagePath: 'assets/images/kavery_app.png',
      accentColor: Color(0xFFE17055),
      splashColor: Color(0xFFFAB1A0),
    ),
    ProjectData(
      num: '03',
      title: 'VFXfood',
      desc:
          'Internship project with Mist VFX company. An online VFX & Animation reporter providing industry-latest news, updates, articles, interviews, and job listings worldwide.',
      tags: ['Flutter', 'News', 'Internship'],
      link: 'https://bit.ly/3sniezC',
      imagePath: 'assets/images/vfx_food_app.png',
      accentColor: Color(0xFFFDCB6E),
      splashColor: Color(0xFFFFEAA7),
    ),
    ProjectData(
      num: '04',
      title: 'Ballot',
      desc:
          'An election application for conducting student council elections. Built as a final year college project with secure voting mechanics and result tallying.',
      tags: ['Flutter', 'Election', 'Student'],
      link: 'https://github.com/arun7dev/final_year_project.git',
      imagePath: 'assets/images/ballot_app.png',
      accentColor: Color(0xFFFD79A8),
      splashColor: Color(0xFFFF7675),
    ),
  ];

  void _toggleCard(int index) {
    setState(() {
      _expandedIndex = _expandedIndex == index ? null : index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 700;
    final padding = isMobile ? 20.0 : 80.0;

    return Container(
      //color: const Color(0xFF0A0A0F),
      padding: EdgeInsets.symmetric(horizontal: padding, vertical: 80),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Section header ──
          Text(
            AppStrings.notableNumber,
            style: AppFonts.dots(
              fontSize: 20,
              fontWeight: FontWeight.w900,
              letterSpacing: 2,
              color: Theme.of(context).primaryColor,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            AppStrings.notableTitle,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w800,
              color: Theme.of(context).textTheme.displayLarge?.color,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 32),

          // ── Bento grid ──
          isMobile ? _buildMobileList() : _buildDesktopGrid(),
        ],
      ),
    );
  }

  // ─── Mobile: vertical list ───────────────────
  Widget _buildMobileList() {
    return Column(
      children: List.generate(_projects.length, (i) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: _BentoCard(
            project: _projects[i],
            isExpanded: _expandedIndex == i,
            onTap: () => _toggleCard(i),
            isMobile: true,
          ),
        );
      }),
    );
  }

  // ─── Desktop: custom bento grid ──────────────
  Widget _buildDesktopGrid() {
    // We lay out cards manually in rows of 3.
    // When a card is expanded it takes up 2/3 width, the rest fill 1/3.
    const cols = 3;
    const normalHeight = 220.0;
    const expandedHeight = 460.0; // 2 rows

    return LayoutBuilder(builder: (context, constraints) {
      final totalWidth = constraints.maxWidth;
      final gap = 16.0;
      final unitWidth = (totalWidth - gap * (cols - 1)) / cols;

      // Build rows of [cols] cards
      final rows = <Widget>[];
      int i = 0;
      while (i < _projects.length) {
        final rowEnd = (i + cols).clamp(0, _projects.length);
        final rowProjects = _projects.sublist(i, rowEnd);
        final rowIndices = List.generate(rowProjects.length, (j) => i + j);

        // Check if any card in this row is expanded
        final expandedInRow =
            rowIndices.indexWhere((idx) => idx == _expandedIndex);

        final rowHeight = expandedInRow != -1 ? expandedHeight : normalHeight;

        rows.add(
          AnimatedContainer(
            duration: const Duration(milliseconds: 450),
            curve: Curves.easeOutCubic,
            height: rowHeight,
            margin: const EdgeInsets.only(bottom: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: List.generate(rowProjects.length, (j) {
                final idx = rowIndices[j];
                final isExpanded = _expandedIndex == idx;
                // Correct math to prevent horizontal overflow
                final availableWidthForCards =
                    totalWidth - gap * (rowProjects.length - 1);
                double cardWidth;

                if (expandedInRow != -1) {
                  // Expanded card gets weight of 2, others get weight of 1
                  final totalWeight = 2 + (rowProjects.length - 1);
                  if (j == expandedInRow) {
                    cardWidth = availableWidthForCards * (2 / totalWeight);
                  } else {
                    cardWidth = availableWidthForCards * (1 / totalWeight);
                  }
                } else {
                  cardWidth = availableWidthForCards / rowProjects.length;
                }

                return AnimatedContainer(
                  duration: const Duration(milliseconds: 450),
                  curve: Curves.easeOutCubic,
                  width: cardWidth,
                  margin: EdgeInsets.only(
                      right: j < rowProjects.length - 1 ? gap : 0),
                  child: _BentoCard(
                    project: rowProjects[j],
                    isExpanded: isExpanded,
                    onTap: () => _toggleCard(idx),
                    isMobile: false,
                  ),
                );
              }),
            ),
          ),
        );
        i += cols;
      }

      return Column(children: rows);
    });
  }
}

// ─────────────────────────────────────────────
// Individual bento card
// ─────────────────────────────────────────────
class _BentoCard extends StatefulWidget {
  final ProjectData project;
  final bool isExpanded;
  final VoidCallback onTap;
  final bool isMobile;

  const _BentoCard({
    required this.project,
    required this.isExpanded,
    required this.onTap,
    required this.isMobile,
  });

  @override
  State<_BentoCard> createState() => _BentoCardState();
}

class _BentoCardState extends State<_BentoCard>
    with SingleTickerProviderStateMixin {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final p = widget.project;
    final exp = widget.isExpanded;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeOutCubic,
          height: widget.isMobile ? (exp ? 380.0 : 180.0) : double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).brightness == Brightness.dark 
                ? const Color(0xFF13131A) 
                : Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: exp
                  ? p.accentColor.withOpacity(0.5)
                  : _hovered
                      ? p.accentColor.withOpacity(0.3)
                      : Theme.of(context).dividerColor.withOpacity(0.1),
              width: exp ? 1.5 : 1,
            ),
            boxShadow: exp || _hovered
                ? [
                    BoxShadow(
                      color: p.accentColor.withOpacity(0.15),
                      blurRadius: 32,
                      spreadRadius: 2,
                    ),
                  ]
                : [],
          ),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            fit: StackFit.expand,
            children: [
              // ── Color splashes ──
              Positioned(
                top: -40,
                left: -40,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 400),
                  width: 180,
                  height: 180,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: p.accentColor.withOpacity(exp
                        ? 0.3
                        : _hovered
                            ? 0.22
                            : 0.14),
                  ),
                ),
              ),
              Positioned(
                bottom: -20,
                right: -20,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 400),
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: p.splashColor.withOpacity(exp
                        ? 0.25
                        : _hovered
                            ? 0.18
                            : 0.1),
                  ),
                ),
              ),

              // ── Grid pattern overlay ──
              Opacity(
                opacity: exp
                    ? 0.02
                    : _hovered
                        ? 0.07
                        : 0.04,
                child: CustomPaint(
                  painter: _GridPatternPainter(isDark: Theme.of(context).brightness == Brightness.dark),
                  size: Size.infinite,
                ),
              ),

              // ── Project image (faded background) ──
              AnimatedOpacity(
                duration: const Duration(milliseconds: 400),
                opacity: exp ? 0.8 : 0.4,
                child: Image.asset(
                  p.imagePath,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => const SizedBox.shrink(),
                ),
              ),

              // ── Gradient overlay ──
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Theme.of(context).scaffoldBackgroundColor.withOpacity(0.1),
                      Theme.of(context).scaffoldBackgroundColor.withOpacity(0.6),
                      Theme.of(context).scaffoldBackgroundColor.withOpacity(0.95),
                    ],
                    stops: const [0.0, 0.5, 1.0],
                  ),
                ),
              ),

              // ── Card content ──
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // Number
                    Text(
                      p.num,
                      style: AppFonts.mono(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                        color: Theme.of(context).brightness == Brightness.dark 
                            ? p.accentColor.withOpacity(0.8)
                            : p.accentColor,
                      ),
                    ),
                    const SizedBox(height: 6),

                    // Title
                    AnimatedDefaultTextStyle(
                      duration: const Duration(milliseconds: 350),
                      style: TextStyle(
                        fontSize: exp ? 24 : 18,
                        fontWeight: FontWeight.w800,
                        color: Theme.of(context).textTheme.displayLarge?.color,
                        height: 1.1,
                      ),
                      child: Text(p.title),
                    ),
                    const SizedBox(height: 8),

                    // Tags
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: p.tags
                          .map((t) => _TagChip(label: t, color: p.accentColor))
                          .toList(),
                    ),

                    // Description (animated reveal)
                    AnimatedCrossFade(
                      duration: const Duration(milliseconds: 400),
                      firstCurve: Curves.easeOut,
                      secondCurve: Curves.easeIn,
                      crossFadeState: exp
                          ? CrossFadeState.showSecond
                          : CrossFadeState.showFirst,
                      firstChild: const SizedBox(height: 0),
                      secondChild: Padding(
                        padding: const EdgeInsets.only(top: 14, bottom: 6),
                        child: Text(
                          p.desc,
                          style: TextStyle(
                            fontSize: 13,
                            color: Theme.of(context).textTheme.bodyLarge?.color?.withOpacity(0.8),
                            height: 1.65,
                          ),
                        ),
                      ),
                    ),

                    // View button (animated reveal)
                    AnimatedCrossFade(
                      duration: const Duration(milliseconds: 350),
                      firstCurve: Curves.easeOut,
                      secondCurve: Curves.easeIn,
                      crossFadeState: exp
                          ? CrossFadeState.showSecond
                          : CrossFadeState.showFirst,
                      firstChild: const SizedBox(height: 0),
                      secondChild: Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: p.link.isNotEmpty
                            ? _ViewProjectButton(
                                url: p.link,
                                color: p.accentColor,
                              )
                            : _DisabledButton(color: p.accentColor),
                      ),
                    ),
                  ],
                ),
              ),

              // ── Expand/collapse indicator ──
              Positioned(
                top: 14,
                right: 14,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 350),
                  width: 26,
                  height: 26,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: exp
                        ? p.accentColor.withOpacity(0.2)
                        : Theme.of(context).brightness == Brightness.dark
                            ? Colors.white.withOpacity(0.07)
                            : Colors.black.withOpacity(0.05),
                    border: Border.all(
                      color: exp
                          ? p.accentColor.withOpacity(0.5)
                          : Theme.of(context).brightness == Brightness.dark
                              ? Colors.white.withOpacity(0.12)
                              : Colors.black.withOpacity(0.1),
                    ),
                  ),
                  child: Center(
                    child: AnimatedRotation(
                      turns: exp ? 0.125 : 0, // 45deg
                      duration: const Duration(milliseconds: 350),
                      child: Icon(
                        Icons.add,
                        size: 14,
                        color: exp 
                            ? p.accentColor 
                            : Theme.of(context).textTheme.bodySmall?.color?.withOpacity(0.5),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Tag chip
// ─────────────────────────────────────────────
class _TagChip extends StatelessWidget {
  final String label;
  final Color color;

  const _TagChip({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.8,
          color: color.withOpacity(0.9),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// View Project button
// ─────────────────────────────────────────────
class _ViewProjectButton extends StatefulWidget {
  final String url;
  final Color color;

  const _ViewProjectButton({required this.url, required this.color});

  @override
  State<_ViewProjectButton> createState() => _ViewProjectButtonState();
}

class _ViewProjectButtonState extends State<_ViewProjectButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: () => _launchUrl(widget.url),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
          decoration: BoxDecoration(
            color: _hovered
                ? widget.color.withOpacity(0.2)
                : Colors.white.withOpacity(0.05),
            border: Border.all(
              color: _hovered
                  ? widget.color.withOpacity(0.5)
                  : Colors.white.withOpacity(0.2),
            ),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            '↗  VIEW PROJECT',
            style: GoogleFonts.dotGothic16(
              color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
              fontWeight: FontWeight.w700,
              letterSpacing: 2,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _launchUrl(String urlString) async {
    final uri = Uri.parse(urlString);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}

// ─────────────────────────────────────────────
// Disabled (not public) button
// ─────────────────────────────────────────────
class _DisabledButton extends StatelessWidget {
  final Color color;

  const _DisabledButton({required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark 
            ? Colors.white.withOpacity(0.03)
            : Colors.black.withOpacity(0.03),
        border: Border.all(
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.white.withOpacity(0.08)
              : Colors.black.withOpacity(0.08),
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        'NOT PUBLIC',
        style: GoogleFonts.dotGothic16(
          color: Theme.of(context).textTheme.bodySmall?.color?.withOpacity(0.3),
          fontWeight: FontWeight.w700,
          letterSpacing: 2,
          fontSize: 14,
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Grid pattern painter
// ─────────────────────────────────────────────
class _GridPatternPainter extends CustomPainter {
  final bool isDark;
  _GridPatternPainter({required this.isDark});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = isDark ? Colors.white : Colors.black
      ..strokeWidth = 0.5;

    const step = 30.0;
    for (double x = 0; x <= size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y <= size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(_GridPatternPainter oldDelegate) => oldDelegate.isDark != isDark;
}
