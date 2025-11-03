import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../models/expense.dart';

class ExpenseChart extends StatelessWidget {
  final List<Expense> expenses;

  const ExpenseChart({super.key, required this.expenses});

  @override
  Widget build(BuildContext context) {
    final dailyTotals = <String, double>{};
    for (var e in expenses) {
      final day = '${e.date.day}/${e.date.month}';
      dailyTotals[day] = (dailyTotals[day] ?? 0) + e.amount;
    }

    final data = dailyTotals.entries.toList();

    if (data.isEmpty) {
      return const Center(child: Text('No data to display.'));
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: BarChart(
        BarChartData(
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  final i = value.toInt();
                  if (i >= data.length) return const SizedBox();
                  return Text(data[i].key, style: const TextStyle(fontSize: 10));
                },
              ),
            ),
          ),
          borderData: FlBorderData(show: false),
          barGroups: List.generate(data.length, (i) {
            return BarChartGroupData(x: i, barRods: [
              BarChartRodData(
                toY: data[i].value,
                color: Colors.indigo,
                width: 18,
              )
            ]);
          }),
        ),
      ),
    );
  }
}
