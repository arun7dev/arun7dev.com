import 'package:flutter/services.dart';
import 'package:html/parser.dart' as hp;
import 'package:html/dom.dart';
import '../models/contribution_day.dart';

class ContributionService {
  static Future<List<ContributionDay>> loadContributionsForYear(int year) async {
    try {
      final String htmlContent = await rootBundle.loadString('assets/html/contribution-$year.html');
      return parseContributions(htmlContent);
    } catch (e) {
      print('Error loading contributions for $year: $e');
      return [];
    }
  }

  static Future<List<ContributionDay>> loadAllContributions(List<int> years) async {
    List<ContributionDay> allDays = [];
    for (int year in years) {
      final days = await loadContributionsForYear(year);
      allDays.addAll(days);
    }
    return allDays;
  }

  static List<ContributionDay> parseContributions(String htmlContent) {
    final List<ContributionDay> days = [];
    final document = hp.parse(htmlContent);
    
    // Find all day elements
    final dayElements = document.querySelectorAll('.ContributionCalendar-day');
    
    for (var element in dayElements) {
      final dateStr = element.attributes['data-date'];
      final levelStr = element.attributes['data-level'];
      final id = element.attributes['id'];
      
      if (dateStr != null && levelStr != null && id != null) {
        final date = DateTime.parse(dateStr);
        final level = int.tryParse(levelStr) ?? 0;
        
        // Find associated tooltip to get the count
        // Tooltips are often siblings or linked by 'for' attribute
        final tooltip = document.querySelector('tool-tip[for="$id"]');
        int count = 0;
        
        if (tooltip != null) {
          final text = tooltip.text.trim();
          // Extract number from "X contributions..." or "No contributions..."
          if (text.toLowerCase().contains('no contributions')) {
            count = 0;
          } else {
            final match = RegExp(r'^(\d+)').firstMatch(text);
            if (match != null) {
              count = int.tryParse(match.group(1)!) ?? 0;
            }
          }
        }
        
        days.add(ContributionDay(
          date: date,
          count: count,
          level: level,
        ));
      }
    }
    
    // Sort by date just in case
    days.sort((a, b) => a.date.compareTo(b.date));
    
    return days;
  }
}
