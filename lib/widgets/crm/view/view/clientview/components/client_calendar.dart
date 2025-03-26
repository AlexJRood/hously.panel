import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hously_flutter/const/colors.dart';
import 'package:hously_flutter/const/icons.dart';
import 'package:hously_flutter/theme/apptheme.dart';
import 'package:table_calendar/table_calendar.dart';

class CustomTableCalendarPc extends ConsumerWidget {
  final Color primaryColor;
  final Color fillColor;

  final DateTime firstDay;
  final DateTime lastDay;
  final DateTime focusedDay;
  final List<Map<String, dynamic>> events;

  const CustomTableCalendarPc({
    super.key,
    required this.primaryColor,
    required this.fillColor,
    required this.firstDay,
    required this.lastDay,
    required this.focusedDay,
    required this.events,
  });

  @override
  Widget build(BuildContext context, ref) {
    final theme = ref.watch(themeColorsProvider);
    final isDark = ref.watch(isDefaultDarkSystemProvider);
    final clientTilecolor = theme.clientTilecolor;
    return TableCalendar(
      daysOfWeekStyle: DaysOfWeekStyle(
        weekdayStyle: TextStyle(
          fontSize: MediaQuery.of(context).size.width *
              0.007, // Change font size for Mon-Fri
          color: theme.mobileTextcolor,
        ),
        weekendStyle: TextStyle(
          fontSize: MediaQuery.of(context).size.width *
              0.007, // Change font size for Sat-Sun
          color: theme.mobileTextcolor,
        ),
      ),
      calendarStyle: CalendarStyle(
        todayDecoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            width: 3,
            color: isDark ? clienttileTextcolor : primaryColor,
          ),
        ),
        todayTextStyle: TextStyle(
          fontSize: MediaQuery.of(context).size.width * 0.007,
          color: isDark ? clienttileTextcolor : primaryColor,
        ),
        weekendTextStyle: TextStyle(
          color: theme.mobileTextcolor,
          fontSize: MediaQuery.of(context).size.width * 0.007,
        ),
        outsideTextStyle: TextStyle(
          color: theme.mobileTextcolor,
          fontSize: MediaQuery.of(context).size.width * 0.007,
        ),
        defaultTextStyle: TextStyle(
          color: theme.mobileTextcolor,
          fontSize: MediaQuery.of(context).size.width * 0.007,
        ),
      ),
      headerStyle: HeaderStyle(
        leftChevronIcon: Icon(
          Icons.arrow_back_ios_new_rounded,
          color: theme.mobileTextcolor,
        ),
        rightChevronIcon: Icon(
          Icons.arrow_forward_ios_rounded,
          color: theme.mobileTextcolor,
        ),
        titleCentered: true,
        formatButtonVisible: false,
        titleTextStyle: TextStyle(
          color: theme.mobileTextcolor,
          fontSize: MediaQuery.of(context).size.width * 0.008,
        ),
      ),
      shouldFillViewport: true,
      //need to be checked
      rowHeight: MediaQuery.of(context).size.height * 0.02,
      firstDay: firstDay,
      lastDay: lastDay,
      focusedDay: focusedDay,
      availableGestures: AvailableGestures.none,
      daysOfWeekHeight: 20,
      calendarBuilders: CalendarBuilders(
        defaultBuilder: (context, day, focusedDay) {
          final eventDay = events.any((event) =>
              event['date'].day == day.day &&
              event['date'].month == day.month &&
              event['date'].year == day.year);

          if (eventDay) {
            return Center(
              child: Container(
                width: 25,
                height: 25,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isDark
                      ? clienttileTextcolor
                      : Theme.of(context).primaryColor,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  day.day.toString(),
                  style: TextStyle(
                    color: isDark ? Colors.black : fillColor,
                    fontSize: MediaQuery.of(context).size.width * 0.008,
                  ),
                ),
              ),
            );
          }
          return null;
        },
      ),
    );
  }
}

class CustomTableCalendarMobile extends ConsumerWidget {
  final Color primaryColor;
  final Color fillColor;
  final DateTime firstDay;
  final DateTime lastDay;
  final DateTime focusedDay;
  final List<Map<String, dynamic>> events;

  const CustomTableCalendarMobile({
    super.key,
    required this.primaryColor,
    required this.fillColor,
    required this.firstDay,
    required this.lastDay,
    required this.focusedDay,
    required this.events,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeColorsProvider);
    final isDark = ref.watch(isDefaultDarkSystemProvider);
    final screenWidth = MediaQuery.of(context).size.width;
    final fontsizemobile = screenWidth * 0.035;
    final fontsizetab = screenWidth * 0.02;

    print(MediaQuery.of(context).size.width);
    return TableCalendar(
      daysOfWeekStyle: DaysOfWeekStyle(
        weekdayStyle: TextStyle(
          fontSize: screenWidth > 600 ? fontsizetab : fontsizemobile,
          color: theme.mobileTextcolor,
        ),
        weekendStyle: TextStyle(
          fontSize: screenWidth > 600 ? fontsizetab : fontsizemobile,
          color: theme.mobileTextcolor,
        ),
      ),
      calendarStyle: CalendarStyle(
        todayDecoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
              width: 3, color: isDark ? clienttileTextcolor : primaryColor),
        ),
        todayTextStyle: TextStyle(
            fontSize: screenWidth > 600 ? fontsizetab : fontsizemobile,
            color: isDark ? clienttileTextcolor : primaryColor),
        weekendTextStyle: TextStyle(
          color: theme.mobileTextcolor,
          fontSize: screenWidth > 600 ? fontsizetab : fontsizemobile,
        ),
        outsideTextStyle: TextStyle(
          color: theme.mobileTextcolor,
          fontSize: screenWidth > 600 ? fontsizetab : fontsizemobile,
        ),
        defaultTextStyle: TextStyle(
          color: theme.mobileTextcolor,
          fontSize: screenWidth > 600 ? fontsizetab : fontsizemobile,
        ),
      ),
      headerStyle: HeaderStyle(
        leftChevronIcon: SvgPicture.asset(AppIcons.iosArrowLeft,
            color: theme.mobileTextcolor),
        rightChevronIcon:
            SvgPicture.asset(AppIcons.iosArrowRight, color: theme.mobileTextcolor),
        titleCentered: true,
        formatButtonVisible: false,
        titleTextStyle: TextStyle(
          color: theme.mobileTextcolor,
          fontSize: screenWidth > 600 ? fontsizetab : fontsizemobile,
        ),
      ),
      shouldFillViewport: true,
      rowHeight: MediaQuery.of(context).size.height * 0.02,
      firstDay: firstDay,
      lastDay: lastDay,
      focusedDay: focusedDay,
      availableGestures: AvailableGestures.none,
      daysOfWeekHeight: 35,
      calendarBuilders: CalendarBuilders(
        defaultBuilder: (context, day, focusedDay) {
          final eventDay = events.any((event) =>
              event['date'].day == day.day &&
              event['date'].month == day.month &&
              event['date'].year == day.year);

          if (eventDay) {
            return Center(
              child: Container(
                width: 40,
                height: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isDark ? clienttileTextcolor : primaryColor,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  day.day.toString(),
                  style: TextStyle(
                      color: isDark ? Colors.black : fillColor, fontSize: 18),
                ),
              ),
            );
          }
          return null;
        },
      ),
    );
  }
}
