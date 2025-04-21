import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/modules/leads/utils/lead_api.dart';
import 'package:hously_flutter/modules/leads/utils/lead_model.dart';
import 'package:hously_flutter/theme/design/design.dart';

class LeadNoteField extends ConsumerStatefulWidget {
  final Lead lead;
  final int leadId;

  const LeadNoteField({
    super.key,
    required this.lead,
    required this.leadId,
  });

  @override
  ConsumerState<LeadNoteField> createState() => _LeadNoteFieldState();
}

class _LeadNoteFieldState extends ConsumerState<LeadNoteField> {
  Timer? _debounce;

  void _onNoteChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () async {
      try {
        await LeadService.updateLead(
          leadId: widget.leadId,
          ref: ref,
          data: {'note': value},
        );
      } catch (e) {
        debugPrint('Błąd aktualizacji notatki: $e');
      }
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Text('Notatka:', style: AppTextStyles.interBold),
            const SizedBox(height: 8),
            TextFormField(
              initialValue: widget.lead.note ?? '',
              maxLines: 30,
              style: const TextStyle(color: Colors.white), // kolor tekstu
              decoration: InputDecoration(
                filled: true,
                fillColor: AppColors.dark25,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                hintStyle: const TextStyle(
                    color: Colors.white70), // kolor placeholdera jeśli używasz
              ),
              onChanged: _onNoteChanged,
            ),
          ],
        ),
      ),
    );
  }
}
