import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/modules/leads/utils/lead_model.dart';
import 'package:hously_flutter/modules/mail_view/components/mail_detail.dart';
import 'package:hously_flutter/modules/mail_view/send_mail/send_mail.dart';
import 'package:hously_flutter/modules/mail_view/utils/api_services.dart';
import 'package:hously_flutter/theme/design/design.dart';
import 'package:hously_flutter/widgets/bars/bar_manager.dart';
import 'package:hously_flutter/widgets/side_menu/slide_rotate_menu.dart';

class EmailsByLeadView extends ConsumerStatefulWidget {
  final int leadId;
  final Lead? lead;

  const EmailsByLeadView({
  super.key, 
  required this.leadId,
  this.lead
  });

  @override
  ConsumerState<EmailsByLeadView> createState() => _EmailsByLeadViewState();
}

class _EmailsByLeadViewState extends ConsumerState<EmailsByLeadView> {
  int? selectedEmailId;

  final sideMenuKey = GlobalKey<SideMenuState>();

  @override
  Widget build(BuildContext context) {
    final emailsAsync = ref.watch(emailsByLeadProvider(widget.leadId));

    return BarManager(
      sideMenuKey: sideMenuKey,
      children: [
        Expanded(
          child: Row(
            children: [
              // Lista wiadomości
              Expanded(
                flex:1,
                child: emailsAsync.when(
                  data: (data) {
                    final emails = data.results;
          
                    if (emails.isEmpty) {
                      return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.mail_outline, size: 48, color: AppColors.light),
                              SizedBox(height: 8),
                              Text('Brak wiadomości powiązanych z leadem', style: AppTextStyles.interLight16),
                            ],
                      );
                    }
          
                    return ListView.builder(
                      itemCount: emails.length,
                      itemBuilder: (context, index) {
                        final email = emails[index];
                        return ListTile(
                          title: Text(email.subject, style: AppTextStyles.interLight16),
                          subtitle: Text(email.sender, style: AppTextStyles.interLight16),
                          selected: email.id == selectedEmailId,
                          onTap: () => setState(() => selectedEmailId = email.id),
                        );
                      },
                    );
                  },
                  loading: () => const Center(child: CircularProgressIndicator()),
                  error: (e, _) => Center(
                    child: Text('Błąd: $e', style: AppTextStyles.interLight16),
                  ),
                ),
              ),
          
              // Podgląd wiadomości
              Expanded(
                flex:2,
                child: selectedEmailId == null
                    ? Center(
                        child: Text(
                          'Wybierz wiadomość',
                          style: AppTextStyles.interLight16,
                        ),
                      )
                    : EmailDetail(emailId: selectedEmailId!),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
