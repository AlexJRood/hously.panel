// // lib/providers/ad_provider.dart
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:hously_flutter/data/design/design.dart';
// import 'package:hously_flutter/models/ad/ad_list_view_model.dart';
//
// import 'package:hously_flutter/const/url.dart';
// import 'package:hously_flutter/screens/feed/second_adview/second_adview.dart';
// import 'package:hously_flutter/utils/api_services.dart';
//
// const configUrl = URLs.baseUrl;
//
// final adProvider =
//     FutureProvider.family<AdsListViewModel, int>((ref, adId) async {
//   final response = await ApiServices.get(
//     ref: ref,
//     '${URLs.apiAdvertisements}$adId',
//   );
//
//   if (response != null && response.statusCode == 200) {
//     return AdsListViewModel.fromJson(response.data as Map<String, dynamic>);
//   } else {
//     throw Exception('Failed to load advertisement');
//   }
// });
//
// class SeconadFetcher extends ConsumerWidget {
//   final int feedAdId;
//   final String tag;
//
//   const SeconadFetcher({required this.feedAdId, required this.tag, super.key});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final adAsyncValue = ref.watch(adProvider(feedAdId));
//
//     return adAsyncValue.when(
//       data: (ad) {
//         return SecondFeedPop(adFeedPop: ad, tagFeedPop: tag);
//       },
//       loading: () => const Scaffold(
//         body: Center(
//           child: CircularProgressIndicator(
//             color: AppColors.light,
//             strokeWidth: 2,
//           ),
//         ),
//       ),
//       error: (error, stack) => Scaffold(
//         body: Center(child: Text('Error: $error')),
//       ),
//     );
//   }
// }
