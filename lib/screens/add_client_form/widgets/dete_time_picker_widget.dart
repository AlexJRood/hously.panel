import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

final selectedDateProvider = StateProvider<DateTime?>((ref) => null);
final startTimeProvider = StateProvider<TimeOfDay?>((ref) => null);
final endTimeProvider = StateProvider<TimeOfDay?>((ref) => null);

class DateTimePickerWidget extends ConsumerWidget {
  final bool isMobile;
  const DateTimePickerWidget({super.key, this.isMobile = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDate = ref.watch(selectedDateProvider);
    final startTime = ref.watch(startTimeProvider);
    final endTime = ref.watch(endTimeProvider);

    return isMobile
        ? Column(
            spacing: 10,
            children: [
              BuildPickBox(
                label: selectedDate != null
                    ? DateFormat('MMMM d').format(selectedDate)
                    : "Select Date",
                icon: Icons.calendar_today,
                onTap: () async {
                  final pickedDate = await _pickDate(context, selectedDate);
                  if (pickedDate != null) {
                    ref.read(selectedDateProvider.notifier).state = pickedDate;
                  }
                },
              ),
              BuildPickBox(
                label: startTime != null
                    ? startTime.format(context)
                    : "Start Time",
                icon: Icons.access_time,
                onTap: () async {
                  final pickedTime = await _pickTime(context, startTime);
                  if (pickedTime != null) {
                    ref.read(startTimeProvider.notifier).state = pickedTime;
                  }
                },
              ),
              BuildPickBox(
                label: endTime != null ? endTime.format(context) : "End Time",
                icon: Icons.access_time,
                onTap: () async {
                  final pickedTime = await _pickTime(context, endTime);
                  if (pickedTime != null) {
                    ref.read(endTimeProvider.notifier).state = pickedTime;
                  }
                },
              ),
            ],
          )
        : Row(
            children: [
              Expanded(
                child: BuildPickBox(
                  label: selectedDate != null
                      ? DateFormat('MMMM d').format(selectedDate)
                      : "Select Date",
                  icon: Icons.calendar_today,
                  onTap: () async {
                    final pickedDate = await _pickDate(context, selectedDate);
                    if (pickedDate != null) {
                      ref.read(selectedDateProvider.notifier).state =
                          pickedDate;
                    }
                  },
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                "from",
                style: TextStyle(color: Colors.white70, fontSize: 16),
              ),
              const SizedBox(width: 8),
              BuildPickBox(
                label: startTime != null
                    ? startTime.format(context)
                    : "Start Time",
                icon: Icons.access_time,
                onTap: () async {
                  final pickedTime = await _pickTime(context, startTime);
                  if (pickedTime != null) {
                    ref.read(startTimeProvider.notifier).state = pickedTime;
                  }
                },
              ),
              const SizedBox(width: 8),
              const Text(
                "to",
                style: TextStyle(color: Colors.white70, fontSize: 16),
              ),
              const SizedBox(width: 8),
              // ⏰ End Time Picker
              BuildPickBox(
                label: endTime != null ? endTime.format(context) : "End Time",
                icon: Icons.access_time,
                onTap: () async {
                  final pickedTime = await _pickTime(context, endTime);
                  if (pickedTime != null) {
                    ref.read(endTimeProvider.notifier).state = pickedTime;
                  }
                },
              ),
            ],
          );
  }
  Future<DateTime?> _pickDate(
      BuildContext context, DateTime? initialDate) async {
    return await showDatePicker(
      context: context,
      initialDate: initialDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark(),
          child: child!,
        );
      },
    );
  }

  Future<TimeOfDay?> _pickTime(
      BuildContext context, TimeOfDay? initialTime) async {
    return await showTimePicker(
      context: context,
      initialTime: initialTime ?? TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark(),
          child: child!,
        );
      },
    );
  }
}

class BuildPickBox extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;
  const BuildPickBox({
    super.key,
    required this.label,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(35, 35, 35, 1),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(
                  color: Color.fromRGBO(145, 145, 145, 1), fontSize: 13),
            ),
            const SizedBox(width: 8),
            Icon(icon, color: const Color.fromRGBO(200, 200, 200, 1), size: 18),
          ],
        ),
      ),
    );
  }
}
