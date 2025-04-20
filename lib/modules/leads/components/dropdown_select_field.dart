import 'package:flutter/material.dart';
import 'package:hously_flutter/modules/leads/utils/lead_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DropdownSelectField extends ConsumerStatefulWidget {
  final String label;
  final String? value;
  final int leadId;
  final String fieldKey;
  final List<String> options;

  const DropdownSelectField({
    super.key,
    required this.label,
    required this.value,
    required this.leadId,
    required this.fieldKey,
    required this.options,
  });

  @override
  ConsumerState<DropdownSelectField> createState() =>
      _DropdownSelectFieldState();
}

class _DropdownSelectFieldState extends ConsumerState<DropdownSelectField> {
  String? selected;

  @override
  void initState() {
    super.initState();
    selected = widget.value;
  }


@override
Widget build(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: SizedBox(
      width: 400,
      height: 70,
      child: DropdownButtonFormField<String>(
        value: selected,
        decoration: InputDecoration(
          labelText: widget.label,
          border: const OutlineInputBorder(),
        ),
        items: widget.options
            .map((opt) => DropdownMenuItem(value: opt, child: Text(opt)))
            .toList(),
        onChanged: (val) async {
          setState(() => selected = val);
          await LeadService.updateLead(
            leadId: widget.leadId,
            ref: ref,
            data: {widget.fieldKey: val},
          );
        },
      ),
    ),
  );
}

}
