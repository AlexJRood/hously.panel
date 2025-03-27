import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hously_flutter/theme/icons.dart';
import 'package:hously_flutter/theme/apptheme.dart';
import 'package:hously_flutter/theme/backgroundgradient.dart';
import 'package:hously_flutter/theme/design/button_style.dart';
import 'package:hously_flutter/theme/design/design.dart';

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
    final tag = 'searchBar${UniqueKey().toString()}';

    return ElevatedButton(
      style: elevatedButtonStyleRounded,
      onPressed: () {},
                    // Navigator.of(context).push(
                    //   PageRouteBuilder(
                    //     opaque: false,
                    //     pageBuilder: (_, __, ___) => FiltersPage(tag: tag),
                    //     transitionsBuilder: (_, anim, __, child) {
                    //       return FadeTransition(opacity: anim, child: child);
                    //     },
                    //   ),
                    // ),
      child: Hero(
        tag: tag, // need to be change both sides of hero need the same tag 
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
              SvgPicture.asset(AppIcons.search, color: iconColor),
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
