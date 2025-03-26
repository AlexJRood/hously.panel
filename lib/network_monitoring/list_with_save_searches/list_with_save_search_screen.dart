import 'package:flutter/material.dart';

import 'list_with_save_search_mobile.dart';
import 'list_with_save_search_pc.dart';

class ListWithSaveSearchScreen extends StatelessWidget {
  const ListWithSaveSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth > 1080) {
          return const ListWithSaveSearchesPc();
        } else {
          return  const ListWithSaveSearchMobile();
        }
      },
    );
  }
}
