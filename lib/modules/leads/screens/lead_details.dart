import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/modules/leads/components/editable_button.dart';
import 'package:hously_flutter/modules/leads/utils/lead_api.dart';
import 'package:hously_flutter/modules/leads/utils/lead_model.dart';
import 'package:hously_flutter/modules/leads/widgets/pc.dart';
import 'package:hously_flutter/theme/design/button_style.dart';
import 'package:hously_flutter/theme/design/design.dart';
import 'package:hously_flutter/widgets/bars/bar_manager.dart';
import 'package:hously_flutter/widgets/side_menu/slide_rotate_menu.dart';

import 'package:hously_flutter/routing/route_constant.dart';
import 'package:hously_flutter/routing/navigation_service.dart';

final patchApi = 'https://hously.cloud';

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
                      : mobileLeadDetails(context, lead);
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

  void _showEditDialog(
    BuildContext context, {
    required String initialValue,
    required String label,
    required Function(String) onSave,
  }) {
    final controller = TextEditingController(text: initialValue);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edytuj $label'),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(labelText: label),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Anuluj'),
          ),
          ElevatedButton(
            onPressed: () {
              onSave(controller.text);
              Navigator.pop(context);
            },
            child: const Text('Zapisz'),
          ),
        ],
      ),
    );
  }

  Widget pcLeadDetails(BuildContext context, Lead lead, WidgetRef ref) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // LEWA KOLUMNA – dane leada
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
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
                if (lead.status != null)
                  Text('Status: ${lead.status!.statusName}',
                      style: AppTextStyles.interMedium),
                const SizedBox(height: 16),
                Row(
                  spacing: 20,
                  children: [
                    Container(width: 80, height: 80, color: AppColors.light),
                    Expanded(
                      child: Column(
                        spacing: 10,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          EditableTextButton(
                            initialValue: lead.name,
                            patchUrl: patchApi,
                            fieldKey: 'name',
                          ),
                          EditableTextButton(
                            initialValue: lead.companyName ?? '',
                            patchUrl: patchApi,
                            fieldKey: 'company',
                          ),
                          EditableTextButton(
                            initialValue: lead.phones?.number ?? '',
                            patchUrl: patchApi,
                            fieldKey: 'number',
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        _showEditDialog(
                          context,
                          initialValue: lead.name,
                          label: 'Imię',
                          onSave: (value) {
                            // TODO: zapisz imię
                          },
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                if (lead.agreement != null)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ElevatedButton(
                        style: elevatedButtonStyleRounded10,
                        onPressed: () {
                          LeadService.updateLead(ref: ref, leadId: leadId, data: data)
                        },
                        child: Text('Umowa:', style: AppTextStyles.interBold),
                      ),
                      ElevatedButton(
                        style: elevatedButtonStyleRounded10,
                        onPressed: () {},
                        child: Text(
                            'Ma umowę: ${lead.agreement!.hasAgreement == true ? "Tak" : "Nie"}'),
                      ),
                      if (lead.agreement!.agreementStatus != null)
                        ElevatedButton(
                          style: elevatedButtonStyleRounded10,
                          onPressed: () {},
                          child: Text(
                              'Status: ${lead.agreement!.agreementStatus}'),
                        ),
                      ElevatedButton(
                        style: elevatedButtonStyleRounded10,
                        onPressed: () {},
                        child: Text(
                            'Spotkanie: ${lead.agreement!.isMeetingScheduled == true ? "Zaplanowane" : "Nie"}'),
                      ),
                    ],
                  ),
                const SizedBox(height: 16),
                if (lead.register != null)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Rejestracja:', style: AppTextStyles.interBold),
                      Text(
                          'Zarejestrowany: ${lead.register!.isRegister ? "Tak" : "Nie"}'),
                      if (lead.register!.registerUser != null)
                        Text('Użytkownik ID: ${lead.register!.registerUser}'),
                    ],
                  ),
                if (lead.register == null)
                  ElevatedButton(
                    style: elevatedButtonStyleRounded10,
                    onPressed: () {},
                    child: Text('Utwórz konto dla uytkownika'),
                  ),
              ],
            ),
          ),
        ),

        // PRAWA KOLUMNA – notatka i interakcje
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('Notatka:', style: AppTextStyles.interBold),
                const SizedBox(height: 8),
                TextFormField(
                  initialValue: lead.note ?? '',
                  maxLines: 10,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColors.dark25,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onChanged: (value) {
                    // TODO: Zapisz notatkę
                  },
                ),
              ],
            ),
          ),
        ),

        // Interakcje
        LeadInteractionsPcWidget(
          isWhiteSpaceNeeded: false,
          lead: lead,
        ),
      ],
    );
  }

  Widget mobileLeadDetails(BuildContext context, Lead lead) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // LEWA KOLUMNA – dane leada
        Expanded(
          flex: 2,
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
                      child: Text('Imię: ${lead.name}',
                          style: AppTextStyles.interBold),
                    ),
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        _showEditDialog(
                          context,
                          initialValue: lead.name,
                          label: 'Imię',
                          onSave: (value) {
                            // TODO: Zapisz imię
                          },
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                if (lead.companyName != null)
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Firma: ${lead.companyName}',
                          style: AppTextStyles.interMedium,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          _showEditDialog(
                            context,
                            initialValue: lead.companyName!,
                            label: 'Firma',
                            onSave: (value) {
                              // TODO: Zapisz firmę
                            },
                          );
                        },
                      ),
                    ],
                  ),
                const SizedBox(height: 24),
                Text('Interakcje:', style: AppTextStyles.interBold),
              ],
            ),
          ),
        ),

        // PRAWA KOLUMNA – notatka i interakcje
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('Notatka:', style: AppTextStyles.interBold),
                const SizedBox(height: 8),
                TextFormField(
                  initialValue: lead.note ?? '',
                  maxLines: 10,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColors.dark25,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onChanged: (value) {
                    // TODO: Zapisz notatkę
                  },
                ),
              ],
            ),
          ),
        ),

        // Interakcje
        LeadInteractionsPcWidget(
          isWhiteSpaceNeeded: false,
          lead: lead,
        ),
      ],
    );
  }
}
