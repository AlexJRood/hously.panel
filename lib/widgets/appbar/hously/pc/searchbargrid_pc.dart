import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:hously_flutter/theme/apptheme.dart';
import 'package:hously_flutter/data/design/button_style.dart';
import 'package:hously_flutter/data/design/design.dart';

class SearchBarGridpc extends ConsumerStatefulWidget {
  const SearchBarGridpc({super.key});

  @override
  SearchBarGridpcState createState() => SearchBarGridpcState();
}

class SearchBarGridpcState extends ConsumerState<SearchBarGridpc> {
  @override
  Widget build(BuildContext context) {
    final themecolors = ref.watch(themeColorsProvider);

    final iconColor = Theme.of(context).iconTheme.color;
    final textColor = themecolors.themeTextColor;

    return ElevatedButton(
      style: elevatedButtonStyleRounded,
      onPressed: () {},
      child: Hero(
        tag: 'searchBarGridpc',
        child: Container(
          height: 40,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xff22393E), Color(0xff161920)],
              // Customize your gradient colors
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Row(
            children: [
              const SizedBox(width: 10),
              Icon(Icons.search, color: iconColor),
              const SizedBox(width: 10),
              Expanded(
                child: Container(
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width - 50),
                  child: Material(
                    color: Colors.transparent,
                    child: Text(
                      'Wyszukaj region'.tr,
                      overflow: TextOverflow.ellipsis,
                      style:
                          AppTextStyles.interLight.copyWith(color: textColor),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
