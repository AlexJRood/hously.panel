import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/modules/board/board_state.dart';
import 'package:hously_flutter/modules/leads/utils/lead_model.dart';
import 'package:hously_flutter/theme/design/design.dart';
import 'package:hously_flutter/api_services/api_services.dart';
import 'package:hously_flutter/api_services/url.dart';
import 'package:collection/collection.dart';
import 'package:hously_flutter/utils/loading_widgets.dart';

class LeadStatusDropdownField extends ConsumerWidget {
  final int leadId;

  const LeadStatusDropdownField({super.key, required this.leadId});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(leadProvider);

    return Container(
      height: 50,
      width: 250,
      child: state.when(
        data: (data) {
          final statuses = data.statuses;
          final currentStatus = statuses.firstWhereOrNull(
            (status) => status.leadIndex.contains(leadId),
          );

          if (statuses.isEmpty) {
            return const Text('⚠️ Brak dostępnych statusów');
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DropdownButtonFormField<int?>(
                value: currentStatus?.id,
                borderRadius: BorderRadius.circular(10),
                dropdownColor: AppColors.darkSettingsButtoncolor,
                decoration: InputDecoration(
                    label: Text('Status leada',
                        style: AppTextStyles.interMedium14),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    filled: false),
                items: [
                  DropdownMenuItem<int?>(
                    value: null,
                    child: Text('Brak statusu',
                        style: AppTextStyles.interMedium14),
                  ),
                  ...statuses.map(
                    (status) => DropdownMenuItem<int?>(
                      value: status.id,
                      child: Text(status.statusName,
                          style: AppTextStyles.interMedium14),
                    ),
                  ),
                ],
                onChanged: (int? selectedId) async {
                  final oldStatus = statuses
                      .firstWhereOrNull((s) => s.leadIndex.contains(leadId));
                  final newStatus =
                      statuses.firstWhereOrNull((s) => s.id == selectedId);

                  if (oldStatus?.id == newStatus?.id) return;

                  try {
                    final List<Map<String, dynamic>> payload = [];

                    if (oldStatus != null) {
                      payload.add({
                        'id': oldStatus.id,
                        'lead_index': oldStatus.leadIndex
                            .where((id) => id != leadId)
                            .toList(),
                      });
                    }

                    if (newStatus != null) {
                      final updatedLeadIndex =
                          {...newStatus.leadIndex, leadId}.toList();
                      payload.add({
                        'id': newStatus.id,
                        'lead_index': updatedLeadIndex,
                      });
                    }

                    await ApiServices.patch(
                      URLs.updateLeadStatus,
                      data: {'statuses': payload},
                      hasToken: true,
                    );

                    ref
                        .read(leadProvider.notifier)
                        .fetchTransactionsAndStatuses(ref);
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('❌ Nie udało się zmienić statusu')),
                    );
                  }
                },
              ),
            ],
          );
        },
        loading: () => const ShimmerPlaceholder(width: 250, height: 50),
        error: (err, _) => Text('❌ Błąd: $err'),
      ),
    );
  }
}
