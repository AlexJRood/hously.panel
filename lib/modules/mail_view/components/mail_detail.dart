import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/modules/mail_view/utils/api_services.dart';
import 'package:hously_flutter/theme/design/button_style.dart';
import 'package:hously_flutter/theme/design/design.dart';


class EmailDetail extends ConsumerWidget {
  final int emailId;

  const EmailDetail({super.key, required this.emailId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailAsync = ref.watch(emailDetailsProvider(emailId));

    return emailAsync.when(
      data: (email) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text('Od: ', style: AppTextStyles.interLight14),
                  Text(email.sender, style: AppTextStyles.interLight14),
                ],
              ),
              Row(
                children: [
                  Text('Do: ', style: AppTextStyles.interLight14),
                  Text(email.recipients.join(', '), style: AppTextStyles.interLight14),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                _formatDateTime(email.sentAt ?? email.receivedAt), 
                style: AppTextStyles.interLight14
              ),
              const SizedBox(height: 8),
              Text(email.subject, style: AppTextStyles.interSemiBold18),
              const Divider(height: 32),
              Expanded(
                child: SingleChildScrollView(
                  child: Text(email.body, style: AppTextStyles.interLight14),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Container(
                    height: 40,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: ElevatedButton.icon(
                        style: elevatedButtonStyleRounded10,
                        onPressed: () {
                          // TODO: otwórz formularz odpowiedzi
                        },
                        icon: const Icon(Icons.reply, color: AppColors.light),
                        label: Text('Odpowiedz', style: AppTextStyles.interLight14),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    height: 40,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: OutlinedButton(
                        style: elevatedButtonStyleRounded10,
                        onPressed: () {
                          // TODO: przypisz do leada
                        },
                        child: Text('Przypisz do leada', style: AppTextStyles.interLight14),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Błąd: $e', style: AppTextStyles.interLight14),),
    );
  }

  String _formatDateTime(String? raw) {
    if (raw == null) return '';
    final date = DateTime.tryParse(raw);
    if (date == null) return raw;
    return '${date.day}.${date.month}.${date.year} ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
  }
}
