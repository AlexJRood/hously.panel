import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hously_flutter/modules/leads/utils/lead_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/theme/design/design.dart';



class EditableDateField extends ConsumerWidget {
  final String label;
  final String? initialDate; // w formacie "YYYY-MM-DD"
  final int leadId;
  final String fieldKey;

  const EditableDateField({
    super.key,
    required this.label,
    required this.initialDate,
    required this.leadId,
    required this.fieldKey,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      title: Text('$label: ${initialDate ?? "brak danych".tr}', style: AppTextStyles.interLight16),
      trailing: IconButton(
        icon: const Icon(Icons.calendar_today, color: AppColors.light),
        onPressed: () async {
          final date = await showDatePicker(
            context: context,
            initialDate: initialDate != null
                ? DateTime.parse(initialDate!)
                : DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2100),
          );
          if (date != null) {
            final formatted = '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
            await LeadService.updateLead(
              leadId: leadId,
              ref: ref,
              data: {fieldKey: formatted},
            );
          }
        },
      ),
    );
  }
}
