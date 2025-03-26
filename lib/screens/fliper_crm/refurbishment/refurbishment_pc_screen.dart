import 'package:flutter/material.dart';
import 'package:hously_flutter/screens/fliper_crm/refurbishment/widget/gantt_chart_widget.dart';
import 'package:hously_flutter/screens/fliper_crm/selection_and_negotiations/widgets/flipper_custom_list_view.dart';

class RefurbishmentPcScreen extends StatelessWidget {
  const RefurbishmentPcScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 160.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 40,
        children: [
          FlipperCustomListView(title: '', itemCount: 10, id: 6),
          Expanded(child: GanttChartWidget()),
        ],
      ),
    );
  }
}



