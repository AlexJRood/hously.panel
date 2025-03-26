import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hously_flutter/const/colors.dart';
import 'package:hously_flutter/const/icons.dart';
import 'package:shimmer/shimmer.dart';

class Carouselloading extends StatelessWidget {
  final double height;

  const Carouselloading({
    super.key,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: 5, // Show 5 shimmer placeholders
      options: CarouselOptions(
        height: height,
        enlargeCenterPage: true,
        aspectRatio: 2.2,
        autoPlay: false,
      ),
      itemBuilder: (context, index, realIndex) {
        return Stack(
          children: [
            ShimmerPlaceholder(width: double.infinity, height: height),
            Positioned(
              left: 10,
              bottom: 3,
              child: Container(
                width: 300,
                height: 75,
                padding: const EdgeInsets.only(top: 15, left: 5),
                decoration: BoxDecoration(
                  color: ShimmerColors.highlight(context),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ShimmerPlaceholder(width: 100, height: 12),
                    SizedBox(height: 10),
                    ShimmerPlaceholder(width: 280, height: 10),
                    SizedBox(height: 8),
                    ShimmerPlaceholder(width: 120, height: 7),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class ShimmerLoadingRow extends StatelessWidget {
  final double itemWidth;
  final double itemHeight;
  final int shimmerItemsCount;
  final Widget placeholderwidget;
  const ShimmerLoadingRow({
    Key? key,
    required this.itemWidth,
    required this.itemHeight,
    required this.placeholderwidget,
    this.shimmerItemsCount = 6, // Default to 6 shimmer items
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          shimmerItemsCount,
          (index) => Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: placeholderwidget,
          ),
        ),
      ),
    );
  }
}

class ShimmerEffectSettingsPhoto extends StatelessWidget {
  const ShimmerEffectSettingsPhoto({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: ShimmerColors.base(context),
      highlightColor: ShimmerColors.highlight(context),
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: ShimmerColors.background(context),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const Expanded(flex: 2, child: SizedBox()),
          Expanded(
            flex: 20,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    height: 10,
                    width: 100,
                    color: ShimmerColors.background(context)),
                const SizedBox(height: 5),
                Container(
                    height: 10,
                    width: 150,
                    color: ShimmerColors.background(context)),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              height: 20,
              width: 20,
            ),
          ),
        ],
      ),
    );
  }
}

class ShimmerPlaceholder extends StatelessWidget {
  final double width;
  final double height;
  final double radius;

  const ShimmerPlaceholder({
    Key? key,
    required this.width,
    required this.height,
    this.radius = 10,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: ShimmerColors.base(context),
      highlightColor: ShimmerColors.highlight(context),
      period: const Duration(seconds: 1),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: ShimmerColors.background(context), // Consistent background
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    );
  }
}

class ShimmerPlaceholdercircle extends StatelessWidget {
  final double radius;

  const ShimmerPlaceholdercircle({
    Key? key,
    required this.radius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: ShimmerColors.base(context),
      highlightColor: ShimmerColors.highlight(context),

      period: const Duration(seconds: 2), // Slower shimmer for smooth effect
      child: CircleAvatar(
        radius: radius, // Use the passed radius for the circle
        backgroundColor: ShimmerColors.background(context),
      ),
    );
  }
}

class ShimmerPlaceholderwithoutwidth extends StatelessWidget {
  final double height;
  final double radius;
  const ShimmerPlaceholderwithoutwidth({
    Key? key,
    required this.height,
    this.radius = 10,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: ShimmerColors.base(context),
      highlightColor: ShimmerColors.highlight(context),
      period: const Duration(seconds: 2), // Slower shimmer for smooth effect
      child: Container(
        height: height,
        decoration: BoxDecoration(
            color: ShimmerColors.background(context),
            borderRadius: BorderRadius.circular(radius)),
      ),
    );
  }
}

class ShimmerPlaceholdermobile extends StatelessWidget {
  const ShimmerPlaceholdermobile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Shimmer.fromColors(
      baseColor: ShimmerColors.base(context),
      highlightColor: ShimmerColors.highlight(context),
      period: const Duration(seconds: 2), // Slower shimmer for smooth effect
      child: Container(
        decoration: BoxDecoration(
            color: colorScheme.onSurface.withOpacity(0.9),
            borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}

class ShimmerAdvertisementlistFull extends StatelessWidget {
  final ScrollController scrollController;

  const ShimmerAdvertisementlistFull({
    super.key,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: scrollController,
      itemCount: 10, // Display a fixed number of shimmer items as placeholders

      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: AspectRatio(
            aspectRatio: 16 / 9,
            child: ClipRRect(
              child: Stack(
                children: [
                  const ShimmerPlaceholder(
                      width: double.infinity, height: double.infinity - 80),
                  Positioned(
                    left: 7,
                    bottom: 7,
                    child: Container(
                      width: 300,
                      height: 75,
                      padding: const EdgeInsets.only(top: 15, left: 5),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ShimmerPlaceholder(width: 100, height: 12),
                          SizedBox(height: 10),
                          ShimmerPlaceholder(width: 280, height: 10),
                          SizedBox(height: 8),
                          ShimmerPlaceholder(width: 120, height: 7),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class ShimmerAdvertisementGrid extends StatelessWidget {
  final ScrollController scrollController;
  final int crossAxisCount; // Number of grid columns
  final ScrollPhysics scrollPhysics;

  const ShimmerAdvertisementGrid({
    super.key,
    required this.scrollController,
    this.crossAxisCount = 1, // Default to 1 for list layout, adjust for grid
    this.scrollPhysics = const BouncingScrollPhysics(),
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: scrollController,
      slivers: [
        SliverGrid(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            childAspectRatio: 1,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return AspectRatio(
                aspectRatio: 1,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Stack(
                    children: [
                      const ShimmerPlaceholder(
                        width: double.infinity,
                        height: double.infinity,
                      ),
                      Positioned(
                        left: 2,
                        bottom: 2,
                        child: Container(
                          width: 300, // Ensure width is full
                          height: 75, // Increase height for visibility
                          padding: const EdgeInsets.only(top: 15, left: 5),
                          decoration: BoxDecoration(
                            color: ShimmerColors.highlight(context),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ShimmerPlaceholder(width: 100, height: 12),
                              SizedBox(height: 10),
                              ShimmerPlaceholder(width: 280, height: 10),
                              SizedBox(height: 8),
                              ShimmerPlaceholder(width: 120, height: 7),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            childCount: 16, // Number of shimmer items as placeholders
          ),
        ),
      ],
    );
  }
}

class ShimmerPlaceholderWithText extends StatelessWidget {
  final double height;
  final double borderRadius;
  final String displayText;

  const ShimmerPlaceholderWithText({
    Key? key,
    this.height = 16.0,
    this.borderRadius = 8.0,
    this.displayText = "Loading...",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Shimmer effect background
        ShimmerPlaceholder(width: double.infinity, height: height),
        // Centered Text
        Text(
          displayText,
          style: const TextStyle(
            color: Colors.red,
            fontSize: 16.0,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class ShimmerAdvertisementsListPc extends StatelessWidget {
  final double adFiledSize;
  final ScrollController scrollController;
  final dynamic dynamicPadding;
  final ScrollPhysics? scrollPhysics;

  const ShimmerAdvertisementsListPc({
    super.key,
    required this.adFiledSize,
    required this.scrollController,
    required this.dynamicPadding,
    this.scrollPhysics,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return ListView.builder(
      physics: scrollPhysics ?? const AlwaysScrollableScrollPhysics(),
      controller: scrollController,
      itemCount: 10,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: AspectRatio(
            aspectRatio: 14 / 4,
            child: Container(
              width: adFiledSize,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: ShimmerColors.highlight(context)),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: AspectRatio(
                      aspectRatio: 16 / 9,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Shimmer.fromColors(
                          baseColor: ShimmerColors.base(context),
                          highlightColor: ShimmerColors.highlight(context),
                          period: const Duration(seconds: 2),
                          child: Container(
                            width: screenWidth * 0.3,
                            height: screenWidth * 0.2,
                            decoration: BoxDecoration(
                                color: ShimmerColors.highlight(context),
                                borderRadius: BorderRadius.circular(4)),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 6,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      child: Container(
                        decoration: BoxDecoration(
                            color: ShimmerColors.highlight(context),
                            borderRadius: BorderRadius.circular(10)),
                        child: const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ShimmerPlaceholder(width: 120, height: 12),
                                SizedBox(height: 6),
                                ShimmerPlaceholder(width: 100, height: 22),
                                SizedBox(height: 10),
                                ShimmerPlaceholder(width: 180, height: 16),
                                SizedBox(height: 6),
                                ShimmerPlaceholder(width: 220, height: 14),
                                SizedBox(height: 10),
                                ShimmerPlaceholder(width: 230, height: 12),
                                SizedBox(height: 6),
                                ShimmerPlaceholder(width: 220, height: 12),
                                SizedBox(height: 6),
                                ShimmerPlaceholder(width: 200, height: 12),
                                SizedBox(height: 6),
                                ShimmerPlaceholder(width: 250, height: 12),
                              ],
                            )),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class ShimmerAdvertisementsListmobile extends StatelessWidget {
  final double adFiledSize;
  final ScrollController scrollController;
  final double dynamicPadding;
  final ScrollPhysics? scrollPhysics;

  const ShimmerAdvertisementsListmobile({
    super.key,
    required this.adFiledSize,
    required this.scrollController,
    required this.dynamicPadding,
    this.scrollPhysics,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: dynamicPadding),
      child: ListView.builder(
        physics: scrollPhysics ?? const AlwaysScrollableScrollPhysics(),
        controller: scrollController,
        itemCount: 10, // Placeholder count
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: AspectRatio(
              aspectRatio: 12 / 4, // Keep the aspect ratio similar to actual
              child: Container(
                width: adFiledSize,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: ShimmerColors.highlight(
                      context), // Background for shimmer effect
                ),
                child: Row(
                  children: [
                    // Left side image shimmer
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: AspectRatio(
                        aspectRatio: 16 / 9,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Shimmer.fromColors(
                            baseColor: ShimmerColors.base(context),
                            highlightColor: ShimmerColors.highlight(context),

                            period: const Duration(
                                seconds: 2), // Slower shimmer for smooth effect
                            child: Container(
                              width: screenWidth * 0.3, // Responsive width
                              height: screenWidth * 0.2,
                              decoration: BoxDecoration(
                                  color: ShimmerColors.highlight(context),
                                  borderRadius: BorderRadius.circular(4)),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 3),

                    // Right side text shimmer
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 5),
                        child: Container(
                          padding: const EdgeInsets.all(7),
                          decoration: BoxDecoration(
                            color: ShimmerColors.highlight(context),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ShimmerBox(
                                width: screenWidth * 0.25,
                                height: 10,
                              ), // City and Street Placeholder
                              const SizedBox(height: 6),
                              ShimmerBox(
                                width: screenWidth * 0.2,
                                height: 14,
                              ), // Price Placeholder
                              const SizedBox(height: 8),
                              ShimmerBox(
                                width: screenWidth * 0.4,
                                height: 12,
                              ), // Title Placeholder
                              const SizedBox(height: 8),

                              // Description Placeholders (multi-line)
                              for (int i = 0; i < 4; i++) ...[
                                ShimmerBox(
                                    width: screenWidth * 0.5, height: 10),
                                const SizedBox(height: 6),
                              ],
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class ShimmerBox extends StatelessWidget {
  final double height;
  final double width;
  const ShimmerBox({super.key, required this.height, required this.width});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: ShimmerColors.base(context),
      highlightColor: ShimmerColors.highlight(context),
      period: const Duration(seconds: 2), // Slower shimmer for smooth effect
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
            color: ShimmerColors.background(context),
            borderRadius: BorderRadius.circular(4)),
      ),
    );
  }
}

class NotificationCardShimmer extends StatelessWidget {
  const NotificationCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      color: Colors.transparent,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Shimmer.fromColors(
            baseColor: ShimmerColors.base(context),
            highlightColor: ShimmerColors.highlight(context),
            child: SvgPicture.asset(AppIcons.notification)),
        title: Shimmer.fromColors(
          baseColor: ShimmerColors.base(context),
          highlightColor: ShimmerColors.highlight(context),
          child: Container(
            height: 16,
            decoration: BoxDecoration(
                color: ShimmerColors.background(context),
                borderRadius: BorderRadius.all(Radius.circular(6))),
          ),
        ),
        subtitle: Shimmer.fromColors(
          baseColor: ShimmerColors.base(context),
          highlightColor: ShimmerColors.highlight(context),
          child: Container(
            margin: const EdgeInsets.only(top: 4),
            height: 14,
            decoration: BoxDecoration(
                color: ShimmerColors.base(context),
                borderRadius: const BorderRadius.all(Radius.circular(6))),
          ),
        ),
        trailing: Shimmer.fromColors(
            baseColor: ShimmerColors.background(context),
            highlightColor: ShimmerColors.highlight(context),
            child: Icon(
              color: ShimmerColors.highlight(context),
              Icons.image_not_supported,
              size: 45,
            )),
      ),
    );
  }
}

class ShimmerColors {
  static Color base(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? Theme.of(context).colorScheme.inverseSurface.withOpacity(0.5)
        : Theme.of(context)
            .colorScheme
            .surfaceContainerHighest
            .withOpacity(0.5);
  }

  static Color highlight(BuildContext context) {
    return Theme.of(context).colorScheme.onSurface.withOpacity(0.2);
  }

  static Color background(BuildContext context) {
    return Theme.of(context).colorScheme.onSurface.withOpacity(0.2);
  }
}
