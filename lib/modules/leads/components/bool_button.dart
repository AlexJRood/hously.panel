import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BoolTextButton extends StatefulWidget {
  final String initialValue;
  final String patchUrl;
  final String fieldKey;

  const BoolTextButton({
    super.key,
    required this.initialValue,
    required this.patchUrl,
    required this.fieldKey,
  });

  @override
  State<BoolTextButton> createState() => _EditableTextButtonState();
}

class _EditableTextButtonState extends State<BoolTextButton> {
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
        final response = await http.patch(
          Uri.parse(widget.patchUrl),
          headers: {'Content-Type': 'application/json'},
          body: '{"${widget.fieldKey}": "${updatedValue}"}',
        );
        if (response.statusCode == 200) {
          setState(() {
            _value = updatedValue;
          });
        } else {
          // Obsługa błędu np. poprzez pokazanie komunikatu
        }
      } catch (e) {
        // Obsługa błędu połączenia
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isEditing
        ? SizedBox(
            width: 200,
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
              style: TextStyle(
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
