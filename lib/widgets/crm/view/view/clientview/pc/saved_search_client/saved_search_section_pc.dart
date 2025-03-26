import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/const/route_constant.dart';
import 'package:hously_flutter/data/design/design.dart';
import 'package:hously_flutter/state_managers/data/crm/clients/client_saved_search.dart';
import 'package:hously_flutter/state_managers/services/navigation_service.dart';
import 'package:hously_flutter/utils/pie_menu/saved_search_nm.dart';
import 'package:pie_menu/pie_menu.dart';

class ClientSavedSearchSection extends ConsumerWidget {
  final int clientId;

  const ClientSavedSearchSection({super.key, required this.clientId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final savedSearchesAsyncValue =
        ref.watch(clientSavedSearchesProvider(clientId));

    return Expanded(
      child: savedSearchesAsyncValue.when(
        data: (savedSearches) => GridView.builder(
          padding: const EdgeInsets.all(16.0),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
          ),
          itemCount: savedSearches.length,
          itemBuilder: (context, index) {
            final search = savedSearches[index];
            return PieMenu(
              onPressedWithDevice: (kind) {
                if (kind == PointerDeviceKind.mouse ||
                    kind == PointerDeviceKind.touch) {
                  ref
                      .read(navigationService)
                      .pushNamedScreen(Routes.networkMonitoring);
                }
              },
              actions: buildPieMenuActionsNMsavedSearch(
                  ref, search, search.id, context),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: AppColors.light,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        search.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        search.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) =>
            Center(child: Text('Failed to load saved searches: $error')),
      ),
    );
  }
}
