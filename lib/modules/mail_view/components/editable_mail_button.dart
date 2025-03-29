import 'package:flutter/material.dart';


class EditableEmailField extends StatefulWidget {
  final TextEditingController controller;

  const EditableEmailField({super.key, required this.controller});

  @override
  State<EditableEmailField> createState() => _EditableEmailFieldState();
}

class _EditableEmailFieldState extends State<EditableEmailField> {
  bool _isEditing = false;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();

    _focusNode.addListener(() {
      if (!_focusNode.hasFocus && _isEditing) {
        setState(() => _isEditing = false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isEditing
        ? SizedBox(
            width: 300,
            child: TextField(
              controller: widget.controller,
              focusNode: _focusNode,
              autofocus: true,
              keyboardType: TextInputType.emailAddress,
              onSubmitted: (_) => setState(() => _isEditing = false),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Adres e-mail',
              ),
            ),
          )
        : InkWell(
            onTap: () {
              setState(() => _isEditing = true);
              _focusNode.requestFocus();
            },
            child: Text(
              widget.controller.text.isEmpty
                  ? '[Kliknij aby dodać e-mail]'
                  : widget.controller.text,
              style: const TextStyle(
                color: Colors.blue,
                decoration: TextDecoration.underline,
              ),
            ),
          );
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }
}
