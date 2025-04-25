import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/modules/board/board_state.dart';
import 'package:hously_flutter/modules/leads/components/dropdown_select_field.dart';
import 'package:hously_flutter/modules/leads/components/editable_button.dart';
import 'package:hously_flutter/modules/leads/components/editable_checkbox.dart';
import 'package:hously_flutter/modules/leads/components/editable_date_field.dart';
import 'package:hously_flutter/modules/leads/components/lead_note.dart';
import 'package:hously_flutter/modules/leads/components/lead_status_dropdown_field.dart';
import 'package:hously_flutter/modules/leads/speech/speech_to_text.dart';
import 'package:hously_flutter/modules/leads/utils/lead_api.dart';
import 'package:hously_flutter/modules/leads/utils/lead_model.dart';
import 'package:hously_flutter/modules/leads/utils/lead_register.dart';
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


String? getLeadStatusName(int leadId, List<LeadStatus> statuses) {
  for (final status in statuses) {
    if (status.leadIndex.contains(leadId)) {
      return status.statusName;
    }
  }
  return null;
}

int? getLeadStatusIndex(int leadId, List<LeadStatus> statuses) {
  for (final status in statuses) {
    if (status.leadIndex.contains(leadId)) {
      return status.statusIndex;
    }
  }
  return null;
}




Widget pcLeadDetails(BuildContext context, Lead lead, WidgetRef ref) {
  final hasAgreement = lead.hasAgreement ?? false;
  final isMeeting = lead.isMeetingScheduled ?? false;
  final isRegistered = lead.isRegister ?? false;
  final isConfirmed = lead.isNumberConfirmed ?? false;
  final isMailSent = lead.isMailSent ?? false;
  final isMailReceived = lead.isMailReceived ?? false;
    final TextEditingController _noteController = TextEditingController();


final boardStateAsync = ref.watch(leadProvider);
final statusName = boardStateAsync.maybeWhen(
  data: (data) => getLeadStatusName(lead.id, data.statuses),
  orElse: () => null,
);
final statusIndex = boardStateAsync.maybeWhen(
  data: (data) => getLeadStatusIndex(lead.id, data.statuses),
  orElse: () => null,
);



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
            
                      
                      if(isRegistered)
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
                      
                      
                      if(isRegistered)
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
                          child: Text('Pokaż konto', style: AppTextStyles.interMedium),
                        ),
                      ),

                      if(!isRegistered)
                      Container(
                        height: 40,
                        width: 100,
                        child: ElevatedButton(
                          style: elevatedButtonStyleRounded10,
                          onPressed: () {
                           showRegisterPopup(context, lead: lead); // ← przekaż lead
                          },
                          child: Text('Zarejestruj', style: AppTextStyles.interMedium),
                        ),
                      ),

                      
