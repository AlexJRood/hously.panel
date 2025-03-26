import 'dart:ui' as ui;

import 'package:feedback/feedback.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hously_flutter/const/icons.dart';
import 'package:hously_flutter/data/design/design.dart';
import 'package:hously_flutter/error/custom_error_handler.dart';
import 'package:hously_flutter/state_managers/data/user_provider.dart';
import 'package:hously_flutter/state_managers/services/navigation_service.dart';
import 'package:hously_flutter/utils/secure_storage.dart';
import 'package:hously_flutter/widgets/installpopup/install_popup.dart';

void copyToClipboard(BuildContext context, String listingUrl) {
  Clipboard.setData(ClipboardData(text: listingUrl)).then((_) {
    final snackBar = Customsnackbar().showSnackBar(
        "Success", "Link skopiowany do schowka!".tr, "success", () {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
    });
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  });
}

class ArticlePopMobile extends ConsumerStatefulWidget {
  final dynamic articlePop;
  final String tagArticlePop;

  const ArticlePopMobile(
      {super.key, required this.articlePop, required this.tagArticlePop});

  @override
  ArticlePopMobileState createState() => ArticlePopMobileState();
}

class ArticlePopMobileState extends ConsumerState<ArticlePopMobile> {
  late String mainImageUrl;
  final SecureStorage secureStorage = SecureStorage();
  bool _atTop = true; // Flaga wskazująca, czy jesteśmy na szczycie
  double _dragDistance = 0.0; // Kumulowana odległość przeciągnięcia
  final double _requiredDragDistance = 100.0;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    mainImageUrl = widget.articlePop.thumbnailUrl;
    _scrollController.addListener(_updateTopStatus);
  }

  void _updateTopStatus() {
    final atTop = _scrollController.position.pixels <=
        _scrollController.position.minScrollExtent;
    if (_atTop != atTop) {
      setState(() {
        _atTop = atTop;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final userAsyncValue = ref.watch(userProvider);

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double mainImageHeight = screenHeight * 0.75;
    // double topPosition = (screenHeight - mainImageHeight - 10)/2;

    const double maxWidth = 1920;
    const double minWidth = 480;
    const double maxLogoSize = 30;
    const double minLogoSize = 16;

    double logoSize = (screenWidth - minWidth) /
            (maxWidth - minWidth) *
            (maxLogoSize - minLogoSize) +
        minLogoSize;
    logoSize = logoSize.clamp(minLogoSize, maxLogoSize);

    return userAsyncValue.when(
      data: (user) {
        return PopupListener(
        child: SafeArea(
          child: Scaffold(
              backgroundColor: Colors.transparent,
              body: NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (notification) {
                  if (notification.leading) {
                    notification.disallowIndicator();
                  }
                  return true;
                },
                child: NotificationListener<OverscrollNotification>(
                  onNotification: (OverscrollNotification notification) {
                    if (_atTop && notification.overscroll < 0) {
                      _dragDistance -= notification.overscroll;
                      if (_dragDistance >= _requiredDragDistance) {
                        ref.read(navigationService).beamPop();
                        _dragDistance = 0.0; // Resetuj kumulowaną odległość
                      }
                    } else {
                      _dragDistance =
                          0.0; // Resetuj kumulowaną odległość, jeśli nie jesteśmy na szczycie
                    }
                    return true;
                  },
                  child: Stack(
                    children: [
                      BackdropFilter(
                        filter: ui.ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                        child: Container(
                          color: Colors.black.withOpacity(0.85),
                          width: double.infinity,
                          height: double.infinity,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => ref.read(navigationService).beamPop(),
                      ),
                      Align(
                        alignment: Alignment.topCenter,
                        child: SingleChildScrollView(
                          physics: const ClampingScrollPhysics(),
                          child: Column(
                            children: [
                              SizedBox(
                                width: screenWidth,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Hero(
                                        tag: widget.tagArticlePop,
                                        child: GestureDetector(
                                          onTap: () {},
                                          child: Image.network(
                                            mainImageUrl,
                                            width: screenWidth,
                                            height: mainImageHeight,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Material(
                                        color: Colors.transparent,
                                        child: Text(widget.articlePop.title,
                                            style: AppTextStyles.interBold
                                                .copyWith(fontSize: 30)),
                                      ),
                                      const SizedBox(height: 50),
                                      Material(
                                        color: Colors.transparent,
                                        child: Text(widget.articlePop.body,
                                            style: AppTextStyles.interRegular14),
                                      ),
                                      const SizedBox(height: 25),
                                      const Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(child: SizedBox()),
                                        ],
                                      ),
                                      const SizedBox(height: 75),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 20,
                        left: 20,
                        child: SizedBox(
                          width: 300,
                          height: screenHeight - 40,
                          child: Stack(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  IconButton(
                                    icon: SvgPicture.asset(AppIcons.iosArrowLeft,
                                        color: AppColors.light),
                                    onPressed: () =>
                                        ref.read(navigationService).beamPop(),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 20,
                        right: 20,
                        child: SizedBox(
                          width: 300,
                          height: screenHeight - 40,
                          child: Stack(
                            children: [
                              Column(
                                children: [
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: TextButton(
                                      onPressed: () {
                                        BetterFeedback.of(context).show(
                                          (feedback) async {
                                            // upload to server, share whatever
                                            // for example purposes just show it to the user
                                            // alertFeedbackFunction(
                                            // context,
                                            // feedback,
                                            // );
                                          },
                                        );
                                      },
                                      child: Text(
                                        'HOUSLY.AI',
                                        style: AppTextStyles.houslyAiLogo
                                            .copyWith(fontSize: logoSize),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ),
        );
      },
      loading: () => const CircularProgressIndicator(),
      error: (error, stack) => Text('Błąd: $error'.tr),
    );
  }
}
