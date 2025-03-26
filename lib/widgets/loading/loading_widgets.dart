import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hously_flutter/const/colors.dart';
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
      baseColor: Colors.grey[300]!,
      highlightColor: const Color.fromARGB(255, 50, 50, 50),
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: Colors.grey[300],
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
                Container(height: 10, width: 100, color: Colors.grey[300]),
                const SizedBox(height: 5),
                Container(height: 10, width: 150, color: Colors.grey[300]),
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
      baseColor: const Color.fromARGB(
          255, 50, 50, 50), // Lighter base color for realism
      highlightColor: Colors.grey[300]!, // Softer highlight color
      period: const Duration(seconds: 2), // Slower shimmer for smooth effect
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
            color: Colors.grey, borderRadius: BorderRadius.circular(radius)),
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
      baseColor: const Color.fromARGB(
          255, 50, 50, 50), // Lighter base color for realism
      highlightColor: Colors.grey[300]!, // Softer highlight color
      period: const Duration(seconds: 2), // Slower shimmer for smooth effect
      child: CircleAvatar(
        radius: radius, // Use the passed radius for the circle
        backgroundColor: shimmercolor,
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
      baseColor: const Color.fromARGB(
          255, 50, 50, 50), // Lighter base color for realism
      highlightColor: Colors.grey[300]!, // Softer highlight color
      period: const Duration(seconds: 2), // Slower shimmer for smooth effect
      child: Container(
        height: height,
        decoration: BoxDecoration(
            color: Colors.grey, borderRadius: BorderRadius.circular(radius)),
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
    return Shimmer.fromColors(
      baseColor: const Color.fromARGB(
          255, 50, 50, 50), // Lighter base color for realism
      highlightColor: Colors.grey[300]!, // Softer highlight color
      period: const Duration(seconds: 2), // Slower shimmer for smooth effect
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey, borderRadius: BorderRadius.circular(10)),
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
    return ListView.builder(
      physics: scrollPhysics ?? const AlwaysScrollableScrollPhysics(),
      controller: scrollController,
      itemCount: 10, // Placeholder count
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: AspectRatio(
            aspectRatio: 14 / 4, // Match real aspect ratio
            child: Container(
              width: adFiledSize,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color.fromARGB(255, 50, 50, 50),
              ),
              child: Row(
                children: [
                  // Left side image shimmer
                  AspectRatio(
                    aspectRatio: 16 / 9,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: const ShimmerPlaceholdermobile(),
                    ),
                  ),
                  const SizedBox(width: 10), // More realistic spacing
                  // Right side shimmer content
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(10)),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // City and Street Placeholder
                              ShimmerPlaceholder(width: 140, height: 10),
                              SizedBox(height: 4),
                              // Price Placeholder (Match Font Size)
                              ShimmerPlaceholder(width: 110, height: 20),
                              SizedBox(height: 8),
                              // Title Placeholder (3 lines)
                              ShimmerPlaceholder(width: 180, height: 12),
                              SizedBox(height: 4),
                              ShimmerPlaceholder(width: 200, height: 12),
                              SizedBox(height: 4),
                              ShimmerPlaceholder(width: 150, height: 12),
                              SizedBox(height: 8),
                              // Description Placeholder (3 lines)
                              ShimmerPlaceholder(width: 230, height: 10),
                              SizedBox(height: 4),
                              ShimmerPlaceholder(width: 220, height: 10),
                              SizedBox(height: 4),
                              ShimmerPlaceholder(width: 180, height: 10),
                              SizedBox(height: 10),
                              ShimmerPlaceholder(width: 230, height: 10),
                              SizedBox(height: 4),
                              ShimmerPlaceholder(width: 270, height: 10),
                              SizedBox(height: 4),
                              ShimmerPlaceholder(width: 270, height: 10),
                              SizedBox(height: 4),
                            ],
                          ),
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
    );
  }
}

class ShimmerAdvertisementsListmobile extends StatelessWidget {
  final double adFiledSize;
  final ScrollController scrollController;
  final dynamic dynamicPadding;
  final ScrollPhysics? scrollPhysics;

