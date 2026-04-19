import 'package:flutter/material.dart';
import '../widgets/interactive_cursor.dart';
import '../widgets/floating_settings.dart';
import '../widgets/perspective_grid.dart';
import '../widgets/floating_navbar.dart';
import '../sections/hero_section.dart';
import '../sections/skills_section.dart';
import '../sections/experience_section.dart';
import '../sections/other_projects_section.dart';
import '../sections/contact_section.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  int _currentIndex = 0;

  final GlobalKey _heroKey = GlobalKey();
  final GlobalKey _skillsKey = GlobalKey();
  final GlobalKey _experienceKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    // Basic index tracking based on keys
    // In a real app, you'd check the positions of the keys
    // For now, let's use a simpler heuristic based on scroll offset for performance
    double offset = _scrollController.offset;
    int newIndex = 0;
    if (offset < 600) {
      newIndex = 0;
    } else if (offset < 1400) {
      newIndex = 1;
    } else if (offset < 2400) {
      newIndex = 2;
    } else if (offset < 4000) {
      newIndex = 3;
    } else {
      newIndex = 4;
    }

    if (newIndex != _currentIndex) {
      setState(() {
        _currentIndex = newIndex;
      });
    }
  }

  void _scrollToSection(GlobalKey key) {
    Scrollable.ensureVisible(
      key.currentContext!,
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    final keys = [_heroKey, _skillsKey, _experienceKey, _projectsKey, _contactKey];
    final bool isMobile = MediaQuery.of(context).size.width < 768;

    Widget content = Stack(
      children: [
        SingleChildScrollView(
          controller: _scrollController,
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1200),
              child: Column(
                children: [
                  HeroSection(
                    key: _heroKey,
                    onCheckOutPressed: () => _scrollToSection(_experienceKey),
                  ),
                  SkillsSection(key: _skillsKey),
                  Container(
                    key: _experienceKey,
                    child: const ExperienceSection(),
                  ),
                  OtherProjectsSection(key: _projectsKey),
                  ContactSection(key: _contactKey),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ),
        // Floating Settings (Top Right)
        Positioned(
          top: 20,
          right: 20,
          child: const SafeArea(child: FloatingSettings()),
        ),
        // Floating Navbar (Bottom Center)
        Align(
          alignment: Alignment.bottomCenter,
          child: FloatingNavbar(
            currentIndex: _currentIndex,
            onTap: (index) => _scrollToSection(keys[index]),
          ),
        ),
      ],
    );

    return Scaffold(
      backgroundColor: Colors.black,
      body: PerspectiveGrid(
        child: isMobile ? content : InteractiveCursor(child: content),
      ),
    );
  }
}
