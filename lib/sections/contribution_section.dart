import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../widgets/contribution_heatmap.dart';
import '../services/contribution_service.dart';
import '../models/contribution_day.dart';
import '../core/constants/strings.dart';
import '../core/constants/fonts.dart';

class ContributionSection extends StatefulWidget {
  const ContributionSection({Key? key}) : super(key: key);

  @override
  State<ContributionSection> createState() => _ContributionSectionState();
}

class _ContributionSectionState extends State<ContributionSection> {
  bool _isVisible = false;
  List<ContributionDay> _allContributions = [];
  List<ContributionDay> _filteredContributions = [];
  bool _isLoading = true;
  int _selectedYear = 2026;
  final List<int> _availableYears = [2026, 2025, 2024];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final data = await ContributionService.loadAllContributions(_availableYears);
    if (mounted) {
      setState(() {
        _allContributions = data;
        _filterByYear(_selectedYear);
        _isLoading = false;
      });
    }
  }

  void _filterByYear(int year) {
    setState(() {
      _selectedYear = year;
      _filteredContributions = _allContributions.where((d) => d.date.year == year).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 768;

    return VisibilityDetector(
      key: const Key('contribution-section'),
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
                  AppStrings.contributionNumber,
                  style: AppFonts.dots(
                    color: Theme.of(context).primaryColor,
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 2,
                  ),
                ).animate(target: _isVisible ? 1 : 0).fadeIn().slideX(begin: -0.2),
                const SizedBox(width: 10),
                Text(
                  AppStrings.contributionTitle,
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
            const SizedBox(height: 30),
            Text(
              AppStrings.contributionIntro,
              style: const TextStyle(fontSize: 18, height: 1.6, color: Colors.white70),
            ).animate(target: _isVisible ? 1 : 0).fadeIn(delay: 500.ms),
            const SizedBox(height: 40),
            _buildYearSelector(context),
            const SizedBox(height: 30),
            _buildHeatmapContainer(context, isMobile),
          ],
        ),
      ),
    );
  }

  Widget _buildYearSelector(BuildContext context) {
    return Row(
      children: _availableYears.map((year) {
        final isSelected = _selectedYear == year;
        return Padding(
          padding: const EdgeInsets.only(right: 15),

          child: GestureDetector(
            onTap: () => _filterByYear(year),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? Theme.of(context).primaryColor.withOpacity(0.15) : Colors.transparent,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: isSelected ? Theme.of(context).primaryColor : Colors.white24,
                  width: 1,
                ),
              ),
              child: Text(
                year.toString(),
                style: TextStyle(
                  color: isSelected ? Theme.of(context).primaryColor : Colors.white60,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    ).animate(target: _isVisible ? 1 : 0).fadeIn(delay: 600.ms).slideX(begin: 0.1);
  }

  Widget _buildHeatmapContainer(BuildContext context, bool isMobile) {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (_filteredContributions.isEmpty) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(40),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.03),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withOpacity(0.05)),
        ),
        child: Center(
          child: Column(
            children: [
              const Icon(Icons.info_outline, color: Colors.white30, size: 40),
              const SizedBox(height: 15),
              Text(
                'No activity data available for $_selectedYear.',
                style: const TextStyle(color: Colors.white54, fontSize: 16),
              ),
            ],
          ),
        ),
      ).animate(target: _isVisible ? 1 : 0).fadeIn(delay: 700.ms);
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.03),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${_filteredContributions.where((d) => d.count > 0).length} days of activity in $_selectedYear',
                style: const TextStyle(color: Colors.white60, fontSize: 14),
              ),
              _buildLegend(context),
            ],
          ),
          const SizedBox(height: 10),
          ContributionHeatmap(contributions: _filteredContributions),
        ],
      ),
    ).animate(target: _isVisible ? 1 : 0).fadeIn(delay: 700.ms).slideY(begin: 0.1);
  }


  Widget _buildLegend(BuildContext context) {
    return Row(
      children: [
        const Text('Less ', style: TextStyle(color: Colors.white30, fontSize: 10)),
        ...List.generate(5, (index) {
          Color color;
          if (index == 0) {
            color = Colors.white.withOpacity(0.05);
          } else {
            double opacity = 0.2 + (index * 0.2);
            color = Theme.of(context).primaryColor.withOpacity(opacity);
          }
          return Container(
            width: 10,
            height: 10,
            margin: const EdgeInsets.symmetric(horizontal: 2),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(2),
            ),
          );
        }),
        const Text(' More', style: TextStyle(color: Colors.white30, fontSize: 10)),
      ],
    );
  }
}