  const ShimmerAdvertisementsListmobile(
      {super.key,
      required this.adFiledSize,
      required this.scrollController,
      required this.dynamicPadding,
      this.scrollPhysics});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: scrollPhysics ?? const AlwaysScrollableScrollPhysics(),
      controller: scrollController,
      itemCount: 10, // Fixed number of shimmer items as placeholders
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: AspectRatio(
            aspectRatio: 12 / 4,
            child: Container(
              width: adFiledSize,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color.fromARGB(
                    255, 50, 50, 50), // Background for shimmer effect
              ),
              child: Row(
                children: [
                  // Left side image shimmer
                  AspectRatio(
                    aspectRatio: 16 / 9,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: const ShimmerPlaceholdermobile(),
                    ),
                  ),
                  const SizedBox(width: 2),
                  // Right side text shimmer
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 7,
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(7),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: SingleChildScrollView(
                          physics: const NeverScrollableScrollPhysics(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // City and Street Placeholder
                              const ShimmerPlaceholder(width: 120, height: 9),
                              const SizedBox(height: 5),
                              // Price Placeholder
                              const ShimmerPlaceholder(width: 100, height: 14),
                              const SizedBox(height: 5),
                              // Title Placeholder
                              const ShimmerPlaceholder(width: 160, height: 8),
                              const SizedBox(height: 5),
                              // Description Placeholders
                              const ShimmerPlaceholder(width: 180, height: 8),

                              const SizedBox(height: 5),
                              SizedBox(
                                width: adFiledSize / 2.10 - dynamicPadding,
                                child: ClipRRect(
                                  clipBehavior: Clip.hardEdge,
                                  child: ShimmerPlaceholder(
                                      width: adFiledSize / 2.10 -
                                          dynamicPadding -
                                          10,
                                      height: 7),
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              SizedBox(
                                width: adFiledSize / 2.10 - dynamicPadding,
                                child: ClipRRect(
                                  clipBehavior: Clip.hardEdge,
                                  child: ShimmerPlaceholder(
                                      width: adFiledSize / 2.10 -
                                          dynamicPadding -
                                          10,
                                      height: 7),
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              SizedBox(
                                width: adFiledSize / 2.10 - dynamicPadding,
                                child: ClipRRect(
                                  clipBehavior: Clip.hardEdge,
                                  child: ShimmerPlaceholder(
                                      width: adFiledSize / 2.10 -
                                          dynamicPadding -
                                          10,
                                      height: 7),
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              SizedBox(
                                width: adFiledSize / 2.10 - dynamicPadding,
                                child: ClipRRect(
                                  clipBehavior: Clip.hardEdge,
                                  child: ShimmerPlaceholder(
                                      width: adFiledSize / 2.10 -
                                          dynamicPadding -
                                          10,
                                      height: 7),
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              SizedBox(
                                width: adFiledSize / 2.10 - dynamicPadding,
                                child: ClipRRect(
                                  clipBehavior: Clip.hardEdge,
                                  child: ShimmerPlaceholder(
                                      width: adFiledSize / 2.10 -
                                          dynamicPadding -
                                          10,
                                      height: 7),
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              SizedBox(
                                width: adFiledSize / 2.10 - dynamicPadding,
                                child: ClipRRect(
                                  clipBehavior: Clip.hardEdge,
                                  child: ShimmerPlaceholder(
                                      width: adFiledSize / 2.10 -
                                          dynamicPadding -
                                          10,
                                      height: 7),
                                ),
                              ),
                            ],
                          ),
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
    );
  }
}

class NotificationCardShimmer extends StatelessWidget {
  const NotificationCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    // Define base and highlight colors for the shimmer effect
    final baseColor = Colors.grey.shade700;
    final highlightColor = Colors.grey.shade500;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      color: Colors.transparent,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Shimmer.fromColors(
            baseColor: baseColor,
            highlightColor: highlightColor,
            child: const Icon(Icons.notifications)),
        title: Shimmer.fromColors(
          baseColor: baseColor,
          highlightColor: highlightColor,
          child: Container(
            height: 16,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(6))),
          ),
        ),
        subtitle: Shimmer.fromColors(
          baseColor: baseColor,
          highlightColor: highlightColor,
          child: Container(
            margin: const EdgeInsets.only(top: 4),
            height: 14,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(6))),
          ),
        ),
        trailing: Shimmer.fromColors(
            baseColor: baseColor,
            highlightColor: highlightColor,
            child: const Icon(
              Icons.image_not_supported,
              size: 45,
            )),
      ),
    );
  }
}
