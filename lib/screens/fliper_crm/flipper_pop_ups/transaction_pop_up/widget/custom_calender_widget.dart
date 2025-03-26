import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hously_flutter/const/icons.dart';
import 'package:intl/intl.dart';

final selectedDateProvider = StateProvider<DateTime>((ref) => DateTime.now());
final currentMonthProvider = StateProvider<DateTime>((ref) => DateTime.now());

class CustomCalendarWidget extends ConsumerWidget {
  final Function(DateTime) onDateSelected;

  const CustomCalendarWidget({super.key, required this.onDateSelected});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDate = ref.watch(selectedDateProvider);
    final currentMonth = ref.watch(currentMonthProvider);

    return SingleChildScrollView(
      child: Column(
        children: [
          BuildHeader(ref: ref, currentMonth: currentMonth),
          const BuildDaysOfWeek(),
          BuildDaysGrid(
            ref: ref,
            currentMonth: currentMonth,
            selectedDate: selectedDate,
            onDateSelected: onDateSelected,
          ),
        ],
      ),
    );
  }
}

class BuildHeader extends StatelessWidget {
  final WidgetRef ref;
  final DateTime currentMonth;
  const BuildHeader({super.key, required this.ref, required this.currentMonth});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            DateFormat.yMMMM().format(currentMonth),
            style: const TextStyle(
                color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
          ),
          Row(
            children: [
              IconButton(
                icon: SvgPicture.asset(AppIcons.iosArrowLeft, color: Colors.white),
                onPressed: () => ref.read(currentMonthProvider.notifier).state =
                    DateTime(currentMonth.year, currentMonth.month - 1, 1),
              ),
              IconButton(
                icon: SvgPicture.asset(AppIcons.iosArrowRight, color: Colors.white),
                onPressed: () => ref.read(currentMonthProvider.notifier).state =
                    DateTime(currentMonth.year, currentMonth.month + 1, 1),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class BuildDaysOfWeek extends StatelessWidget {
  const BuildDaysOfWeek({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: ['S', 'M', 'T', 'W', 'T', 'F', 'S']
          .map(
              (day) => Text(day, style: const TextStyle(color: Colors.white70)))
          .toList(),
    );
  }
}

class BuildDaysGrid extends StatelessWidget {
  final WidgetRef ref;
  final DateTime currentMonth;
  final DateTime selectedDate;
  final Function(DateTime) onDateSelected;
  const BuildDaysGrid(
      {super.key,
      required this.currentMonth,
      required this.ref,
      required this.selectedDate,
      required this.onDateSelected});

  @override
  Widget build(BuildContext context) {
    final firstDayOfMonth = DateTime(currentMonth.year, currentMonth.month, 1);
    final lastDayOfMonth =
        DateTime(currentMonth.year, currentMonth.month + 1, 0);
    final firstWeekday = firstDayOfMonth.weekday % 7;
    final daysInMonth = lastDayOfMonth.day;

    List<Widget> dayWidgets = List.generate(
        firstWeekday, (index) => const SizedBox(width: 40, height: 40));

    for (int day = 1; day <= daysInMonth; day++) {
      final date = DateTime(currentMonth.year, currentMonth.month, day);
      dayWidgets.add(BuildDayItem(
        ref: ref,
        date: date,
        selectedDate: selectedDate,
        onDateSelected: onDateSelected,
      ));
    }

    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: dayWidgets.length,
      itemBuilder: (context, index) {
        return dayWidgets[index];
      },
    );
  }
}

class BuildDayItem extends StatelessWidget {
  final WidgetRef ref;
  final DateTime date;
  final DateTime selectedDate;
  final Function(DateTime) onDateSelected;
  const BuildDayItem(
      {super.key,
      required this.selectedDate,
      required this.ref,
      required this.onDateSelected,
      required this.date});

  @override
  Widget build(BuildContext context) {
    bool isSelected =
        selectedDate.day == date.day && selectedDate.month == date.month;
    return GestureDetector(
      onTap: () {
        ref.read(selectedDateProvider.notifier).state = date;
        onDateSelected(date);
      },
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: isSelected ? Colors.greenAccent : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        alignment: Alignment.center,
        child: Text(
          '${date.day}',
          style: TextStyle(
            color: isSelected ? Colors.black : Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
