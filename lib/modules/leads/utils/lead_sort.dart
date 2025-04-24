import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/modules/leads/utils/lead_api.dart';
import 'package:hously_flutter/theme/design/design.dart';




class LeadSortingDialog extends ConsumerWidget {
  const LeadSortingDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentOrdering = ref.watch(leadOrderingProvider);
    final orderingNotifier = ref.read(leadOrderingProvider.notifier);

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Sortuj leady', style: AppTextStyles.interSemiBold.copyWith(fontSize: 20)),
            const SizedBox(height: 24),
            DropdownButtonFormField<String>(
              value: currentOrdering,
              decoration: const InputDecoration(
                labelText: 'Kolejność',
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(value: 'name', child: Text('Imię A-Z')),
                DropdownMenuItem(value: '-name', child: Text('Imię Z-A')),
                DropdownMenuItem(value: 'city', child: Text('Miasto A-Z')),
                DropdownMenuItem(value: '-city', child: Text('Miasto Z-A')),
                DropdownMenuItem(value: 'id', child: Text('ID rosnąco')),
                DropdownMenuItem(value: '-id', child: Text('ID malejąco')),
              ],
              onChanged: (value) {
                orderingNotifier.state = value;
              },
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    orderingNotifier.state = null;
                    Navigator.pop(context);
                  },
                  child: const Text('Resetuj'),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Zastosuj'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
