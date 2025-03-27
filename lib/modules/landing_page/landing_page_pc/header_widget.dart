import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/theme/design/design.dart';
import 'package:hously_flutter/modules/ads_managment/pop_pages/view_pop_changer_page.dart';
import 'package:hously_flutter/routing/navigation_service.dart';
import 'package:hously_flutter/theme/apptheme.dart';
import 'package:hously_flutter/modules/landing_page/landing_page_pc/appbar_landingpage.dart';
import 'dart:ui' as ui;
import '../../ads_managment/filter_provider.dart';
import '../landing_page_provider.dart';


enum PopupType { location, property, price, meter }

final activePopupProvider = StateProvider<PopupType?>((ref) => null);

class HeaderWidget extends ConsumerStatefulWidget {
  final double paddingDynamic;

  const HeaderWidget({super.key, required this.paddingDynamic});

  @override
  ConsumerState<HeaderWidget> createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends ConsumerState<HeaderWidget> {
  final Map<PopupType, GlobalKey> _itemKeys = {
    PopupType.location: GlobalKey(),
    PopupType.property: GlobalKey(),
    PopupType.price: GlobalKey(),
    PopupType.meter: GlobalKey(),
  };

  OverlayEntry? _overlayEntry;
  Size? _previousSize;
  BoxConstraints? _previousConstraints;


  @override
  void didUpdateWidget(HeaderWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.paddingDynamic != widget.paddingDynamic) {
      _closeAllPopups();
    }
  }

  @override
  void dispose() {
    _overlayEntry?.remove();
    super.dispose();
  }


  void _closeAllPopups() {
    ref.read(activePopupProvider.notifier).state = null;
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  Widget build(BuildContext context) {
    final currentSize = MediaQuery.of(context).size;
    if (_previousSize != null && _previousSize != currentSize) {
      _closeAllPopups();
    }
    _previousSize = currentSize;

    final theme = ref.watch(themeColorsProvider);

    return InkWell(
      onTap: _closeAllPopups,
      child: Container(
        height: MediaQuery.of(context).size.height / 1.1,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/hero-section(3).jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const AppBarLandingPageWidget(),
            LayoutBuilder(
              builder: (context, constraints) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (_previousConstraints != null &&
                      constraints != _previousConstraints) {
                    _closeAllPopups();
                  }
                  _previousConstraints = constraints;
                });

                return SizedBox(
                  width: constraints.maxWidth,
                  height: MediaQuery.of(context).size.height * 0.80,
                  child: Stack(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                   Text(
                                    'Connecting you to the perfect\nproperty – Effortlessly!',
                                    style: AppTextStyles.libreCaslonHeading
                                      .copyWith(
                                          color: Colors.white,
                                          fontSize: 50,
                                          fontWeight: FontWeight.bold)
                                  ),
                                  const SizedBox(height: 30),
                                  const Text(
                                    'Whether you\'re buying, selling, or renting, our dedicated team is here to\nmake the process seamless, stress-free, and tailored to your needs.',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 30),
                                  Container(
                                    height: 48,
                                    width: 159,
                                    decoration: const BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(6)),
                                      color: Colors.white,
                                    ),
                                    child: const Center(
                                      child: Text(
                                        'Contact an Agent',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 40),
                                ],
                              ),
                              Container(
                                height: 160,
                                width: 1200,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: BackdropFilter(
                                    filter: ui.ImageFilter.blur(
                                        sigmaX: 50, sigmaY: 50),
                                    child: Container(
                                      color: theme.adPopBackground
                                          .withOpacity(0.15),
                                      child: Padding(
                                        padding: const EdgeInsets.all(18.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            const Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Expanded(
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            'BUY',
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                          Spacer(),
                                                          Text(
                                                            'RENT',
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                          Spacer(),
                                                          Text(
                                                            'SELL',
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                          Spacer(),
                                                          Text(
                                                            'DEVELOPERS OFFERS',
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Row(
                                                        children: [],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                Divider(
                                                  color: Colors.white,
                                                ),
                                              ],
                                            ),
                                            const SizedBox(),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
