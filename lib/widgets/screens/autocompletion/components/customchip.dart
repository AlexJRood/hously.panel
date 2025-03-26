import 'package:flutter/material.dart';

class Customchip extends StatefulWidget {
  final String country;
  final VoidCallback onRemove;

  const Customchip({super.key, required this.country, required this.onRemove});

  @override
  _CustomchipState createState() => _CustomchipState();
}

class _CustomchipState extends State<Customchip> {
  var _isHovered = false;

  @override
  Widget build(BuildContext context) {
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
          label: Text(
            widget.country,
          ),
          deleteIcon: Icon(
            Icons.close,
            size: 18,
            color: _isHovered ? Colors.black : Colors.grey,
          ),
          onDeleted: widget.onRemove,
          backgroundColor: Colors.grey[200],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(
                color: _isHovered ? Colors.black : Colors.black12, width: 2),
          ),
        ),
      ),
    );
  }
}
