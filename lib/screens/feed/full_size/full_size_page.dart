import 'package:flutter/material.dart';
import 'package:hously_flutter/screens/feed/full_size/full_size_mobile.dart';
import 'package:hously_flutter/screens/feed/full_size/full_size_pc.dart';

class FullSizePage extends StatelessWidget {
  const FullSizePage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth < 1080) {
          return const FullMobile(); // Widok dla mniejszych ekranów
        } else {
          return const FullSizePc(); // Widok dla większych ekranów
        }
      },
    );
  }
}
