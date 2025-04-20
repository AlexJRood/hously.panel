import 'package:flutter/material.dart';
import 'package:hously_flutter/modules/leads/utils/lead_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EditableTextButton extends ConsumerStatefulWidget {
  final String initialValue;
  final int leadId;
  final String fieldKey;

  const EditableTextButton({
    super.key,
    required this.initialValue,
    required this.leadId,
    required this.fieldKey,
  });

  @override
  ConsumerState<EditableTextButton> createState() => _EditableTextButtonState();
}

class _EditableTextButtonState extends ConsumerState<EditableTextButton> {
  late String _value;
  late TextEditingController _controller;
  late FocusNode _focusNode;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _value = widget.initialValue;
    _controller = TextEditingController(text: _value);
    _focusNode = FocusNode();

    _focusNode.addListener(() {
      if (!_focusNode.hasFocus && _isEditing) {
        _submitIfChanged();
      }
    });
  }

  Future<void> _submitIfChanged() async {
    setState(() => _isEditing = false);
    if (_controller.text != _value) {
      final updatedValue = _controller.text;
      try {
        await LeadService.updateLead(
          leadId: widget.leadId,
          ref: ref,
          data: {
            widget.fieldKey: updatedValue,
          },
        );
        setState(() {
          _value = updatedValue;
        });
      } catch (e) {
        debugPrint("Błąd podczas aktualizacji: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isEditing
        ? SizedBox(
      width: 400,
      height: 70,
            child: TextField(
              controller: _controller,
              focusNode: _focusNode,
              autofocus: true,
              onSubmitted: (_) => _submitIfChanged(),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
          )
        : InkWell(
            onTap: () {
              setState(() => _isEditing = true);
              _controller.text = _value;
              _focusNode.requestFocus();
            },
            child: Text(
              _value.isEmpty ? '[Kliknij aby edytować]' : _value,
              style: const TextStyle(
                color: Colors.blue,
                decoration: TextDecoration.underline,
              ),
            ),
          );
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }
}
