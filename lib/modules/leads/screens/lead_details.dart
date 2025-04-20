import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/modules/leads/components/dropdown_select_field.dart';
import 'package:hously_flutter/modules/leads/components/editable_button.dart';
import 'package:hously_flutter/modules/leads/components/editable_checkbox.dart';
import 'package:hously_flutter/modules/leads/components/editable_date_field.dart';
import 'package:hously_flutter/modules/leads/components/lead_note.dart';
import 'package:hously_flutter/modules/leads/utils/lead_api.dart';
import 'package:hously_flutter/modules/leads/utils/lead_model.dart';
import 'package:hously_flutter/modules/leads/widgets/pc.dart';
import 'package:hously_flutter/theme/design/button_style.dart';
import 'package:hously_flutter/theme/design/design.dart';
import 'package:hously_flutter/widgets/bars/bar_manager.dart';
import 'package:hously_flutter/widgets/side_menu/slide_rotate_menu.dart';
import 'package:hously_flutter/routing/route_constant.dart';
import 'package:hously_flutter/routing/navigation_service.dart';

class LeadDetailsPage extends ConsumerWidget {
  final int leadId;

  LeadDetailsPage({super.key, required this.leadId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sideMenuKey = GlobalKey<SideMenuState>();
    final asyncLead = ref.watch(leadDetailsProvider(leadId));

    return BarManager(
      sideMenuKey: sideMenuKey,
      children: [
        Expanded(
          child: asyncLead.when(
            data: (lead) {
              return LayoutBuilder(
                builder: (context, constraints) {
                  final isWide = constraints.maxWidth > 800;
                  return isWide
                      ? pcLeadDetails(context, lead, ref)
                      : mobileLeadDetails(context, lead, ref);
                },
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Center(
              child: Text('Błąd: $e', style: AppTextStyles.interMedium),
            ),
          ),
        ),
      ],
    );
  }








Widget pcLeadDetails(BuildContext context, Lead lead, WidgetRef ref) {
  final hasAgreement = lead.agreement?.hasAgreement ?? false;
  final isMeeting = lead.agreement?.isMeetingScheduled ?? false;
  final isRegistered = lead.register?.isRegister ?? false;
  final isConfirmed = lead.phones?.isConfirmed ?? false;
  final isMailSent = lead.emails?.isMailSent ?? false;
  final isMailReceived = lead.emails?.isMailReceived ?? false;

  return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // LEWA KOLUMNA
        const SizedBox(width: 20),
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                
                    Container(
                      height: 40,
                      width: 120,
                      child: ElevatedButton(
                        style: elevatedButtonStyleRounded10,
                        onPressed: () {
                          ref.read(navigationService).pushNamedScreen(
                              '${Routes.leadsPanel}/${lead.id}/email',
                              data: lead);
                        },
                        child: Text('Email', style: AppTextStyles.interMedium),
                      ),
                    )
               ],
              ),
              const SizedBox(height: 12),
              Text('🧾 DANE PODSTAWOWE', style: AppTextStyles.interBold),
              const SizedBox(height: 8),
              EditableTextButton(
                initialValue: lead.name,
                leadId: lead.id,
                fieldKey: 'name',
              ),
              EditableTextButton(
                initialValue: lead.companyName ?? '',
                leadId: lead.id,
                fieldKey: 'company_name',
              ),

              const SizedBox(height: 16),
              Text('📞 TELEFON', style: AppTextStyles.interBold),
              EditableTextButton(
                initialValue: lead.phones?.number ?? '',
                leadId: lead.id,
                fieldKey: 'phone_number',
              ),
              EditableTextButton(
                initialValue: lead.phones?.label ?? '',
                leadId: lead.id,
                fieldKey: 'phone_label',
              ),
              EditableCheckbox(
                label: 'Potwierdzony',
                value: isConfirmed,
                leadId: lead.id,
                fieldKey: 'is_confirmed',
              ),

              const SizedBox(height: 16),
              Text('📧 EMAIL', style: AppTextStyles.interBold),
              EditableTextButton(
                initialValue: lead.emails?.mail ?? '',
                leadId: lead.id,
                fieldKey: 'mail',
              ),
              EditableTextButton(
                initialValue: lead.emails?.mailContent ?? '',
                leadId: lead.id,
                fieldKey: 'mail_content',
              ),
              EditableCheckbox(
                label: 'Wysłany',
                value: isMailSent,
                leadId: lead.id,
                fieldKey: 'is_mail_sent',
              ),
              EditableCheckbox(
                label: 'Odebrany',
                value: isMailReceived,
                leadId: lead.id,
                fieldKey: 'is_mail_received',
              ),
              EditableTextButton(
                initialValue: lead.emails?.receiveMailContent ?? '',
                leadId: lead.id,
                fieldKey: 'receive_mail_content',
              ),
              EditableDateField(
                label: 'Data wysłania',
                initialDate: lead.emails?.mailSentDate,
                leadId: lead.id,
                fieldKey: 'mail_sent_date',
              ),
              EditableDateField(
                label: 'Data odpowiedzi',
                initialDate: lead.emails?.mailResponseDate,
                leadId: lead.id,
                fieldKey: 'mail_response_date',
              ),

              const SizedBox(height: 16),
              Text('📄 STATUS & UMOWA', style: AppTextStyles.interBold),
              Text('Status: ${lead.status?.statusName ?? "-"}'),
              Text('Indeks statusu: ${lead.status?.statusIndex ?? "-"}'),
              EditableCheckbox(
                label: 'Ma umowę',
                value: hasAgreement,
                leadId: lead.id,
                fieldKey: 'has_agreement',
              ),
              DropdownSelectField(
                label: 'Status umowy',
                value: lead.agreement?.agreementStatus,
                leadId: lead.id,
                fieldKey: 'agreement_status',
                options: const ['Nowa', 'W trakcie', 'Podpisana', 'Zakończona'],
              ),
              EditableCheckbox(
                label: 'Spotkanie zaplanowane',
                value: isMeeting,
                leadId: lead.id,
                fieldKey: 'is_meeting_scheduled',
              ),

              const SizedBox(height: 16),
              Text('👤 REJESTRACJA', style: AppTextStyles.interBold),
              EditableCheckbox(
                label: 'Zarejestrowany',
                value: isRegistered,
                leadId: lead.id,
                fieldKey: 'is_register',
              ),
              EditableTextButton(
                initialValue: lead.register?.registerUser?.toString() ?? '',
                leadId: lead.id,
                fieldKey: 'register_user',
              ),

              const SizedBox(height: 16),
              Text('📝 NOTATKA', style: AppTextStyles.interBold),
            ],
          ),
        ),
        
        
        
        LeadNoteField(lead: lead, leadId: lead.id),


        LeadInteractionsPcWidget(
            isWhiteSpaceNeeded: false,
            lead: lead,
          ),
      ],
  );
}











  

  Widget mobileLeadDetails(BuildContext context, Lead lead, WidgetRef ref) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (lead.status != null)
              Text('Status: ${lead.status!.statusName}',
                  style: AppTextStyles.interMedium),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Text('Imię: ${lead.name ?? "-"}',
                      style: AppTextStyles.interBold),
                ),
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    // Dodaj dialog edycji jeśli chcesz
                  },
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Firma: ${lead.companyName ?? "-"}',
                    style: AppTextStyles.interMedium,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    // Dodaj dialog edycji jeśli chcesz
                  },
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text('Notatka:', style: AppTextStyles.interBold),


        // PRAWA KOLUMNA – notatka i interakcje
        LeadNoteField(lead: lead, leadId: leadId),

            const SizedBox(height: 24),
            Text('Interakcje:', style: AppTextStyles.interBold),
            LeadInteractionsPcWidget(isWhiteSpaceNeeded: false, lead: lead),
          ],
        ),
      ),
    );
  }
}
