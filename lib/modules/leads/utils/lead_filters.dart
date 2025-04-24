import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/modules/leads/utils/lead_api.dart';
import 'package:hously_flutter/theme/design/design.dart';


class LeadFilterDialog extends ConsumerStatefulWidget {
  const LeadFilterDialog({super.key});

  @override
  ConsumerState<LeadFilterDialog> createState() => _LeadFilterDialogState();
}

class _LeadFilterDialogState extends ConsumerState<LeadFilterDialog> {
  late Map<String, dynamic> localFilters;
  late String localSearch;
  late Map<String, TextEditingController> textControllers;


@override
void initState() {
  super.initState();
  localFilters = Map.of(ref.read(leadFiltersProvider));
  localSearch = ref.read(leadSearchProvider);

  textControllers = {
    for (var key in ['city', 'address', 'label', 'agreement_status'])
      key: TextEditingController(text: localFilters[key] ?? ''),
    '__search': TextEditingController(text: localSearch),
  };
}


Widget buildTextField(String label, String key, {String? placeholder}) {
  return TextField(
    decoration: InputDecoration(
      labelText: label,
      hintText: placeholder,
      border: const OutlineInputBorder(),
    ),
    controller: textControllers[key],
    onChanged: (value) {
      setState(() {
        localFilters[key] = value;
      });
    },
  );
}


  Widget buildCheckbox(String label, String key) {
    return CheckboxListTile(
      title: Text(label),
      value: localFilters[key] ?? false,
      onChanged: (value) {
        setState(() {
          localFilters[key] = value;
        });
      },
    );
  }

  Widget buildDatePicker(String label, String key) {
    return TextButton.icon(
      icon: const Icon(Icons.calendar_today),
      label: Text(
        localFilters[key] ?? label,
        style: AppTextStyles.interMedium,
      ),
      onPressed: () async {
        final selected = await showDatePicker(
          context: context,
          initialDate: DateTime.tryParse(localFilters[key] ?? '') ?? DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        );
        if (selected != null) {
          setState(() {
            localFilters[key] = selected.toIso8601String().split('T').first;
          });
        }
      },
    );
  }

  @override
void dispose() {
  for (final controller in textControllers.values) {
    controller.dispose();
  }
  super.dispose();
}


  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: SizedBox(
          width: 500,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Filtry leadów', style: AppTextStyles.interSemiBold.copyWith(fontSize: 20)),
              const SizedBox(height: 24),

              /// 🔍 Wyszukiwanie globalne
TextField(
  decoration: const InputDecoration(
    labelText: 'Szukaj (imię, firma, e-mail...)',
    border: OutlineInputBorder(),
  ),
  controller: textControllers['__search'],
  onChanged: (value) {
    setState(() {
      localSearch = value;
    });
  },
),


              const SizedBox(height: 24),
              const Divider(),

              /// 🎯 filterset_fields
              buildTextField('Miasto', 'city'),
              const SizedBox(height: 16),
              buildTextField('Adres', 'address'),
              const SizedBox(height: 16),
              buildTextField('Etykieta (label)', 'label'),
              const SizedBox(height: 16),
              buildTextField('Status umowy', 'agreement_status'),
              const SizedBox(height: 16),

              DropdownButtonFormField<String>(
                value: localFilters['company_type'],
                decoration: const InputDecoration(
                  labelText: 'Typ firmy',
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(value: 'biuro', child: Text('Agencja')),
                  DropdownMenuItem(value: 'deweloper', child: Text('Deweloper')),
                  DropdownMenuItem(value: 'inny', child: Text('Inny')),
                ],
                onChanged: (value) {
                  setState(() {
                    localFilters['company_type'] = value;
                  });
                },
              ),

              const SizedBox(height: 16),
              buildDatePicker('Data wysłania maila', 'mail_sent_date'),

              const SizedBox(height: 16),
              buildCheckbox('Zarejestrowany', 'is_register'),
              buildCheckbox('Wysłano maila', 'is_mail_sent'),
              buildCheckbox('Otrzymano maila', 'is_mail_received'),
              buildCheckbox('Mail zaplanowany', 'is_mail_scheduled'),
              buildCheckbox('Ma umowę', 'has_agreement'),
              buildCheckbox('Zaplanowano spotkanie', 'is_meeting_scheduled'),
              buildCheckbox('Ma działy', 'have_departments'),

              const SizedBox(height: 24),

              /// 🔘 Akcje
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      setState(() {
                        localFilters = {};
                        localSearch = '';
                      });
                    },
                    child: const Text('Wyczyść'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      ref.read(leadFiltersProvider.notifier).state = localFilters;
                      ref.read(leadSearchProvider.notifier).state = textControllers['__search']!.text;
                      Navigator.pop(context);
                    },

                    child: const Text('Zastosuj'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
