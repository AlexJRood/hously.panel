import 'package:flutter/material.dart';
import 'package:hously_flutter/screens/filters/new_screens/new_filter_pop_mobile.dart';
import 'package:hously_flutter/screens/filters/new_screens/new_filters_pop_pc.dart';

class NewFilterPopPage extends StatelessWidget {
  const NewFilterPopPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth < 1080) {
          return const NewFilterPopMobile();
        } else {
          return const NewFiltersPopPc();
        }
      },
    );
  }
}
