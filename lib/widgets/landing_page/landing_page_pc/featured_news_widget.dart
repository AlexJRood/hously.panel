import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:hously_flutter/const/route_constant.dart';
import 'package:hously_flutter/state_managers/services/navigation_service.dart';
import 'package:hously_flutter/utils/pie_menu/feed.dart';
import 'package:pie_menu/pie_menu.dart';

import '../../../state_managers/data/home_page/listing_provider.dart';
import '../../../theme/apptheme.dart';
import '../../loading/loading_widgets.dart';

class FeaturedNewsWidget extends ConsumerWidget {
  final double paddingDynamic;
  final bool isMobile;
  const FeaturedNewsWidget({super.key,required this.paddingDynamic,this.isMobile =false});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final recentlyViewedAdsAsyncValue = ref.watch(listingsProvider);
    final dynamicVerticalPadding = paddingDynamic / 3;
    final scrollController = ScrollController();

    return Padding(
      padding:  EdgeInsets.symmetric(vertical: dynamicVerticalPadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
           Padding(
            padding: EdgeInsets.symmetric(horizontal: paddingDynamic),
            child:  Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Expanded(
                  child: Text(
                    'Featured News & Insights for New Homes',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(35, 35, 35, 1)),
                  ),
                ),
                if(!isMobile)
                const Row(
                  children: [
                    Text(
                      'Read all articles ',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color.fromRGBO(35, 35, 35, 1)),
                    ),
                    Icon(Icons.arrow_forward,
                      color: Color.fromRGBO(35, 35, 35, 1),
      
                    ),
                  ],
                )
              ],
            ),
          ),
          const SizedBox(height: 30),
          SizedBox(
            height: 500,
            child: ListView.separated(
              controller: scrollController,
              separatorBuilder: (context, index) => const SizedBox(width: 30,),
              itemCount: 10,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index){
                if (index == 0) {
                  // Pierwszy element listy - dynamiczny padding
                  return SizedBox(width: paddingDynamic);
                }
                final data = recentlyViewedAdsAsyncValue.value?[index - 1];
                final tag = 'recentlyViewed3-${data?.id}';
               return GestureDetector(
                 onHorizontalDragUpdate: (details) {
                   scrollController.jumpTo(
                     scrollController.offset - details.delta.dx,
                   );
                 },
                 child: PieMenu(
                   onPressedWithDevice: (kind) {
                     if (kind == PointerDeviceKind.mouse ||
                         kind == PointerDeviceKind.touch) {
                       ref.read(navigationService).pushNamedScreen(
                         '${Routes.homepage}/${data?.id}',
                         data: {'tag': tag, 'ad': data},
                       );
                     }
                   },
                   actions: buildPieMenuActions(ref, data, context),
                   child: Hero(
                     tag: tag,
                     child: ArticleCardWidget(
                      imageUrl:'${data?.images.last}', // Replace with your image URL
                      title: '${data?.title}',
                      description:
                      '${data?.description}',
                       readMoreUrl: '#',
                       ref: ref,
                                   ),
                   ),
                 ),
               );}
            ),
          )
        ],
      ),
    );
  }
}
class ArticleCardWidget extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;
  final String readMoreUrl;
  final WidgetRef ref;

  const ArticleCardWidget({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.readMoreUrl,
    required this.ref
  });

  @override
  Widget build(BuildContext context) {
    final themecolors = ref.watch(themeColorsProvider);
    final textColor = themecolors.themeTextColor;
    return Container(
      width: 260,
      height: 433,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: CachedNetworkImage(
              height: 260,
              imageUrl: imageUrl,
              fit: BoxFit.cover,
              placeholder: (context, url) =>
              const ShimmerPlaceholder(
                  width: 0, height: 0),
              errorWidget: (context, url, error) =>
                  Container(
                    color: Colors.grey,
                    alignment: Alignment.center,
                    child: Text(
                      'Brak obrazu'.tr,
                      style: TextStyle(color: textColor),
                    ),
                  ),
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Text(
              description,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black54,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: InkWell(
              onTap: () {
                // Handle "Read more" tap
              },
              child: const Text(
                'Read more',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.blue,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
