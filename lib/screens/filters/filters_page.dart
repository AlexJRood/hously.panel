import 'package:flutter/material.dart';
import 'package:hously_flutter/screens/filters/filters_page_pop_mobile.dart';
import 'package:hously_flutter/screens/filters/filters_page_pop_pc.dart';

class FiltersPage extends StatelessWidget {
  final tag;
  const FiltersPage({super.key, required this.tag});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth < 1080) {
          return const FiltersPagePopMobile();
        } else {
          return FiltersPagePopPc(tag: tag);
        }
      },
    );
  }
}
