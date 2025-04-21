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
          child: SingleChildScrollView(
            child: Column(
                  spacing: 10,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(),
                Row(
                  spacing: 10,
                  children: [
                      Container(
                        height: 40,
                        width: 100,
                        child: ElevatedButton(
                          style: elevatedButtonStyleRounded10,
                          onPressed: () {
                            ref.read(navigationService).pushNamedScreen(
                                '${Routes.leadsPanel}/${lead.id}/email',
                                data: lead);
                          },
                          child: Text('Email', style: AppTextStyles.interMedium),
                        ),
                      ),
            
                      
                      Container(
                        height: 40,
                        width: 100,
                        child: ElevatedButton(
                          style: elevatedButtonStyleRounded10,
                          onPressed: () {
                            // ref.read(navigationService).pushNamedScreen(
                            //     '${Routes.leadsPanel}/${lead.id}/email',
                            //     data: lead);
                          },
                          child: Text('Chat', style: AppTextStyles.interMedium),
                        ),
                      ),
            
                      
                      Container(
                        height: 40,
                        width: 100,
                        child: ElevatedButton(
                          style: elevatedButtonStyleRounded10,
                          onPressed: () {
                            // ref.read(navigationService).pushNamedScreen(
                            //     '${Routes.leadsPanel}/${lead.id}/email',
                            //     data: lead);
                          },
                          child: Text('Chat', style: AppTextStyles.interMedium),
                        ),
                      ),

                      
                      DropdownSelectField(
                        label: 'Status umowy',
                        value: lead.agreement?.agreementStatus,
                        leadId: lead.id,
                        fieldKey: 'agreement_status',
                        options: const ['Nowa', 'W trakcie', 'Podpisana', 'Zakończona'],
                      ),


                 ],
                ),
                Divider(
                  height: 1,
                  color: AppColors.light,
                ),
                const SizedBox(height:5),
                Stack(
                  children: [
                    
                    Row(
                      spacing: 20,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        
                            const SizedBox(height: 30),
                    
                        Column(
                          children: [
                            const SizedBox(height: 25),
                            Container(
                              width: 150,
                              height:150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),                          
                              color: AppColors.light,
                              ),
                            // child:
                            // Image.network(lead.avatar),
                            ),
                          ],
                        ),
                    
                    
                    Column(
                      spacing: 10,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
            
                            const SizedBox(height: 50),
                                  
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
                          ],
                        )
                      ],
                    ),
                    Positioned(
                      top: 0, 
                      right:0,
                      left:0,
            
                      child: Container(
                          width: double.infinity,
                          height: 50,
                          color: AppColors.light25,
                          child: Center(
                            child: 
                              Text('DANE PODSTAWOWE', style: AppTextStyles.interBold)),),)
                          ],
                        ),
                const SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  height: 50,
                  color: AppColors.light25,
                  child: Center(
                    child: 
                      Text('TELEFON', style: AppTextStyles.interBold))
                      ),
                EditableTextButton(
                  initialValue: lead.phones?.number ?? '',
                  leadId: lead.id,
                  fieldKey: 'phones.number',
                ),
                EditableTextButton(
                  initialValue: lead.phones?.label ?? '',
                  leadId: lead.id,
                  fieldKey: 'phones.label',
                ),
                EditableCheckbox(
                  label: 'Potwierdzony',
                  value: isConfirmed,
                  leadId: lead.id,
                  fieldKey: 'phones.is_confirmed',
                ),
            
                const SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  height: 50,
                  color: AppColors.light25,
                  child: Center(
                  child: Text('EMAIL', style: AppTextStyles.interBold)
                  ),
                ),
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
                Container(
                  width: double.infinity,
                  height: 50,
                  color: AppColors.light25,
                  child: Center(
                    child: Text('STATUS & UMOWA', style: AppTextStyles.interBold)),),
                Text('Status: ${lead.status?.statusName ?? "-"}'),
                Text('Indeks statusu: ${lead.status?.statusIndex ?? "-"}'),
                EditableCheckbox(
                  label: 'Ma umowę',
                  value: hasAgreement,
                  leadId: lead.id,
                  fieldKey: 'has_agreement',
                ),
                EditableCheckbox(
                  label: 'Spotkanie zaplanowane',
                  value: isMeeting,
                  leadId: lead.id,
                  fieldKey: 'is_meeting_scheduled',
                ),
            
                const SizedBox(height: 16),
                
                Container(
                  width: double.infinity,
                  height: 50,
                  color: AppColors.light25,
                  child: Center(
                    child: 
                 Text('REJESTRACJA', style: AppTextStyles.interBold)
                  ),
                ),
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
              ],
            ),
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
    
  final hasAgreement = lead.agreement?.hasAgreement ?? false;
  final isMeeting = lead.agreement?.isMeetingScheduled ?? false;
  final isRegistered = lead.register?.isRegister ?? false;
  final isConfirmed = lead.phones?.isConfirmed ?? false;
  final isMailSent = lead.emails?.isMailSent ?? false;
  final isMailReceived = lead.emails?.isMailReceived ?? false;


  return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // LEWA KOLUMNA
        const SizedBox(width: 20),
        Expanded(
          flex: 2,
          child: SingleChildScrollView(
            child: Column(
                  spacing: 10,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(),
                Row(
                  spacing: 10,
                  children: [
                      Container(
                        height: 40,
                        width: 100,
                        child: ElevatedButton(
                          style: elevatedButtonStyleRounded10,
                          onPressed: () {
                            ref.read(navigationService).pushNamedScreen(
                                '${Routes.leadsPanel}/${lead.id}/email',
                                data: lead);
                          },
                          child: Text('Email', style: AppTextStyles.interMedium),
                        ),
                      ),
            
                      
                      Container(
                        height: 40,
                        width: 100,
                        child: ElevatedButton(
                          style: elevatedButtonStyleRounded10,
                          onPressed: () {
                            // ref.read(navigationService).pushNamedScreen(
                            //     '${Routes.leadsPanel}/${lead.id}/email',
                            //     data: lead);
                          },
                          child: Text('Chat', style: AppTextStyles.interMedium),
                        ),
                      ),
            
                      
                      Container(
                        height: 40,
                        width: 100,
                        child: ElevatedButton(
                          style: elevatedButtonStyleRounded10,
                          onPressed: () {
                            // ref.read(navigationService).pushNamedScreen(
                            //     '${Routes.leadsPanel}/${lead.id}/email',
                            //     data: lead);
                          },
                          child: Text('Chat', style: AppTextStyles.interMedium),
                        ),
                      ),

                      
                      DropdownSelectField(
                        label: 'Status umowy',
                        value: lead.agreement?.agreementStatus,
                        leadId: lead.id,
                        fieldKey: 'agreement_status',
                        options: const ['Nowa', 'W trakcie', 'Podpisana', 'Zakończona'],
                      ),


                 ],
                ),
                Divider(
                  height: 1,
                  color: AppColors.light,
                ),
                const SizedBox(height:5),
                Stack(
                  children: [
                    
                    Row(
                      spacing: 20,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        
                            const SizedBox(height: 30),
                    
                        Column(
                          children: [
                            const SizedBox(height: 25),
                            Container(
                              width: 150,
                              height:150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),                          
                              color: AppColors.light,
                              ),
                            // child:
                            // Image.network(lead.avatar),
                            ),
                          ],
                        ),
                    
                    
                    Column(
                      spacing: 10,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
            
                            const SizedBox(height: 50),
                                  
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
                          ],
                        )
                      ],
                    ),
                    Positioned(
                      top: 0, 
                      right:0,
                      left:0,
            
                      child: Container(
                          width: double.infinity,
                          height: 50,
                          color: AppColors.light25,
                          child: Center(
                            child: 
                              Text('DANE PODSTAWOWE', style: AppTextStyles.interBold)),),)
                          ],
                        ),
                const SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  height: 50,
                  color: AppColors.light25,
                  child: Center(
                    child: 
                      Text('TELEFON', style: AppTextStyles.interBold))
                      ),
                EditableTextButton(
                  initialValue: lead.phones?.number ?? '',
                  leadId: lead.id,
                  fieldKey: 'phones.number',
                ),
                EditableTextButton(
                  initialValue: lead.phones?.label ?? '',
                  leadId: lead.id,
                  fieldKey: 'phones.label',
                ),
                EditableCheckbox(
                  label: 'Potwierdzony',
                  value: isConfirmed,
                  leadId: lead.id,
                  fieldKey: 'phones.is_confirmed',
                ),
            
                const SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  height: 50,
                  color: AppColors.light25,
                  child: Center(
                  child: Text('EMAIL', style: AppTextStyles.interBold)
                  ),
                ),
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
                Container(
                  width: double.infinity,
                  height: 50,
                  color: AppColors.light25,
                  child: Center(
                    child: Text('STATUS & UMOWA', style: AppTextStyles.interBold)),),
                Text('Status: ${lead.status?.statusName ?? "-"}'),
                Text('Indeks statusu: ${lead.status?.statusIndex ?? "-"}'),
                EditableCheckbox(
                  label: 'Ma umowę',
                  value: hasAgreement,
                  leadId: lead.id,
                  fieldKey: 'has_agreement',
                ),
                EditableCheckbox(
                  label: 'Spotkanie zaplanowane',
                  value: isMeeting,
                  leadId: lead.id,
                  fieldKey: 'is_meeting_scheduled',
                ),
            
                const SizedBox(height: 16),
                
                Container(
                  width: double.infinity,
                  height: 50,
                  color: AppColors.light25,
                  child: Center(
                    child: 
                 Text('REJESTRACJA', style: AppTextStyles.interBold)
                  ),
                ),
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
                
        
        Container(
            height: 800,
            child: LeadNoteField(lead: lead, leadId: lead.id)),


        Container(
            height: 800,
            child: LeadInteractionsPcWidget(
                isWhiteSpaceNeeded: false,
                lead: lead,
            ),
        ),
              ],
            ),
          ),
        ),
        
        
      ],
  );
}
}
