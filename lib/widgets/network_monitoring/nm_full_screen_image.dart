import 'package:flutter/gestures.dart'; // Import for PointerScrollEvent
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hously_flutter/const/icons.dart';
import 'package:hously_flutter/data/design/design.dart';
import 'package:hously_flutter/state_managers/services/navigation_service.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class NMFullScreenImageView extends ConsumerStatefulWidget {
  final String tag;
  final List<String> images;
  final int initialPage;

  const NMFullScreenImageView({
    super.key,
    required this.tag,
    required this.images,
    this.initialPage = 0,
  });

  @override
  NMFullScreenImageViewState createState() => NMFullScreenImageViewState();
}

class NMFullScreenImageViewState extends ConsumerState<NMFullScreenImageView> {
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
                  ref.read(navigationService).beamPop();
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
                  icon: SvgPicture.asset(AppIcons.iosArrowLeft,
                      color: AppColors.light),
                  onPressed: () => ref.read(navigationService).beamPop(),
                ),
              ),
            ),
          ),
          Positioned(
            left: 20,
            top: MediaQuery.of(context).size.height * 0.5 - 30,
            child: SafeArea(
              child: IconButton(
                icon: SvgPicture.asset(AppIcons.iosArrowLeft,
                    height: 30,width: 30, color: Colors.white),
                onPressed: _goToPreviousImage,
              ),
            ),
          ),
          Positioned(
            right: 20,
            top: MediaQuery.of(context).size.height * 0.5 - 30,
            child: SafeArea(
              child: IconButton(
                icon: SvgPicture.asset(AppIcons.iosArrowRight,
                    height: 30,width: 30, color: Colors.white),
                onPressed: _goToNextImage,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
