import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:hously_flutter/data/design/design.dart';
import 'package:hously_flutter/models/crm/agent_transaction_model.dart';
import 'package:hously_flutter/state_managers/data/crm/clients/client_saved_search.dart';
import 'package:hously_flutter/state_managers/data/crm/clients/draft_provider.dart';
import 'package:hously_flutter/widgets/crm/view/view/sections/ad_list.dart';
import 'package:hously_flutter/widgets/crm/view/view/sections/ad_view.dart';

import '../../../../../../../state_managers/data/crm/clients/ad_provider.dart';

class TransactionView extends ConsumerWidget {
  final int clientId;
  final AgentTransactionModel transaction;

  const TransactionView({
    super.key,
    required this.clientId,
    required this.transaction,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      child: Row(
        children: [
          if (transaction.isSeller) ...[
            TransactionViewBuyer(clientId: clientId, transaction: transaction)
          ],
          if (transaction.isBuyer) ...[
            TransactionViewSeller(clientId: clientId, transaction: transaction)
          ]
        ],
      ),
    );
  }
}

class TransactionViewBuyer extends ConsumerWidget {
  final int clientId;
  final AgentTransactionModel transaction;

  const TransactionViewBuyer({
    super.key,
    required this.clientId,
    required this.transaction,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final savedSearchesAsyncValue = ref.watch(clientSavedSearchesProvider(clientId));
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(width: 30),
          SizedBox(
            width: 300,
            child: savedSearchesAsyncValue.when(
              data: (savedSearches) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // Dodaj przycisk do wybrania wszystkich wyszukiwań
                    GestureDetector(
                      onTap: () {
                        ref.read(filterProvider.notifier).setSavedSearch('',ref); // Reset wyboru, aby pokazać wszystkie
                        ref.read(filterProvider.notifier).setClientId(clientId.toString(),ref);
                      },
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: AppColors.light,
                        ),
                        padding: const EdgeInsets.all(16.0),
                        child: Center(
                          child: Text(
                            'Pokaż wszystkie'.tr,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: ref.watch(filterProvider.notifier)
                                      .selectedSavedSearchId
                                      .isEmpty
                                  ? Colors.blue
                                  : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 16), // Odstęp między kafelkami

                    // GridView z zapisanymi wyszukiwaniami
                    Expanded(
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          crossAxisSpacing: 15,
                          mainAxisSpacing: 15,
                        ),
                        itemCount: savedSearches.length,
                        itemBuilder: (context, index) {
                          final search = savedSearches[index];
                          final isSelected = ref.watch(filterProvider.notifier).selectedSavedSearchId == search.id.toString();

                          return GestureDetector(
                            onTap: () {
                              ref.read(filterProvider.notifier).setClientId('',ref);
                              ref.read(filterProvider.notifier)
                                  .setSavedSearch(search.id.toString(),ref);
                            },
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color:
                                    isSelected ? Colors.blue : AppColors.light,
                              ),
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    search.title,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: isSelected
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    search.description,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: isSelected
                                          ? Colors.white70
                                          : Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(
                child: Text('Failed to load saved searches: $error'),
              ),
            ),
          ),
          const SizedBox(width: 100),
          const AdListClient(),
          const SizedBox(width: 100),
        ],
      ),
    );
  }
}

class TransactionViewSeller extends ConsumerWidget {
  final int clientId;
  final AgentTransactionModel transaction;

  const TransactionViewSeller({
    super.key,
    required this.clientId,
    required this.transaction,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int? draftId = transaction.draft;
    print("draftId value: $draftId and type: ${draftId.runtimeType}");

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            ref.watch(draftAdProvider(draftId!)).when(
                  data: (draft) => AdViewClient(adFeedPop: draft),
                  loading: () =>
                      const CircularProgressIndicator(), // Show loading
                  error: (err, stack) =>
                      Text('Error: $err', style: AppTextStyles.interLight18),
                ),
          ],
        ),
      ),
    );
  }
}

class FilterSearchSelection extends ConsumerWidget {
  final int clientId;

  const FilterSearchSelection({super.key, required this.clientId});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final savedSearchesAsyncValue =
        ref.watch(clientSavedSearchesProvider(clientId));

    return savedSearchesAsyncValue.when(
      data: (savedSearches) {
        return DropdownButton<String>(
          value: ref.watch(filterProvider.notifier).selectedSavedSearchId,
          onChanged: (String? newValue) {
            ref.read(filterProvider.notifier).setSavedSearch(newValue!,ref);
          },
          items: [
             DropdownMenuItem(value: '', child: Text('Pokaż wszystkie'.tr)),
            ...savedSearches.map((search) {
              return DropdownMenuItem(
                value: search.id.toString(),
                child: Text(search.title),
              );
            }).toList(),
          ],
        );
      },
      loading: () => const CircularProgressIndicator(),
      error: (error, stack) =>
           Text('Błąd wczytywania zapisanych wyszukiwań'.tr),
    );
  }
}
