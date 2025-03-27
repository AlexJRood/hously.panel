import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:hously_flutter/routing/route_constant.dart';

import 'package:hously_flutter/theme/apptheme.dart';
import 'package:hously_flutter/theme/design/design.dart';
import 'package:hously_flutter/modules/articles_managment/provider/article_provider.dart';
import 'package:hously_flutter/routing/navigation_service.dart';
import 'package:hously_flutter/utils/loading_widgets.dart';
import 'package:pie_menu/pie_menu.dart';

class ArticlesHomepage extends ConsumerWidget {
  const ArticlesHomepage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final articlesAsyncValue = ref.watch(articleProvider);
    double screenHeight = MediaQuery.of(context).size.height;
    const double maxHeight = 1080;
    const double minHeight = 300;
    const double maxDynamicPadding = 40;
    const double minDynamicPadding = 5;
    double dynamicPadding = (screenHeight - minHeight) /
            (maxHeight - minHeight) *
            (maxDynamicPadding - minDynamicPadding) +
        minDynamicPadding;
    dynamicPadding = dynamicPadding.clamp(minDynamicPadding, maxDynamicPadding);

    double articleHeight = screenHeight / 2;
    double articleWidth = articleHeight * 0.8;
    final themecolors = ref.watch(themeColorsProvider);

    final textColor = themecolors.themeTextColor;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text('Artykuły'.tr,
              style: AppTextStyles.interSemiBold18.copyWith(color: textColor)),
        ),
        const SizedBox(height: 20),
        articlesAsyncValue.when(
          data: (articles) => SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            child: Row(
              children: articles.map((articles) {
                final tagArticlesPop = 'articles12331${articles.id}';
                return PieMenu(
                  onPressedWithDevice: (kind) {
                    if (kind == PointerDeviceKind.mouse ||
                        kind == PointerDeviceKind.touch) {
                      ref.read(navigationService).pushNamedScreen(
                        Routes.articlePop,
                        data: {
                          'articles': articles,
                          'tagArticlesPop': tagArticlesPop,
                        },
                      );
                    }
                  },
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Hero(
                          tag: tagArticlesPop,
                          child: Container(
                            height: articleHeight,
                            width: articleWidth,
                            child: CachedNetworkImage(
                              imageUrl: articles.thumbnailUrl,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => ShimmerPlaceholder(
                                  width: articleWidth, height: articleHeight),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: articleWidth,
                        child: Column(
                          children: [
                            const SizedBox(height: 20),
                            Text(articles.title,
                                style: AppTextStyles.interSemiBold18,
                                maxLines: 4),
                            const SizedBox(height: 15),
                            Text(articles.body,
                                style: AppTextStyles.interLight, maxLines: 5),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
          error: (err, _) => const Stack(
            children: [
              // Shimmer placeholder as the background
              Positioned.fill(
                child: ShimmerPlaceholder(
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
              // Centered "No article found" message
              Center(
                child: Text(
                  "No article found",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
              ),
            ],
          ),
          loading: () => SingleChildScrollView(scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(
                5, 
                (index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    children: [
                      ShimmerPlaceholder(
                        width: articleWidth,
                        height: articleHeight,
                      ),
                      SizedBox(
                        width: articleWidth,
                        child: Column(
                          children: [
                            const SizedBox(height: 20),
                            ShimmerPlaceholder(
                              width: articleWidth *
                                  0.8, // Adjust width for text placeholder
                              height: 20, // Height for title shimmer
                            ),
                            const SizedBox(height: 15),
                            ShimmerPlaceholder(
                              width: articleWidth *
                                  0.9, // Adjust width for body text
                              height: 15, // Height for body shimmer
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
