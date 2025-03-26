import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:hously_flutter/screens/filters/filters_page.dart';
import 'package:hously_flutter/theme/apptheme.dart';
import 'package:hously_flutter/const/backgroundgradient.dart';
import 'package:hously_flutter/data/design/button_style.dart';
import 'package:hously_flutter/data/design/design.dart';

class SearchBar extends ConsumerStatefulWidget {
  const SearchBar({super.key});

  @override
  SearchBarState createState() => SearchBarState();
}

class SearchBarState extends ConsumerState<SearchBar> {
  @override
  Widget build(BuildContext context) {
    final themecolors = ref.watch(themeColorsProvider);

    final iconColor = Theme.of(context).iconTheme.color;
    final textColor = themecolors.themeTextColor;

    return ElevatedButton(
      style: elevatedButtonStyleRounded,
      onPressed: () =>
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        opaque: false,
                        pageBuilder: (_, __, ___) => const FiltersPage(),
                        transitionsBuilder: (_, anim, __, child) {
                          return FadeTransition(opacity: anim, child: child);
                        },
                      ),
                    ),
      child: Hero(
        tag: 'searchBar-5',
        child: Container(
          height: 35,
          decoration: BoxDecoration(
            gradient:
                CustomBackgroundGradients.appBarGradientcustom(context, ref),
            borderRadius: BorderRadius.circular(25.0),
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
                      'Wyszukaj...'.tr,
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
