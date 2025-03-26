import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:hously_flutter/data/design/design.dart';
import 'package:hously_flutter/models/crm/user_contact_status_model.dart';
import 'package:hously_flutter/state_managers/data/crm/clients/client_provider.dart';
import 'package:hously_flutter/theme/apptheme.dart';
import 'package:hously_flutter/widgets/loading/loading_widgets.dart';

class StatusFilterWidget extends ConsumerStatefulWidget {
  const StatusFilterWidget({super.key});

  @override
  ConsumerState<StatusFilterWidget> createState() => _StatusFilterWidgetState();
}

class _StatusFilterWidgetState extends ConsumerState<StatusFilterWidget> {
  String? selectedSort = 'amount_asc'; // Domyślnie sortowanie rosnące po kwocie
  int? selectedStatus;
  var searchController = TextEditingController(); // Kontroler tekstu

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
          searchQuery:
              searchController.text, // Przekazujemy zapytanie wyszukiwania
        );
  }

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(themeColorsProvider);
    final currentThemeMode = ref.watch(themeProvider);
    final colorScheme = Theme.of(context).colorScheme;

    final selectedTextColor = currentThemeMode == ThemeMode.system
        ? Colors.black
        : colorScheme.onPrimary;

    final unselectedTextColor = currentThemeMode == ThemeMode.system
        ? AppColors.light
        : currentThemeMode == ThemeMode.light
            ? AppColors.textColorDark
            : AppColors.textColorLight;
    double screenWidth = MediaQuery.of(context).size.width-160;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 50,
            width: screenWidth,
            child: TextField(
              style: AppTextStyles.interMedium16
                  .copyWith(color: Colors.white),
              controller: searchController,
              cursorColor: const Color.fromRGBO(79, 79, 79, 1),
              decoration: InputDecoration(
                prefixIcon: const Icon(
                  Icons.search,
                  color: Color.fromRGBO(79, 79, 79, 1),
                ),
                filled: true,
                fillColor: const Color.fromRGBO(35, 35, 35, 1),
                hintText: 'Szukaj klientów'.tr,
                hintStyle: AppTextStyles.interMedium14
                    .copyWith(color: const Color.fromRGBO(79, 79, 79, 1)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide.none
                ),
                focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide.none
                )
              ),
            ),
          ),
          const SizedBox(height: 15),
          SizedBox(
            width: screenWidth,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FutureBuilder<List<UserContactStatusModel>>(
                  future: ref.watch(clientProvider.notifier).fetchStatuses(ref),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<UserContactStatusModel>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ShimmerPlaceholder(width: 60, height: 30, radius: 5),
                            SizedBox(width: 5),
                            ShimmerPlaceholder(width: 60, height: 30, radius: 5),
                            SizedBox(width: 5),
                            ShimmerPlaceholder(width: 80, height: 30, radius: 5),
                            SizedBox(width: 5),
                            ShimmerPlaceholder(width: 80, height: 30, radius: 5),
                            SizedBox(width: 5),
                          ],
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Text(
                        'Failed to load statuses',
                        style:
                            TextStyle(color: Theme.of(context).iconTheme.color),
                      );
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Text(
                        'No statuses available',
                        style:
                            TextStyle(color: Theme.of(context).iconTheme.color),
                      );
                    }

                    List<UserContactStatusModel> statuses = snapshot.data!;

                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // "All" Button to fetch all clients
                          TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: selectedStatus == null
                                  ? const Color.fromRGBO(200, 200, 200, 1) // Selected state
                                  : Colors.transparent,
                              foregroundColor: Colors.white,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(5)),
                                side: BorderSide(color: Color.fromRGBO(90, 90, 90, 1)),
                              ),
                            ),
                            onPressed: () {
                              setState(() {
                                selectedStatus = null; // Reset to null to fetch all
                              });
                              ref.read(clientProvider.notifier).fetchClients(status: null); // Fetch all clients
                            },
                            child: Text(
                              'All',
                              style: AppTextStyles.interMedium14dark.copyWith(
                                color: selectedStatus == null // Fixed condition
                                    ? selectedTextColor
                                    : unselectedTextColor,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),

                          // Dynamically generate buttons for each status
                          ...statuses.map((UserContactStatusModel status) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: TextButton(
                                style: TextButton.styleFrom(
                                  backgroundColor: selectedStatus == status.statusId
                                      ? const Color.fromRGBO(200, 200, 200, 1) // Selected state
                                      : Colors.transparent,
                                  foregroundColor: Colors.white,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(5)),
                                    side: BorderSide(color: Color.fromRGBO(90, 90, 90, 1)),
                                  ),
                                ),
                                onPressed: () {
                                  setState(() {
                                    selectedStatus = status.statusId; // Set selected status
                                  });
                                  ref
                                      .read(clientProvider.notifier)
                                      .fetchClients(status: selectedStatus); // Fetch filtered clients
                                },
                                child: Text(
                                  status.statusName,
                                  style: AppTextStyles.interMedium14dark.copyWith(
                                    color: selectedStatus == status.statusId // Fixed condition
                                        ? selectedTextColor
                                        : unselectedTextColor,
                                  ),
                                ),
                              ),
                            );
                          }),
                        ],
                      ),
                    );
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      height: 32,
                      padding: const EdgeInsets.only(left: 3, right: 3),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          shape: BoxShape.rectangle,
                          color: const Color.fromRGBO(200, 200, 200, 1)),
                      child: DropdownButton<String>(
                        value: selectedSort,
                        style: AppTextStyles.interRegular10
                            .copyWith(color: theme.textFieldColor),
                        underline: const SizedBox(),
                        icon: Icon(Icons.sort, color: theme.textFieldColor),
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
                        items: sortOptions.entries
                            .map<DropdownMenuItem<String>>((entry) {
                          return DropdownMenuItem<String>(
                            value: entry.key,
                            child: Text(
                              entry.value, // Wyświetlaj przetłumaczone wartości
                              style: AppTextStyles.interMedium14dark
                                  .copyWith(color: theme.textFieldColor),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
