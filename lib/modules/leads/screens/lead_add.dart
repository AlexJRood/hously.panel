import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/modules/leads/components/date_picker.dart';
import 'package:hously_flutter/modules/leads/utils/lead_api.dart';
import 'package:hously_flutter/modules/leads/utils/lead_controlers.dart';
import 'package:hously_flutter/theme/design/design.dart';
import 'package:hously_flutter/widgets/bars/bar_manager.dart';
import 'package:hously_flutter/widgets/side_menu/slide_rotate_menu.dart';

class AddLeadPage extends ConsumerStatefulWidget {
  const AddLeadPage({super.key});

  @override
  ConsumerState<AddLeadPage> createState() => _AddLeadPageState();
}

class _AddLeadPageState extends ConsumerState<AddLeadPage> {
  final formKey = GlobalKey<FormState>();
  final LeadFormControllers form = LeadFormControllers();

  @override
  void dispose() {
    form.dispose();
    super.dispose();
  }

  Future<void> saveLead() async {
    if (!formKey.currentState!.validate()) return;

    final payload = {
      'name': form.nameController.text,
      'company_name': form.companyNameController.text,
      'note': form.noteController.text,
      'phones': form.phoneControllers
          .map((p) => {
                'number': p.number.text,
                'label': p.label.text,
                'is_primary': p.isPrimary,
              })
          .toList(),
      'emails': form.emailControllers
          .map((e) => {
                'mail_content': e.mailContent.text,
                'is_mail_sent': e.isMailSent,
                'mail_sent_date':
                    e.mailSentDate.text.isEmpty ? null : e.mailSentDate.text,
                'is_mail_received': e.isMailReceived,
                'receive_mail_content': e.receiveMailContent.text,
                'mail_response_date': e.mailResponseDate.text.isEmpty
                    ? null
                    : e.mailResponseDate.text,
              })
          .toList(),
      'interactions': form.interactionControllers.map((i) {
        final type = i.interactionType.text.trim();
        const validTypes = [
          'note',
          'email_sent',
          'email_received',
          'call',
          'status_change',
          'link_opened',
          'agreement',
          'custom',
        ];
        return {
          'interaction_type': validTypes.contains(type) ? type : 'custom',
          'content': i.content.text,
        };
      }).toList(),
      'agreement': {
        'has_agreement': form.agreementController.hasAgreement ?? false,
        'agreement_status': form.agreementController.agreementStatus.text,
        'is_meeting_scheduled':
            form.agreementController.isMeetingScheduled ?? false,
      },
      'register': {
        'is_register': form.registerController.isRegister,
        'register_user':
            int.tryParse(form.registerController.registerUser.text),
      },
      'status': {
        'id': int.tryParse(form.statusController.statusId.text),
        'status_name': form.statusController.statusName.text,
        'status_index': int.tryParse(form.statusController.statusIndex.text),
      },
    };

    try {
      await LeadService.createLead(ref: ref, data: payload);
      if (context.mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Lead został dodany')),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Błąd przy dodawaniu: $e')),
        );
      }
    }
  }

  final sideMenuKey = GlobalKey<SideMenuState>();

  @override
  Widget build(BuildContext context) {
    return BarManager(
      sideMenuKey: sideMenuKey,
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
                key: formKey,
                child: Column(
                  spacing: 10,
                  children: [
                    // Imię, firma, notatka
                    TextFormField(
                      controller: form.nameController,
                      decoration: const InputDecoration(labelText: 'Imię'),
                      validator: (v) =>
                          v == null || v.isEmpty ? 'Wymagane' : null,
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: form.companyNameController,
                      decoration: const InputDecoration(labelText: 'Firma'),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: form.noteController,
                      decoration: const InputDecoration(labelText: 'Notatka'),
                      maxLines: 4,
                    ),

                    const Divider(height: 32),
                    Text('Telefony', style: AppTextStyles.interMedium18),
                    for (var phone in form.phoneControllers)
                      Column(
                        spacing: 20,
                        children: [
                          TextFormField(
                            controller: phone.number,
                            decoration: const InputDecoration(
                                labelText: 'Numer telefonu'),
                          ),
                          TextFormField(
                            controller: phone.label,
                            decoration:
                                const InputDecoration(labelText: 'Etykieta'),
                          ),
                          SwitchListTile(
                            title: Text('Główny numer',
                                style: AppTextStyles.interSemiBold),
                            value: phone.isPrimary,
                            onChanged: (val) {
                              setState(() => phone.isPrimary = val);
                            },
                          ),
                        ],
                      ),

                    const Divider(height: 32),
                    Text('E-maile', style: AppTextStyles.interMedium18),
                    for (var email in form.emailControllers)
                      Column(
                        spacing: 20,
                        children: [
                          TextFormField(
                            controller: email.mailContent,
                            decoration:
                                const InputDecoration(labelText: 'Treść maila'),
                          ),
                          DatePickerTextField(
                            controller: email.mailSentDate,
                            label: 'Data wysłania',
                          ),
                          SwitchListTile(
                            title: Text('Wysłano',
                                style: AppTextStyles.interSemiBold),
                            value: email.isMailSent,
                            onChanged: (val) {
                              setState(() => email.isMailSent = val);
                            },
                          ),
                          TextFormField(
                            controller: email.receiveMailContent,
                            decoration: const InputDecoration(
                                labelText: 'Treść odpowiedzi'),
                          ),
                          DatePickerTextField(
                            controller: email.mailResponseDate,
                            label: 'Data odpowiedzi',
                          ),
                          SwitchListTile(
                            title: Text('Odebrano',
                                style: AppTextStyles.interSemiBold),
                            value: email.isMailReceived,
                            onChanged: (val) {
                              setState(() => email.isMailReceived = val);
                            },
                          ),
                          const Divider(),
                        ],
                      ),

                    const Divider(height: 32),
                    Text('Interakcje', style: AppTextStyles.interMedium18),
                    for (var interaction in form.interactionControllers)
                      Column(
                        spacing: 20,
                        children: [
                          TextFormField(
                            controller: interaction.interactionType,
                            decoration: const InputDecoration(
                                labelText: 'Typ interakcji'),
                          ),
                          TextFormField(
                            controller: interaction.content,
                            decoration:
                                const InputDecoration(labelText: 'Treść'),
                          ),
                          const Divider(),
                        ],
                      ),

                    const Divider(height: 32),
                    Text('Status', style: AppTextStyles.interMedium18),
                    TextFormField(
                      controller: form.statusController.statusId,
                      decoration:
                          const InputDecoration(labelText: 'ID statusu'),
                    ),
                    TextFormField(
                      controller: form.statusController.statusName,
                      decoration:
                          const InputDecoration(labelText: 'Nazwa statusu'),
                    ),
                    TextFormField(
                      controller: form.statusController.statusIndex,
                      decoration:
                          const InputDecoration(labelText: 'Index statusu'),
                    ),

                    const Divider(height: 32),
                    Text('Umowa', style: AppTextStyles.interMedium18),
                    SwitchListTile(
                      title: Text('Czy jest umowa?',
                          style: AppTextStyles.interSemiBold),
                      value: form.agreementController.hasAgreement ?? false,
                      onChanged: (val) {
                        setState(
                            () => form.agreementController.hasAgreement = val);
                      },
                    ),
                    TextFormField(
                      controller: form.agreementController.agreementStatus,
                      decoration:
                          const InputDecoration(labelText: 'Status umowy'),
                    ),
                    SwitchListTile(
                      title: Text('Zaplanowano spotkanie',
                          style: AppTextStyles.interSemiBold),
                      value:
                          form.agreementController.isMeetingScheduled ?? false,
                      onChanged: (val) {
                        setState(() =>
                            form.agreementController.isMeetingScheduled = val);
                      },
                    ),

                    const Divider(height: 32),
                    Text('Rejestracja', style: AppTextStyles.interMedium18),
                    SwitchListTile(
                      title: Text('Zarejestrowany?',
                          style: AppTextStyles.interSemiBold),
                      value: form.registerController.isRegister,
                      onChanged: (val) {
                        setState(
                            () => form.registerController.isRegister = val);
                      },
                    ),
                    TextFormField(
                      controller: form.registerController.registerUser,
                      decoration: const InputDecoration(
                          labelText: 'ID użytkownika rejestracji'),
                    ),

                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: saveLead,
                      child: const Text('Zapisz'),
                    ),
                  ],
                )),
          ),
        ),
      ],
    );
  }
}
