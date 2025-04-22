import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/modules/mail_view/utils/api_services.dart';
import 'package:hously_flutter/modules/mail_view/utils/mail_filters.dart';
import 'package:hously_flutter/theme/design/button_style.dart';
import 'package:hously_flutter/theme/icons2.dart';



class MailTopBar extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  onChanged: (val) {
                    ref.watch(mailSearchProvider.notifier).state = val;
                    ref.read(mailPageProvider.notifier).state = 1;
                  },
                  decoration: InputDecoration(
                    hintText: 'Szukaj po nadawcy, temacie, treści...',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                style: elevatedButtonStyleRounded10,
               onPressed: () async {
                    try {
                      await ref.read(syncEmailsProvider.future);
                      // opcjonalnie: odśwież listę
                      ref.invalidate(filteredEmailsProvider);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('✅ Synchronizacja zakończona')),
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('❌ Błąd synchronizacji: $e')),
                      );
                    }
                  },
               child: AppIcons.refresh()),
            ],
          ),
    );
  }
}
