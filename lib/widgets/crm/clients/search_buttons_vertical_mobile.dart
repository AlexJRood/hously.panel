
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:hously_flutter/const/icons.dart';
import 'package:hously_flutter/screens/filters/filters_page.dart';
import 'package:hously_flutter/screens/pop_pages/sort_pop_mobile_page.dart';
import 'package:hously_flutter/theme/apptheme.dart';
import 'package:hously_flutter/data/design/button_style.dart';
import 'package:hously_flutter/data/design/design.dart';
import 'dart:ui' as ui;
import 'package:hously_flutter/state_managers/data/crm/clients/client_provider.dart';
import 'package:get/get.dart';
import 'package:hously_flutter/widgets/installpopup/install_popup.dart';



final verticalBottomBarVisibilityProvider = StateProvider<bool>((ref) => true);

class FeedBarVerticalMobile extends ConsumerWidget {
  final WidgetRef ref;

  const FeedBarVerticalMobile({
    super.key,
    required this.ref,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {


    final iconColor = Theme.of(context).iconTheme.color;
    final currentthememode = ref.watch(themeProvider);
    final tag = 'searchBar-83-${UniqueKey().toString()}';

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
      Container(
      width: 60,
      height:60,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],),
          child: BuildNavigationOption(
              tag:tag,
            icon: Icons.search,
            label: 'Filtruj'.tr,
            onTap: () => 
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        opaque: false,
                        pageBuilder: (_, __, ___) => FiltersPage(tag:tag),
                        transitionsBuilder: (_, anim, __, child) {
                          return FadeTransition(opacity: anim, child: child);
                        },
                      ),
                    ),
            heroValue: '1',
          ),
        ),
        const SizedBox(height: 2),
        Container(
        width: 60,
        height:60,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],),
            child: BuildNavigationOption(
              tag:tag,
              icon: Icons.sort,
              label: 'Sortuj'.tr,
              onTap: () =>
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        opaque: false,
                        pageBuilder: (_, __, ___) => const SortPopMobileCrmContacts(),
                        transitionsBuilder: (_, anim, __, child) {
                          return FadeTransition(opacity: anim, child: child);
                        },
                      ),
                    ),
              heroValue: '2',
            ),
          ),
      ],
    );
  }
}

class BuildNavigationOption extends ConsumerWidget {
  const BuildNavigationOption({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
    required this.heroValue,
    required this. tag,
  });
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final String heroValue;
  final tag;

