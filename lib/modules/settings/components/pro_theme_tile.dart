import 'package:flutter/material.dart';

class ColorSchemeTile extends StatelessWidget {
  final Color containerColor;
  final Color secondColor;

  const ColorSchemeTile({
    super.key,
    required this.containerColor,
    required this.secondColor,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Determine screen size category
    bool isPC = screenWidth > 1080;
    bool isMediumScreen = screenWidth >= 500 && screenWidth <= 1080;
    bool isSmallScreen = screenWidth < 500;

    // Define width and height based on screen size
    final tileWidth = isPC
        ? screenWidth * 0.2 // PC: Smallest width
        : isMediumScreen
            ? screenWidth * 0.3 // Medium: Between mobile & PC
            : screenWidth * 0.32; // Small mobile: Reduced width

    final tileHeight = tileWidth *
        (isPC
            ? 0.5
            : isMediumScreen
                ? 0.55
                : 0.58); // Adjusted aspect ratio

    return Container(
      width: tileWidth,
      height: tileHeight,
      padding: EdgeInsets.all(isSmallScreen
          ? tileWidth * 0.015
          : tileWidth * 0.02), // Reduced padding
      decoration: BoxDecoration(
        color: containerColor,
        borderRadius: BorderRadius.circular(
            tileWidth * 0.015), // Softer radius for small screens
        border: Border.all(
            width: isSmallScreen ? tileWidth * 0.008 : tileWidth * 0.01,
            color: secondColor), // Thinner border
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: tileWidth * 0.05, // Reduced side bar thickness
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(tileWidth * 0.015),
              color: secondColor,
            ),
          ),
          SizedBox(width: tileWidth * 0.015), // Reduced spacing
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: tileHeight * 0.1, // Reduced title height
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(tileWidth * 0.015),
                    color: secondColor,
                  ),
                ),
                SizedBox(height: tileHeight * 0.025),
                Row(
                  children: [
                    CircleAvatar(
                      radius: tileWidth * 0.025, // Reduced avatar size
                      backgroundColor: secondColor,
                    ),
                    SizedBox(width: tileWidth * 0.015),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: tileHeight * 0.025,
                            width: tileWidth * 0.18,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(tileWidth * 0.015),
                              color: secondColor,
                            ),
                          ),
                          SizedBox(height: tileHeight * 0.01),
                          Container(
                            height: tileHeight * 0.07,
                            width: tileWidth * 0.27,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(tileWidth * 0.015),
                              color: secondColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: tileHeight * 0.04),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(tileWidth * 0.015),
                      color: secondColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
