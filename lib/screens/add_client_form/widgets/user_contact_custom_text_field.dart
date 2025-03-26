import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Riverpod Provider for managing text field focus states
final textFieldFocusProvider =
StateNotifierProvider<TextFieldFocusNotifier, Map<int, bool>>(
      (ref) => TextFieldFocusNotifier(),
);

class TextFieldFocusNotifier extends StateNotifier<Map<int, bool>> {
  TextFieldFocusNotifier() : super({});

  void setFocus(int id, bool isFocused) {
    state = {...state, id: isFocused};
  }
}

/// Custom TextField with Riverpod State Management
class UserContactCustomTextField extends ConsumerStatefulWidget {
  final int id;
  final String hintText;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final int maxLines;
  final void Function(String) onChanged;

  const UserContactCustomTextField({
    super.key,
    required this.id,
    required this.hintText,
    required this.controller,
    this.validator,
    this.onSaved,
    this.maxLines = 1,
    required this.onChanged, // Corrected parameter
  });

  @override
  ConsumerState<UserContactCustomTextField> createState() =>
      _UserContactCustomTextFieldState();
}

class _UserContactCustomTextFieldState
    extends ConsumerState<UserContactCustomTextField> {
  late FocusNode focusNode;

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();

    focusNode.addListener(() {
      if (mounted) {
        ref
            .read(textFieldFocusProvider.notifier)
            .setFocus(widget.id, focusNode.hasFocus);
      }
    });
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isFocused = ref.watch(textFieldFocusProvider)[widget.id] ?? false;

    return GestureDetector(
      onTap: () {
        focusNode.requestFocus();
      },
      child: TextFormField(
        onChanged: widget.onChanged, // ✅ Correctly implemented
        maxLines: widget.maxLines,
        controller: widget.controller,
        focusNode: focusNode,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          filled: true,
          fillColor:
          isFocused ? Colors.transparent : const Color.fromRGBO(35, 35, 35, 1),
          hintText: widget.hintText,
          hintStyle: const TextStyle(
            color: Color.fromRGBO(145, 145, 145, 1),
            fontSize: 12,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6.0),
            borderSide: const BorderSide(color: Color.fromRGBO(35, 35, 35, 1)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: const BorderSide(color: Color.fromRGBO(35, 35, 35, 1)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6.0),
            borderSide: const BorderSide(color: Color.fromRGBO(200, 200, 200, 1)),
          ),
        ),
        cursorColor: Colors.white,
        validator: widget.validator,
        onSaved: widget.onSaved,
      ),
    );
  }
}
