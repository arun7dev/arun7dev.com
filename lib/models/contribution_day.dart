class ContributionDay {
  final DateTime date;
  final int count;
  final int level;

  ContributionDay({
    required this.date,
    required this.count,
    required this.level,
  });

  @override
  String toString() => 'ContributionDay(date: $date, count: $count, level: $level)';
}
