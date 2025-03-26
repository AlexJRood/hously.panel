// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:hously_flutter/screens/feed/second_adview/second_pop_full.dart';
//
// class SecondFeedPop extends ConsumerWidget {
//   final dynamic adFeedPop;
//   final String tagFeedPop;
//
//   const SecondFeedPop({
//     super.key,
//     required this.adFeedPop,
//     required this.tagFeedPop,
//   });
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return LayoutBuilder(builder: (context, constraints) {
//       // Sprawdzenie, czy szerokość ekranu jest większa niż 1200 px
//
//       return Row(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Expanded(
//             // Użycie 'widget.adFeedPop' i 'widget.tagFeedPop' do przekazania danych
//             child:
//                 SecondFeedPopFull(adFeedPop: adFeedPop, tagFeedPop: tagFeedPop),
//           ),
//         ],
//       );
//     });
//   }
// }