  @override
  Widget build(BuildContext context, ref) {
    final themecolors = ref.watch(themeColorsProvider);
    final textColor = themecolors.themeTextColor;
    final iconColor = Theme.of(context).iconTheme.color;

    return ElevatedButton(
      onPressed: onTap,
      style: elevatedButtonStyleRounded10,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Hero(
            tag: tag, // need to be change both sides of hero need the same tag 
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(icon, color: iconColor, size: 25),
                const SizedBox(height: 2),
                Text(label,
                    style: AppTextStyles.interMedium
                        .copyWith(fontSize: 8, color: textColor)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}





class SortPopMobileCrmContacts extends ConsumerStatefulWidget {
  const SortPopMobileCrmContacts({super.key});

  @override
  SortPopMobileCrmContactsState createState() => SortPopMobileCrmContactsState();
}

class SortPopMobileCrmContactsState extends ConsumerState<SortPopMobileCrmContacts> {
  String? selectedSort = 'amount_asc'; // Domyślnie sortowanie rosnące po kwocie
  int? selectedStatus;
  var searchController = TextEditingController(); // Kontroler tekstu
    ScrollController _scrollController = ScrollController();

  final Map<String, String> sortOptions = {
    'amount_asc': 'Kwota rosnąco',
    'amount_desc': 'Kwota malejąco',
    'date_create_asc': 'Data utworzenia rosnąco',
    'date_create_desc': 'Data utworzenia malejąco',
    'date_update_asc': 'Data aktualizacji rosnąco',
    'date_update_desc': 'Data aktualizacji malejąco',
    'name_asc': 'Imię alfabetycznie',
    'name_desc': 'Imię malejąco',
    'last_name_asc': 'Nazwisko alfabetycznie',
    'last_name_desc': 'Nazwisko malejąco',
  };

  @override
  void initState() {
    super.initState();
    // Nasłuchuj zmian w polu wyszukiwania
    searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    // Usuń nasłuchiwanie zmian w polu tekstowym
    searchController.removeListener(_onSearchChanged);
    searchController.dispose();
    super.dispose();
  }

  // Funkcja, która będzie wywoływana po każdej zmianie w polu tekstowym
  void _onSearchChanged() {
    // Wyszukiwanie po zmianie zawartości pola
    ref.read(clientProvider.notifier).fetchClients(
          status: selectedStatus,
          searchQuery:searchController.text, // Przekazujemy zapytanie wyszukiwania
        );
  }


  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final theme = ref.watch(themeColorsProvider);
    final currentThemeMode = ref.watch(themeProvider);
    final colorScheme = Theme.of(context).colorScheme;

    // Oblicz proporcję szerokości
    // double widthRatio = screenWidth / 1920.0;

    // Oblicz szerokość dla dynamicznego SizedBox
    //  double dynamicSizedBoxWidth = screenWidth * 0.5;
    //  double dynamicSizedBoxHeight = screenHeight * 0.5;

    return PopupListener(
        child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            // Ta część odpowiada za efekt rozmycia tła
            BackdropFilter(
              filter: ui.ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(
                color: Colors.black.withOpacity(0.5),
                width: double.infinity,
                height: double.infinity,
              ),
            ),
            // Obsługa dotknięcia w dowolnym miejscu aby zamknąć modal
            GestureDetector(onTap: () => Navigator.of(context).pop(),
            ),
            // Zawartość modalu
            Hero(
              tag: 'SortMobile-${UniqueKey().toString()}', // need to be change both sides of hero need the same tag 
              child: Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: screenWidth * 0.05,
                      horizontal: screenHeight * 0.1),
                  child: ClipRRect(   
                    borderRadius: BorderRadius.circular(25.0),    
                    child: Container(
                      width: screenWidth * 0.5 >= 350 ? 350 : 350,
                      height: screenHeight * 0.75 >= 450 ? 450 : 450,
                      padding: const EdgeInsets.all(20),
                      child: BackdropFilter(
                      filter: ui.ImageFilter.blur(sigmaX: 50, sigmaY: 50),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [

                              Container(
                    padding: const EdgeInsets.only(left: 3, right: 3),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        shape: BoxShape.rectangle,
                        color: theme.fillColor),
                    child: DropdownButton<String>(
                      value: selectedSort,
                      style: AppTextStyles.interRegular10
                          .copyWith(color: theme.textFieldColor),
                      underline: const SizedBox(),
                      icon: SvgPicture.asset(AppIcons.sort, color: theme.textFieldColor),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedSort = newValue;
                        });
                        // Sortowanie po zmianie opcji
                        ref.read(clientProvider.notifier).fetchClients(
                              status: selectedStatus,
                              searchQuery: searchController.text,
                              sort: selectedSort,
                            );
                      },
                      items: sortOptions.entries.map<DropdownMenuItem<String>>((entry) {
                        return DropdownMenuItem<String>(
                          value: entry.key,
                          child: Text(
                            entry.value,
                            style: AppTextStyles.interMedium14dark
                                .copyWith(color: theme.textFieldColor),
                          ),
                        );
                      }).toList(),
                    ),
                  ),


                              FilterSortButton(
                                text: 'Cena rosnąco'.tr,
                                filterKey: 'sort',
                                filterValue: 'price_asc',
                                icon: Icons.arrow_upward, // Ikona wskazująca rosnąco
                              ),
                               FilterSortButton(
                                text: 'Cena malejąco'.tr,
                                filterKey: 'sort',
                                filterValue: 'price_desc',
                                icon:
                                    Icons.arrow_downward, // Ikona wskazująca malejąco
                              ),
                               FilterSortButton(
                                text: 'Najnowsze'.tr,
                                filterKey: 'sort',
                                filterValue: 'date_desc',
                                icon: Icons.new_releases, // Ikona dla najnowszych
                              ),
                               FilterSortButton(
                                text: 'Najstarsze'.tr,
                                filterKey: 'sort',
                                filterValue: 'date_asc',
                                icon: Icons.history, // Ikona dla najstarszych
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
