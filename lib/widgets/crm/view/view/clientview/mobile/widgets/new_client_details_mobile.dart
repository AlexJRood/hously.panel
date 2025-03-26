import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:hously_flutter/theme/apptheme.dart';

class NewClientDetailsMobile extends StatelessWidget {
  const NewClientDetailsMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: CustomClientTile(
                  title: 'całkowity zysk'.tr, data: "\$50.000"),
            ),
            const SizedBox(width: 8), // Space between tiles
            Expanded(
              child: CustomClientTile(title: 'Aktywne Projekty'.tr, data: "1"),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: CustomClientTile(
                  title: 'Łączna liczba projektów'.tr, data: "4"),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: CustomClientTile(
                  title: 'Średnia wielkość transakcji'.tr, data: "\$500.000"),
            ),
          ],
        ),
      ],
    );
  }
}

class CustomClientTile extends ConsumerWidget {
  final String title;
  final String data;

  const CustomClientTile({super.key, required this.data, required this.title});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeColorsProvider);
    final clientTileColor = theme.clientTilecolor;

    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: clientTileColor,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(color: theme.whitewhiteblack, fontSize: 14),
          ),
          const SizedBox(height: 4),
          Text(
            data,
            style: TextStyle(
              color: theme.whitewhiteblack,
              fontWeight: FontWeight.bold,
              fontSize: 18, // Slightly increased for emphasis
            ),
          ),
        ],
      ),
    );
  }
}
