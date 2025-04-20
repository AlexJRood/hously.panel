import 'package:flutter/material.dart';
import 'package:hously_flutter/modules/leads/utils/lead_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/theme/design/design.dart';


class EditableCheckbox extends ConsumerStatefulWidget {
  final String label;
  final bool value;
  final int leadId;
  final String fieldKey;

  const EditableCheckbox({
    super.key,
    required this.label,
    required this.value,
    required this.leadId,
    required this.fieldKey,
  });

  @override
  ConsumerState<EditableCheckbox> createState() => _EditableCheckboxState();
}


class _EditableCheckboxState extends ConsumerState<EditableCheckbox> {
  late bool currentValue;

  @override
  void initState() {
    super.initState();
    currentValue = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('${widget.label}: ', style: AppTextStyles.interMedium),
        Checkbox(
          value: currentValue,
          onChanged: (newValue) async {
            if (newValue == null) return;
            setState(() {
              currentValue = newValue;
            });
            await LeadService.updateLead(
              leadId: widget.leadId,
              ref: ref,
              data: {widget.fieldKey: newValue},
            );
          },
        ),
      ],
    );
  }
}
