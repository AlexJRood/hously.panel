import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/modules/board/board_state.dart';
import 'package:hously_flutter/modules/leads/utils/lead_model.dart';
import 'package:hously_flutter/theme/design/design.dart';
import 'package:hously_flutter/api_services/api_services.dart';
import 'package:hously_flutter/api_services/url.dart';

class LeadStatusDropdownField extends ConsumerWidget {
  final int leadId;

  const LeadStatusDropdownField({super.key, required this.leadId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(leadProvider);


    return Container(
      height: 50,
      width: 200,
      child: state.when(
        data: (data) {
          final statuses = data.statuses;
      
          /// 👇 currentStatus może być nullem
          final LeadStatus? currentStatus = statuses.firstWhere(
            (s) => s.leadIndex.contains(leadId),
            orElse: () => statuses.isNotEmpty ? statuses.first : null as LeadStatus,
          );
      


          return DropdownButtonFormField<LeadStatus>(
            value: currentStatus,
            decoration: InputDecoration(
              labelText: 'Status leada',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              filled: true,
              fillColor: AppColors.light,
            ),
            items: statuses
                .map(
                  (status) => DropdownMenuItem<LeadStatus>(
                    value: status,
                    child: Text(status.statusName),
                  ),
                )
                .toList(),
            onChanged: (newStatus) async {
              if (newStatus == null || newStatus.id == currentStatus?.id) return;

              try {
                final oldStatus = currentStatus;
                final updatedLeadIndex = List<int>.from(newStatus.leadIndex);
                if (!updatedLeadIndex.contains(leadId)) {
                  updatedLeadIndex.add(leadId);
                }

                final List<Map<String, dynamic>> payload = [];

                if (oldStatus != null) {
                  payload.add({
                    'id': oldStatus.id,
                    'lead_index': oldStatus.leadIndex.where((id) => id != leadId).toList(),
                  });
                }

                payload.add({
                  'id': newStatus.id,
                  'lead_index': updatedLeadIndex,
                });

                await ApiServices.patch(
                  URLs.updateLeadStatus,
                  data: {'statuses': payload},
                  hasToken: true,
                );

                ref.read(leadProvider.notifier).fetchTransactionsAndStatuses(ref);
              } catch (e) {
                print('❌ Błąd aktualizacji statusu: $e');
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Nie udało się zmienić statusu')),
                );
              }
            },
          );
        },
        loading: () => const CircularProgressIndicator(),
        error: (err, _) => Text('Błąd: $err'),
      ),
    );
  }
}
