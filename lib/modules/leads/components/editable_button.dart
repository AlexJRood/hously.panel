import 'package:flutter/material.dart';
import 'package:hously_flutter/modules/leads/utils/lead_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/theme/design/button_style.dart';
import 'package:hously_flutter/theme/design/design.dart';

class EditableTextButton extends ConsumerStatefulWidget {
  final String initialValue;
  final int leadId;
  final String fieldKey;
  final bool isTitle;
  final bool isCenter;

  const EditableTextButton({
    super.key,
    required this.initialValue,
    required this.leadId,
    required this.fieldKey,
    this.isTitle = false,
    this.isCenter = false,
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
        }
      );

      } catch (e) {
        debugPrint("Błąd podczas aktualizacji: $e");
      }
    }
  }


@override
Widget build(BuildContext context) {
  return _isEditing


      ? Container(
          width: 250,
          height: 50,
          child: TextField(
            controller: _controller,
            focusNode: _focusNode,
            autofocus: true,
            onSubmitted: (_) => _submitIfChanged(),
            style: AppTextStyles.interLight14.copyWith(color: Colors.white),
            cursorColor: Colors.white, // 👈 biały kursor
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColors.dark25,
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.blue),
              ),
            ),
          ),
        )


      : Container(
          width: 250,
          height: 50,
          child: ElevatedButton(
            style: elevatedButtonStyleRounded10,
            onPressed: () {
              setState(() => _isEditing = true);
              _controller.text = _value;
              _focusNode.requestFocus();
            },
            child: Row(
              mainAxisAlignment: widget.isCenter ?  MainAxisAlignment.center : MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _value.isEmpty ? 'EDYTUJ' : _value,
                  style: widget.isTitle ? AppTextStyles.interSemiBold18 : AppTextStyles.interLight14,
                ),
              ],
            )
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
