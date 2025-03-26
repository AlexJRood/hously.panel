import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:hously_flutter/data/design/design.dart';
import 'package:hously_flutter/models/crm/user_contact_status_model.dart';
import 'package:hously_flutter/state_managers/data/crm/clients/client_provider.dart';

class StatusFilterWidgetMobile extends ConsumerStatefulWidget {
  const StatusFilterWidgetMobile({super.key});

  @override
  ConsumerState<StatusFilterWidgetMobile> createState() =>
      StatusFilterWidgetMobileState();
}

class StatusFilterWidgetMobileState
    extends ConsumerState<StatusFilterWidgetMobile> {
  int? selectedStatus;
  var searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    searchController.removeListener(_onSearchChanged);
    searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    ref.read(clientProvider.notifier).fetchClients(
          status: selectedStatus,
          searchQuery: searchController.text,
        );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double searchWidth = screenWidth;

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: SizedBox(
              height: 50,
              width: searchWidth,
              child: TextField(
                style:
                    AppTextStyles.interMedium16.copyWith(color: Colors.white),
                controller: searchController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color.fromRGBO(255, 255, 255, 0.1),
                  labelText: 'Szukaj klientów'.tr,
                  labelStyle: AppTextStyles.interMedium14
                      .copyWith(color: const Color.fromRGBO(255, 255, 255, 1)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide.none),
                  prefixIcon: const Icon(Icons.search,
                      color: Color.fromRGBO(255, 255, 255, 1)),
                ),
              ),
            ),
          ),
        ),
        PopupMenuButton(
          color: Colors.black.withOpacity(0.5),
          icon: Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: Colors.grey),
            ),
            child: const Icon(Icons.sort_sharp, color: Colors.white),
          ),
          itemBuilder: (context) => [
            PopupMenuItem(
              textStyle: const TextStyle(color: Colors.white),
              child: FutureBuilder<List<UserContactStatusModel>>(
                future: ref.watch(clientProvider.notifier).fetchStatuses(ref),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return const Text('Failed to load statuses');
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Text('No statuses available');
                  }

                  List<UserContactStatusModel> statuses = snapshot.data!;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        title: const Text(
                          'All',
                          style: TextStyle(color: Colors.white),
                        ),
                        onTap: () {
                          setState(() {
                            selectedStatus = null;
                          });
                          ref
                              .read(clientProvider.notifier)
                              .fetchClients(status: selectedStatus);
                          Navigator.pop(context);
                        },
                      ),
                      ...statuses.map((status) {
                        return ListTile(
                          title: Text(
                            status.statusName,
                            style: const TextStyle(color: Colors.white),
                          ),
                          onTap: () {
                            setState(() {
                              selectedStatus = status.statusId;
                            });
                            ref
                                .read(clientProvider.notifier)
                                .fetchClients(status: selectedStatus);
                            Navigator.pop(context);
                          },
                        );
                      }),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
