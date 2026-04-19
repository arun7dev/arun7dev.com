import 'package:flutter/material.dart';
import '../models/contribution_day.dart';
import '../main.dart';

class ContributionHeatmap extends StatelessWidget {
  final List<ContributionDay> contributions;

  const ContributionHeatmap({Key? key, required this.contributions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (contributions.isEmpty) {
      return const Center(
          child: Text('No contribution data available',
              style: TextStyle(color: Colors.white54)));
    }

    // Organize days into weeks (columns)
    // GitHub's grid is Week-based columns, each column has 7 days (Sun-Sat)
    final List<List<ContributionDay?>> columns = [];
    List<ContributionDay?> currentColumn = List.filled(7, null);

    // Find the first day to align with the correct weekday (0 = Monday, 7 = Sunday in Dart)
    // GitHub starts with Sunday (7 in Dart DateTime)
    for (var day in contributions) {
      int weekday = day.date.weekday; // 1 (Mon) - 7 (Sun)
      int gridRow = (weekday % 7); // 0 (Sun), 1 (Mon), ..., 6 (Sat)

      if (gridRow == 0 &&
          columns.isNotEmpty &&
          currentColumn.any((e) => e != null)) {
        columns.add(currentColumn);
        currentColumn = List.filled(7, null);
      }

      currentColumn[gridRow] = day;

      // If it's Saturday, finish the column
      if (gridRow == 6) {
        columns.add(currentColumn);
        currentColumn = List.filled(7, null);
      }
    }

    // Add the last column if not empty
    if (currentColumn.any((e) => e != null)) {
      columns.add(currentColumn);
    }

    return ValueListenableBuilder<Color>(
      valueListenable: primaryColorNotifier,
      builder: (context, primaryColor, _) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Weekday labels
                _buildWeekdayLabels(),
                const SizedBox(width: 8),
                // The Grid
                ...columns.map((column) => _buildColumn(column, primaryColor)),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildWeekdayLabels() {
    const labels = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
    return Column(
      children: labels.asMap().entries.map((entry) {
        // Show only Mon, Wed, Fri to match GitHub style
        bool show = entry.key % 2 != 0;
        return Container(
          height: 12,
          margin: const EdgeInsets.symmetric(vertical: 2),
          alignment: Alignment.centerLeft,
          child: Text(
            show ? entry.value : '',
            style: const TextStyle(color: Colors.white30, fontSize: 9),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildColumn(List<ContributionDay?> column, Color primaryColor) {
    return Column(
      children: column.map((day) => _buildDayCell(day, primaryColor)).toList(),
    );
  }

  Widget _buildDayCell(ContributionDay? day, Color primaryColor) {
    if (day == null) {
      return Container(
        width: 12,
        height: 12,
        margin: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(2),
        ),
      );
    }

    Color cellColor;
    if (day.level == 0) {
      cellColor = Colors.white.withOpacity(0.05);
    } else {
      // Scale opacity based on level (1-4)
      double opacity = 0.2 + (day.level * 0.2);
      cellColor = primaryColor.withOpacity(opacity.clamp(0.0, 1.0));
    }

    return Tooltip(
      message:
          '${day.count} contributions on ${day.date.day}/${day.date.month}/${day.date.year}',
      child: Container(
        width: 12,
        height: 12,
        margin: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: cellColor,
          borderRadius: BorderRadius.circular(2),
          border: day.level == 0
              ? Border.all(color: Colors.white.withOpacity(0.05), width: 0.5)
              : null,
        ),
      ),
    );
  }
}
