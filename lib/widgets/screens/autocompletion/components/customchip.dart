import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/theme/apptheme.dart';

class Customchip extends ConsumerStatefulWidget {
  final String country;
  final VoidCallback onRemove;

  const Customchip({super.key, required this.country, required this.onRemove});

  @override
  _CustomchipState createState() => _CustomchipState();
}

class _CustomchipState extends ConsumerState<Customchip> {
  var _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(themeColorsProvider);
    return Padding(
      padding: const EdgeInsets.only(top: 8, left: 8),
      child: MouseRegion(
        onEnter: (_) {
          setState(() {
            _isHovered = true;
          });
        },
        onExit: (_) {
          setState(() {
            _isHovered = false;
          });
        },
        child: Chip(
          color: WidgetStatePropertyAll(theme.fillColor),
          label: Text(
            widget.country,
            style: TextStyle(fontSize: 15, color: theme.textFieldColor),
          ),
          deleteIcon: Icon(
            Icons.close,
            size: 18,
            color: _isHovered
                ? theme.textFieldColor
                : theme.textFieldColor.withOpacity(0.6),
          ),
          onDeleted: widget.onRemove,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(
                color: _isHovered
                    ? theme.textFieldColor
                    : theme.textFieldColor.withOpacity(0.1),
                width: 2),
          ),
        ),
      ),
    );
  }
}