VoiceNoteWidget(
onResult: (text) {
  _noteController.text = text;
},

),



                  Spacer(),
                      
                  LeadStatusDropdownField(leadId: lead.id),


                 ],
                ),
                Divider(
                  height: 1,
                  color: AppColors.light,
                ),
                const SizedBox(height:5),
                Stack(
                  children: [
                      Positioned(
                      top: 0, 
                      right:0,
                      left:0,
            
                      child: Container(
                          width: double.infinity,
                          height: 50,
                          color: AppColors.light25,
                            child: 
                          EditableTextButton(
                            isTitle: true,
                            initialValue: lead.companyName ?? '',
                            leadId: lead.id,
                            fieldKey: 'company_name',
                          ),
                             ),),
                    
                    Row(
                      spacing: 20,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                                            
                    
                    Column(
                      spacing: 10,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
            
                            const SizedBox(height: 50),
                                  
                          Row(
                            spacing:20,
                            children: [
                              
                            const SizedBox(width: 40),
                            SizedBox(
                              width:120,
                              child: Text('IMIĘ I NAZWISKO', style: AppTextStyles.interBold),
                            ),

                              EditableTextButton(
                                initialValue: lead.name,
                                leadId: lead.id,
                                fieldKey: 'name',
                              ),
                            ],
                          ),

                Row(
                  spacing: 20,
                  children: [
                    
                SizedBox(
                  width: 40,
                  child: EditableCheckbox(
                    label: '',
                    value: isConfirmed,
                    leadId: lead.id,
                    fieldKey: 'is_number_confirmed',
                  ),
                ),
                      SizedBox(
                        width:120,
                        child: Text('TELEFON', style: AppTextStyles.interBold),
                      ),

                    EditableTextButton(
                      initialValue: lead.number ?? '',
                      leadId: lead.id,
                      fieldKey: 'number',
                    ),
                    EditableTextButton(
                      initialValue: lead.aditionalNumber ?? '',
                      leadId: lead.id,
                      fieldKey: 'aditional_number',
                    ),
                    

                  ],
                ),
                Row(
                  spacing: 20,
                  children: [
                SizedBox(
                  width:40,
                  child: EditableCheckbox(
                    label: '',
                    value: isConfirmed,
                    leadId: lead.id,
                    fieldKey: 'is_mail_confirmed',
                  ),
                ),
                      SizedBox(
                        width:120,
                        child: Text('MAIL', style: AppTextStyles.interBold)
                        ),
                    EditableTextButton(
                      initialValue: lead.email ?? '',
                      leadId: lead.id,
                      fieldKey: 'mail',
                    ),
                    EditableTextButton(
                      initialValue: lead.aditionalEmail ?? '',
                      leadId: lead.id,
                      fieldKey: 'aditional_mail',
                    ),
                  ],
                ),
                Row(
                  spacing: 20,
                  children: [
                    SizedBox(
                      width:40,
                      child: EditableCheckbox(
                        label: '',
                        value: hasAgreement,
                        leadId: lead.id,
                        fieldKey: 'has_agreement',
                      ),
                    ),
                    
                      SizedBox(
                        width:120,
                        child: Text('AGREEMENT', style: AppTextStyles.interBold),
                      ),
                      Text('Dropdown with agrement types to select', style: AppTextStyles.interBold),

                  ],
                ),
            
            


                          ],
                        ),
                        Spacer(),

                    
                        Column(
                          children: [
                            const SizedBox(height: 25),
                              Container(
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              boxShadow: [
                                BoxShadow(
                                  color: (lead.isRegister ?  AppColors.revenueGreen : AppColors.expensesRed ),
                                  blurRadius: 12,
                                  spreadRadius: 2,
                                  offset: const Offset(0,0),
                                ),
                              ],
                              borderRadius: BorderRadius.circular(12), // opcjonalnie
                            ),
                              child: ClipRRect(
                                                      borderRadius: BorderRadius.circular(10),
                                                      child: Container(
                                                        width: 150,
                                                        height: 150,
                                                        color: Colors.grey.shade200, // opcjonalne tło
                                                        child: lead.avatar == null
                                ? Image.asset('assets/images/deafult/man.webp',
                                    fit: BoxFit.cover)
                                : Image.network(lead.avatar!, fit: BoxFit.cover),
                                                      ),
                                                    ),
                            ),
                            const SizedBox(height: 10),
                      
                SizedBox(
                  width: 150,
                  child: EditableTextButton(
                    isCenter: true,
                    initialValue: lead.label ?? '',
                    leadId: lead.id,
                    fieldKey: 'label',
                  ),
                ),
                      
                          ],
                        ),
                const SizedBox(width: 5),
                        
                      ],
                    ),

                
                          ],
                        ),
                          
                
                const SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  height: 50,
                  color: AppColors.light25,
                  child: Center(
                  child: Text('MAIL SCHEDULER', style: AppTextStyles.interBold)
                  ),
                ),
                
                EditableDateField(
                  label: 'Data wysłania',
                  initialDate: lead.mailSentDate,
                  leadId: lead.id,
                  fieldKey: 'mail_sent_date',
                ),
                EditableDateField(
                  label: 'Data odpowiedzi',
                  initialDate: lead.mailResponseDate,
                  leadId: lead.id,
                  fieldKey: 'mail_response_date',
                ),

                const SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  height: 50,
                  color: AppColors.light25,
                  child: Center(
                    child: 
                      Text('SCHEDULER', style: AppTextStyles.interBold),
                      )
                      ),
                      
                EditableCheckbox(
                  label: 'Spotkanie zaplanowane',
                  value: isMeeting,
                  leadId: lead.id,
                  fieldKey: 'is_meeting_scheduled',
                ),

                TextField(
  controller: _noteController,
  maxLines: null,
  decoration: InputDecoration(
    labelText: 'Notatka',
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
  ),
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
    
  final hasAgreement = lead.hasAgreement ?? false;
  final isMeeting = lead.isMeetingScheduled ?? false;
  final isRegistered = lead.isRegister ?? false;
  final isConfirmed = lead.isNumberConfirmed ?? false;
  final isMailSent = lead.isMailSent ?? false;
  final isMailReceived = lead.isMailReceived ?? false;

  final boardStateAsync = ref.watch(leadProvider);
  final statusName = boardStateAsync.maybeWhen(
    data: (data) => getLeadStatusName(lead.id, data.statuses),
    orElse: () => null,
  );
  final statusIndex = boardStateAsync.maybeWhen(
    data: (data) => getLeadStatusIndex(lead.id, data.statuses),
    orElse: () => null,
  );


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
                  LeadStatusDropdownField(leadId: lead.id),

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
                  initialValue: lead.number ?? '',
                  leadId: lead.id,
                  fieldKey: 'number',
                ),
                EditableTextButton(
                  initialValue: lead.label ?? '',
                  leadId: lead.id,
                  fieldKey: 'label',
                ),
                EditableCheckbox(
                  label: 'Potwierdzony',
                  value: isConfirmed,
                  leadId: lead.id,
                  fieldKey: 'is_number_confirmed',
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
                  initialValue: lead.email ?? '',
                  leadId: lead.id,
                  fieldKey: 'mail',
                ),
                EditableTextButton(
                  initialValue: lead.mailContent ?? '',
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
                  initialValue: lead.receiveMailContent ?? '',
                  leadId: lead.id,
                  fieldKey: 'receive_mail_content',
                ),
                EditableDateField(
                  label: 'Data wysłania',
                  initialDate: lead.mailSentDate,
                  leadId: lead.id,
                  fieldKey: 'mail_sent_date',
                ),
                EditableDateField(
                  label: 'Data odpowiedzi',
                  initialDate: lead.mailResponseDate,
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
                Text('Status: ${statusName ?? "-"}'),
                Text('Indeks statusu: ${statusIndex?.toString() ?? "-"}'),

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
                  initialValue: lead.registerUser?.toString() ?? '',
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
