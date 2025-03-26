import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/const/backgroundgradient.dart';
import 'package:hously_flutter/data/design/design.dart';
import 'package:hously_flutter/models/crm/crm_expenses_download_model.dart';
import 'package:hously_flutter/models/crm/agent_transaction_model.dart';
import 'package:hously_flutter/state_managers/data/crm/components/finance_chart/provider.dart';
import 'package:hously_flutter/widgets/loading/loading_widgets.dart';

class RevenueExpensesChart extends ConsumerWidget {
  const RevenueExpensesChart({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(revenueAndExpensesProvider);

    return data.when(
      data: (data) {
        final revenues = List<AgentTransactionModel>.from(
            data['revenues'] ?? []);
        final expenses = List<CrmExpensesDownloadModel>.from(
            data['expenses'] ?? []);

        if (revenues.isEmpty && expenses.isEmpty) {
          return Center(
            child: Text(
              "No Data Found",
              style: AppTextStyles.interMedium14
                  .copyWith(color: Theme.of(context).iconTheme.color),
            ),
          );
        }

        final Map<DateTime, double> revenueMap = {};
        final Map<DateTime, double> expenseMap = {};

        for (var revenue in revenues) {
          final dateRevenue = DateTime(revenue.dateCreate.year,
              revenue.dateCreate.month, revenue.dateCreate.day);
          revenueMap[dateRevenue] =
              (revenueMap[dateRevenue] ?? 0) + double.parse(revenue.amount);
        }

        for (var expense in expenses) {
          final dateExpenses = DateTime(expense.dateCreate.year,
              expense.dateCreate.month, expense.dateCreate.day);
          expenseMap[dateExpenses] =
              (expenseMap[dateExpenses] ?? 0) + double.parse(expense.amount);
        }

        final revenueSpots = revenueMap.entries.map((entry) {
          return FlSpot(
              entry.key.millisecondsSinceEpoch.toDouble(), entry.value);
        }).toList()
          ..sort((a, b) => a.x.compareTo(b.x));

        final expenseSpots = expenseMap.entries.map((entry) {
          return FlSpot(
              entry.key.millisecondsSinceEpoch.toDouble(), entry.value);
        }).toList()
          ..sort((a, b) => a.x.compareTo(b.x));

        final uniqueDates =
            revenueMap.keys.toSet().union(expenseMap.keys.toSet()).toList();
        uniqueDates.sort();

        final dateLabels = uniqueDates
            .map((date) => date.millisecondsSinceEpoch.toDouble())
            .toSet();

        return Padding(
          padding: const EdgeInsets.only(
              top: 30, right: 50, left: 50, bottom: 30),
          child: LineChart(
            LineChartData(
              lineBarsData: [
                LineChartBarData(
                  spots: revenueSpots,
                  isCurved: false,
                  color: Colors.green,
                  barWidth: 3,
                  isStrokeCapRound: true,
                  dotData: const FlDotData(show: true),
                  belowBarData: BarAreaData(
                    show: true,
                    color: Colors.green.withOpacity(0.1),
                  ),
                ),
                LineChartBarData(
                  spots: expenseSpots,
                  isCurved: false,
                  color: Colors.red,
                  barWidth: 3,
                  isStrokeCapRound: true,
                  dotData: const FlDotData(show: true),
                  belowBarData: BarAreaData(
                    show: true,
                    color: Colors.red.withOpacity(0.1),
                  ),
                ),
              ],
              titlesData: FlTitlesData(
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    reservedSize: 60,
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      return Text(
                        '${value.toStringAsFixed(0)}',
                        style: const TextStyle(color: Colors.white),
                      );
                    },
                  ),
                ),
                topTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                rightTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                bottomTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
              ),
              extraLinesData: ExtraLinesData(
                verticalLines: uniqueDates.map((date) {
                  return VerticalLine(
                    x: date.millisecondsSinceEpoch.toDouble(),
                    color: Colors.blueGrey.withOpacity(0.5),
                    strokeWidth: 1,
                    dashArray: [5, 5],
                    label: VerticalLineLabel(
                      show: true,
                      labelResolver: (line) {
                        final date = DateTime.fromMillisecondsSinceEpoch(
                            line.x.toInt());
                        return '${date.day}/${date.month}';
                      },
                      style: const TextStyle(
                          color: Colors.white, fontSize: 12),
                    ),
                  );
                }).toList(),
              ),
              gridData: FlGridData(
                show: true,
                drawVerticalLine: true,
                getDrawingVerticalLine: (value) {
                  if (dateLabels.contains(value)) {
                    return const FlLine(
                      color: Color(0xff37434d),
                      strokeWidth: 1,
                      dashArray: [5, 5],
                    );
                  }
                  return const FlLine(
                    color: Colors.transparent,
                  );
                },
                drawHorizontalLine: true,
                getDrawingHorizontalLine: (value) {
                  return const FlLine(
                    color: Color(0xff37434d),
                    strokeWidth: 1,
                  );
                },
              ),
              borderData: FlBorderData(
                show: false,
              ),
              minX: uniqueDates.isNotEmpty
                  ? uniqueDates.first.millisecondsSinceEpoch.toDouble()
                  : 0,
              maxX: uniqueDates.isNotEmpty
                  ? uniqueDates.last.millisecondsSinceEpoch.toDouble()
                  : 0,
              minY: 0,
              maxY: ([...revenueMap.values, ...expenseMap.values]
                      .reduce((a, b) => a > b ? a : b))
                  .ceilToDouble() *
                  1.1,
            ),
          ),
        );
      },
      loading: () => const Center(
          child: CircularProgressIndicator(),
      ),
      error: (error, stackTrace) => Center(
        child: Text('Error: $error',
            style: TextStyle(color: Theme.of(context).iconTheme.color)),
      ),
    );
  }
}
