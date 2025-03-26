import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final currentPageProvider = StateProvider<int>((ref) => 0);
final chartDataProvider = Provider<List<List<PieChartSectionData>>>((ref) => [
  [
    PieChartSectionData(
      value: 70,
      color: const Color.fromRGBO(64, 120, 242, 1), // Blue
      title: '70%',
      radius: 30,
      titleStyle: const TextStyle(color: Colors.white, fontSize: 12),
    ),
    PieChartSectionData(
      value: 30,
      color: const Color.fromRGBO(166, 227, 184, 1), // Green
      title: '30%',
      radius: 30,
      titleStyle: const TextStyle(color: Colors.white, fontSize: 12),
    ),
  ],
  [
    PieChartSectionData(
      value: 60,
      color: const Color.fromRGBO(242, 153, 74, 1), // Orange
      title: '60%',
      radius: 30,
      titleStyle: const TextStyle(color: Colors.white, fontSize: 12),
    ),
    PieChartSectionData(
      value: 40,
      color: const Color.fromRGBO(122, 162, 247, 1), // Light blue
      title: '40%',
      radius: 30,
      titleStyle: const TextStyle(color: Colors.white, fontSize: 12),
    ),
  ],
  [
    PieChartSectionData(
      value: 80,
      color: const Color.fromRGBO(255, 99, 132, 1), // Red
      title: '80%',
      radius: 30,
      titleStyle: const TextStyle(color: Colors.white, fontSize: 12),
    ),
    PieChartSectionData(
      value: 20,
      color: const Color.fromRGBO(75, 192, 192, 1), // Cyan
      title: '20%',
      radius: 30,
      titleStyle: const TextStyle(color: Colors.white, fontSize: 12),
    ),
  ],
]);

class DbEarningChartWidget extends ConsumerWidget {
  const DbEarningChartWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentPage = ref.watch(currentPageProvider);
    final chartData = ref.watch(chartDataProvider);
    final pageController = PageController(initialPage: currentPage);

    return Container(
      height: 384,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(33, 32, 32, 1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color.fromRGBO(79, 79, 79, 1)),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Earnings',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              DropdownButton<String>(
                value: "This month",
                dropdownColor: const Color.fromRGBO(45, 45, 45, 1),
                underline: Container(),
                style: const TextStyle(color: Colors.white, fontSize: 14),
                icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white),
                items: ['This month', 'Last month', 'This year']
                    .map((String value) => DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                ))
                    .toList(),
                onChanged: (value) {},
              ),
            ],
          ),

          const SizedBox(height: 10),

          Expanded(
            child: Column(
              children: [
                Expanded(
                  flex: 2,
                  child: PageView.builder(
                    controller: pageController,
                    itemCount: chartData.length,
                    onPageChanged: (index) {
                      ref.read(currentPageProvider.notifier).state = index;
                    },
                    itemBuilder: (context, index) {
                      return PieChart(
                        PieChartData(
                          sectionsSpace: 2,
                          centerSpaceRadius: 50,
                          sections: chartData[index],
                          pieTouchData: PieTouchData(
                            touchCallback: (FlTouchEvent event, pieTouchResponse) {},
                          ),
                        ),
                      );
                    },
                  ),
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LegendItem(color: chartData[currentPage][0].color, text: "Revenue"),
                    const SizedBox(height: 6),
                    LegendItem(color: chartData[currentPage][1].color, text: "Campaign Name xx"),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              chartData.length,
                  (index) => GestureDetector(
                onTap: () {
                  pageController.animateToPage(
                    index,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
                child: PageIndicator(isActive: currentPage == index),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LegendItem extends StatelessWidget {
  final Color color;
  final String text;

  const LegendItem({super.key, required this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
            border: Border.all(color: const Color.fromRGBO(79, 79, 79, 1)),
          ),
        ),
        const SizedBox(width: 6),
        Text(
          text,
          style: const TextStyle(color: Colors.white, fontSize: 12),
        ),
      ],
    );
  }
}

/// **Page Indicator Widget**
class PageIndicator extends StatelessWidget {
  final bool isActive;

  const PageIndicator({super.key, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isActive ? 8 : 6,
      height: isActive ? 8 : 6,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Colors.grey,
        shape: BoxShape.circle,
      ),
    );
  }
}
