import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/screens/pop_pages/view_pop_changer_page.dart';
import 'package:hously_flutter/state_managers/services/navigation_service.dart';
import 'package:hously_flutter/theme/apptheme.dart';
import 'package:hously_flutter/widgets/landing_page/landing_page_pc/appbar_landingpage.dart';
import 'dart:ui' as ui;
import '../../../state_managers/data/filter_provider.dart';
import '../../../state_managers/data/landing_page_provider.dart';
import 'filters_widget.dart';

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

  void _showPopup(PopupType type) {
    final key = _itemKeys[type];
    if (key == null || key.currentContext == null) return;

    final renderBox = key.currentContext!.findRenderObject() as RenderBox;
    final position = renderBox.localToGlobal(Offset.zero);
    final popupContent = _getPopupContent(type);

    _overlayEntry?.remove();
    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        left: position.dx,
        top: position.dy - 450,
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: _closeAllPopups,
          child: Material(
            color: Colors.transparent,
            child: GestureDetector(
              onTap: () {},
              child: popupContent,
            ),
          ),
        ),
      ),
    );
    Overlay.of(context).insert(_overlayEntry!);
  }

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

  Widget _getPopupContent(PopupType type) {
    switch (type) {
      case PopupType.location:
        return const LocationSearchWidget();
      case PopupType.property:
        return const PropertyTypes();
      case PopupType.price:
        return const PriceRangeWidget();
      case PopupType.meter:
        return const MeterRangeWidget();
    }
  }

  void _togglePopup(PopupType type) {
    final currentType = ref.read(activePopupProvider);
    if (currentType == type) {
      _closeAllPopups();
    } else {
      ref.read(activePopupProvider.notifier).state = type;
      _showPopup(type);
    }
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
                                  const Text(
                                    'Connecting you to the perfect\nproperty – Effortlessly!',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 50,
                                      fontWeight: FontWeight.bold,
                                    ),
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
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 18.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  InkWell(
                                                    key: _itemKeys[
                                                        PopupType.location],
                                                    onTap: () => _togglePopup(
                                                        PopupType.location),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        const Text(
                                                          'Location',
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                        Text(
                                                          ref
                                                                  .watch(
                                                                      selectedLocationProvider)
                                                                  .isEmpty
                                                              ? 'All locations'
                                                              : ref.watch(
                                                                  selectedLocationProvider),
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Image.asset(
                                                      'assets/images/frame.png'),
                                                  InkWell(
                                                    key: _itemKeys[
                                                        PopupType.property],
                                                    onTap: () => _togglePopup(
                                                        PopupType.property),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        const Text(
                                                          'Property type',
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                        Text(
                                                          ref
                                                                  .watch(
                                                                      selectedPropertyProvider)
                                                                  .isEmpty
                                                              ? 'All property types'
                                                              : ref.watch(
                                                                  selectedPropertyProvider),
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Image.asset(
                                                      'assets/images/frame.png'),
                                                  InkWell(
                                                    key: _itemKeys[
                                                        PopupType.price],
                                                    onTap: () => _togglePopup(
                                                        PopupType.price),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        const Text(
                                                          'Price range',
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                        Text(
                                                          ref
                                                                  .watch(
                                                                      selectedPriceRangeProvider)
                                                                  .isEmpty
                                                              ? 'Choose price range'
                                                              : ref.watch(
                                                                  selectedPriceRangeProvider),
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Image.asset(
                                                      'assets/images/frame.png'),
                                                  InkWell(
                                                    key: _itemKeys[
                                                        PopupType.meter],
                                                    onTap: () => _togglePopup(
                                                        PopupType.meter),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        const Text(
                                                          'Meter range',
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                        Text(
                                                          ref
                                                                  .watch(
                                                                      selectedMeterRangeProvider)
                                                                  .isEmpty
                                                              ? 'Choose meter range'
                                                              : ref.watch(
                                                                  selectedMeterRangeProvider),
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Row(
                                                    children: [
                                                      InkWell(
                                                        onTap: () {
                                                          ref
                                                              .read(
                                                                  filterProvider
                                                                      .notifier)
                                                              .applyFiltersFromCache(
                                                                ref.read(
                                                                    filterCacheProvider
                                                                        .notifier),
                                                                ref,
                                                              );
                                                          ref
                                                              .read(
                                                                  filterProvider
                                                                      .notifier)
                                                              .applyFilters(ref)
                                                              .whenComplete(
                                                            () {
                                                              final data =
                                                                  ref.watch(
                                                                      filterCacheProvider);
                                                              print(data);
                                                            },
                                                          );
                                                          String
                                                              selectedFeedView =
                                                              ref.read(
                                                                  selectedFeedViewProvider);
                                                          ref
                                                              .read(
                                                                  navigationService)
                                                              .pushNamedReplacementScreen(
                                                                  selectedFeedView);
                                                        },
                                                        child: Container(
                                                          height: 48,
                                                          width: 103,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                const BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            6)),
                                                            border: Border.all(
                                                                color: const Color
                                                                    .fromRGBO(
                                                                    200,
                                                                    200,
                                                                    200,
                                                                    1)),
                                                          ),
                                                          child: const Center(
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Icon(
                                                                  Icons.search,
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          255,
                                                                          255,
                                                                          255,
                                                                          1),
                                                                ),
                                                                Text(
                                                                  'Filter',
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    color: Color
                                                                        .fromRGBO(
                                                                            255,
                                                                            255,
                                                                            255,
                                                                            1),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(width: 10),
                                                      Container(
                                                        height: 48,
                                                        width: 48,
                                                        decoration:
                                                            const BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          6)),
                                                          color: Color.fromRGBO(
                                                              255, 255, 255, 1),
                                                        ),
                                                        child: const Center(
                                                          child: Icon(
                                                            Icons.search,
                                                            color:
                                                                Color.fromRGBO(
                                                                    35,
                                                                    35,
                                                                    35,
                                                                    1),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
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
