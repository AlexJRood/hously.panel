import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:hously_flutter/theme/apptheme.dart';

class NewClientDetails extends StatelessWidget {
  const NewClientDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 348,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Customclienttile(title: 'całkowity zysk'.tr, data: "\$50.000"),
          Customclienttile(title: 'Aktywne Projekty'.tr, data: "1"),
          Customclienttile(title: 'Łączna liczba projektów'.tr, data: "4"),
          Customclienttile(
              title: 'Średnia wielkość transakcji'.tr, data: "\$500.00")
        ],
      ),
    );
  }
}

class Customclienttile extends ConsumerWidget {
  final String title;
  final String data;
  const Customclienttile({super.key, required this.data, required this.title});

  @override
  Widget build(BuildContext context, ref) {
    final theme = ref.watch(themeColorsProvider);
    final clientTilecolor = theme.clientTilecolor;
    return  Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          height: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: clientTilecolor,
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Spacer(),
                    Text(
                      title,
                      style:
                          TextStyle(color: theme.mobileTextcolor, fontSize: 14),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      data,
                      style: TextStyle(
                          color: theme.mobileTextcolor,
                          fontWeight: FontWeight.bold,
                          fontSize: 14),
                    ),
                    Spacer(),
                  ],
                ),
              )
            ],
          ),
    );
  }
}
