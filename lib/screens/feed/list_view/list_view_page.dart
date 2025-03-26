import 'package:flutter/material.dart';
import 'package:hously_flutter/screens/feed/list_view/list_view_mobile_page.dart';
import 'package:hously_flutter/screens/feed/list_view/list_view_pc_page.dart';

class ListViewPage extends StatelessWidget {
  const ListViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth < 1080) {
          return const ListViewMobile(); // Widok dla mniejszych ekranów
        } else {
          return const ListViewWebPc(); // Widok dla większych ekranów
        }
      },
    );
  }
}
