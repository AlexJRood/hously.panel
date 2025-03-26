import 'package:flutter/gestures.dart'; // Import for PointerScrollEvent
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/data/design/design.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class FullScreenImageView extends ConsumerStatefulWidget {
  final String tag;
  final List<String> images;
  final int initialPage;

  const FullScreenImageView({
    super.key,
    required this.tag,
    required this.images,
    this.initialPage = 0,
  });

  @override
  FullScreenImageViewState createState() => FullScreenImageViewState();
}

class FullScreenImageViewState extends ConsumerState<FullScreenImageView> {
  late PageController _pageController;
  double _offset = 0.0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.initialPage);
  }

  void _goToNextImage() {
    if (_pageController.page!.toInt() < widget.images.length - 1) {
      _pageController.nextPage(
          duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
    }
  }

  void _goToPreviousImage() {
    if (_pageController.page!.toInt() > 0) {
      _pageController.previousPage(
          duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Listener(
            onPointerSignal: (pointerSignal) {
              if (pointerSignal is PointerScrollEvent) {
                if (pointerSignal.scrollDelta.dy > 0) {
                  _goToNextImage();
                } else if (pointerSignal.scrollDelta.dy < 0) {
                  _goToPreviousImage();
                }
              }
            },
            child: GestureDetector(
              onHorizontalDragUpdate: (details) {
                if (details.primaryDelta! < 0) {
                  _goToNextImage();
                } else if (details.primaryDelta! > 0) {
                  _goToPreviousImage();
                }
              },
              onVerticalDragUpdate: (details) {
                setState(() {
                  _offset += details.primaryDelta!;
                });
              },
              onVerticalDragEnd: (details) {
                if (_offset > 50) {
                  Navigator.pop(context);
                } else {
                  setState(() {
                    _offset = 0;
                  });
                }
              },
              child: Transform.translate(
                offset: Offset(0, _offset),
                child: PhotoViewGallery.builder(
                  itemCount: widget.images.length,
                  pageController: _pageController,
                  builder: (context, index) {
                    return PhotoViewGalleryPageOptions(
                      imageProvider: NetworkImage(widget.images[index]),
                      heroAttributes: PhotoViewHeroAttributes(
                          tag: widget.tag + index.toString()),
                    );
                  },
                ),
              ),
            ),
          ),
          // UI elements for navigation
          Positioned(
            top: 20,
            left: 20,
            child: SafeArea(
              child: CircleAvatar(
                backgroundColor: Colors.black45,
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios_rounded,
                    color: AppColors.light,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ),
          ),
          Positioned(
            left: 20,
            top: MediaQuery.of(context).size.height * 0.5 - 30,
            child: SafeArea(
              child: IconButton(
                icon: const Icon(Icons.chevron_left,
                    size: 30, color: Colors.white),
                onPressed: _goToPreviousImage,
              ),
            ),
          ),
          Positioned(
            right: 20,
            top: MediaQuery.of(context).size.height * 0.5 - 30,
            child: SafeArea(
              child: IconButton(
                icon: const Icon(Icons.chevron_right,
                    size: 30, color: Colors.white),
                onPressed: _goToNextImage,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
