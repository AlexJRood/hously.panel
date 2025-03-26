import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:hously_flutter/const/backgroundgradient.dart';
import 'package:hously_flutter/const/route_constant.dart';
import 'package:hously_flutter/routes/navigation_history_provider.dart';
import 'package:hously_flutter/screens/go_pro/pc/components/const.dart';
import 'package:hously_flutter/screens/go_pro/pc/components/faq.dart';
import 'package:hously_flutter/screens/go_pro/pc/components/features.dart';
import 'package:hously_flutter/screens/go_pro/pc/components/pro_cards.dart';
import 'package:hously_flutter/state_managers/services/navigation_service.dart';
import 'package:hously_flutter/theme/apptheme.dart';
import 'package:hously_flutter/widgets/appbar/hously/pc/appbar.dart';
import 'package:hously_flutter/widgets/side_menu/side_menu_manager.dart';
import 'package:hously_flutter/widgets/side_menu/slide_rotate_menu.dart';
import 'package:hously_flutter/widgets/sidebar/sidebar.dart';

// Provider for the first (outer) ScrollController
final firstScrollControllerProvider = Provider<ScrollController>((ref) {
  return ScrollController();
});

// Provider for the second (inner) ScrollController
final secondScrollControllerProvider = Provider<ScrollController>((ref) {
  return ScrollController();
});

class GoProPc extends ConsumerStatefulWidget {
  const GoProPc({super.key});

  @override
  ConsumerState<GoProPc> createState() => _GoProPcState();
}

class _GoProPcState extends ConsumerState<GoProPc> {
  @override
  Widget build(BuildContext context) {
    final firstScrollController = ref.watch(firstScrollControllerProvider);
    final sideMenuKey = GlobalKey<SideMenuState>();
    return Scaffold(
      body: SideMenuManager.sideMenuSettings(
        menuKey: sideMenuKey,
        child: Row(
          children: [
            Sidebar(sideMenuKey: sideMenuKey),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  gradient: CustomBackgroundGradients.getMainMenuBackground(
                    context,
                    ref,
                  ),
                ),
                child: SingleChildScrollView(
                  controller: firstScrollController,
                  child: Column(
                    children: [
                      const TopAppBar(),
                      Row(children: [RealEstateGoalsWidget()]),
                      const Tabview(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Tabview extends ConsumerWidget {
  const Tabview({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final theme = ref.watch(themeColorsProvider);
    final screenHeight = MediaQuery.of(context).size.height;

    return SizedBox(
      height: screenHeight,
      child: Center(
        child: DefaultTabController(
          length: 7,
          child: Column(
            children: [
              Container(
                color: theme.popupcontainercolor.withOpacity(0.3),
                child: TabBar(
                  tabAlignment: TabAlignment.center,
                  dividerColor: Colors.transparent,
                  unselectedLabelColor: theme.popupcontainertextcolor,
                  labelColor: theme.popupcontainertextcolor,
                  indicator: BoxDecoration(
                    color: theme.popupcontainercolor.withOpacity(0.5),
                  ),
                  isScrollable: true,
                  tabs: [
                    Container(
                      width: 100,
                      alignment: Alignment.center,
                      child: Tab(text: "AGENT".tr, height: 40),
                    ),
                    Container(
                      width: 100,
                      alignment: Alignment.center,
                      child: Tab(text: "INVESTOR".tr, height: 40),
                    ),
                    Container(
                      width: 100,
                      alignment: Alignment.center,
                      child: Tab(text: "OSOBA PRYWATNA".tr, height: 40),
                    ),
                    Container(
                      width: 100,
                      alignment: Alignment.center,
                      child: Tab(text: "WYNAJMUJĄCY".tr, height: 40),
                    ),
                    Container(
                      width: 170,
                      alignment: Alignment.center,
                      child: Tab(text: "NOWE MONITOROWANIE".tr, height: 40),
                    ),
                    Container(
                      width: 100,
                      alignment: Alignment.center,
                      child: Tab(text: "CRM DLA AGENTÓW".tr, height: 40),
                    ),
                    Container(
                      width: 170,
                      alignment: Alignment.center,
                      child: Tab(text: "PLANER REMONTÓW".tr, height: 40),
                    ),
                  ],
                ),
              ),
              const Expanded(
                child: TabBarView(
                  children: [
                    SubscriptionPlans(category: "AGENT"),
                    SubscriptionPlans(category: "INVESTOR"),
                    SubscriptionPlans(category: "INDIVIDUAL"),
                    SubscriptionPlans(category: "LANDLORD"),
                    SubscriptionPlans(category: "NEW MONITORING"),
                    SubscriptionPlans(category: "AGENT CRM"),
                    SubscriptionPlans(category: "REMONT PLANER"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SubscriptionPlans extends ConsumerStatefulWidget {
  final String category;

  const SubscriptionPlans({super.key, required this.category});

  @override
  ConsumerState<SubscriptionPlans> createState() => _SubscriptionPlansState();
}

class _SubscriptionPlansState extends ConsumerState<SubscriptionPlans> {
  bool currentplan = false;
  late ScrollController secondScrollController;

  @override
  void initState() {
    super.initState();
    secondScrollController = ref.read(secondScrollControllerProvider);

    secondScrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    final firstScrollController = ref.read(firstScrollControllerProvider);
    if (secondScrollController.offset > 0) {
      firstScrollController.jumpTo(220);
    }
  }

  @override
  void dispose() {
    secondScrollController.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filteredPlans = subscriptionPackages
        .where((plan) => plan.userCategory == widget.category)
        .toList();
    final theme = ref.watch(themeColorsProvider);
    final thememodechecker = ref.watch(isDefaultDarkSystemProvider);
    final colorscheme = ref.watch(colorSchemeProvider);

    return SingleChildScrollView(
      controller: secondScrollController,
      child: SizedBox(
        width: 950,
        child: Column(
          children: filteredPlans.map((plan) {
            final standardFeatures = plan.features['standard'] ?? {};
            final goldFeatures = plan.features['gold'] ?? {};
            final premiumFeatures = plan.features['premium'] ?? {};

            return Column(
              children: [
                const SizedBox(height: 15),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Płać miesięcznie'.tr,
                        style:
                            TextStyle(color: Theme.of(context).iconTheme.color),
                      ),
                      const SizedBox(width: 15),
                      currentplan
                          ? Switch(
                              value: currentplan,
                              activeTrackColor:
                                  colorscheme == FlexScheme.blackWhite
                                      ? Colors.blue
                                      : Theme.of(context).colorScheme.secondary,
                              onChanged: (value) {
                                setState(() {
                                  currentplan = !currentplan;
                                  print("monthly:$currentplan");
                                });
                              },
                              activeColor: thememodechecker
                                  ? theme.togglebuttoncolor
                                  : colorscheme == FlexScheme.blackWhite
                                      ? Colors.lightBlueAccent
                                      : Theme.of(context).colorScheme.primary,
                              inactiveTrackColor:
                                  colorscheme == FlexScheme.blackWhite
                                      ? Colors.blue
                                      : Theme.of(context).colorScheme.secondary,
                              inactiveThumbColor: Colors.white,
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                            )
                          : Transform.rotate(
                              angle: 3.14159, // 180 degrees in radians
                              child: Switch(
                                value: !currentplan,
                                activeTrackColor: colorscheme ==
                                        FlexScheme.blackWhite
                                    ? Colors.blue
                                    : Theme.of(context).colorScheme.secondary,
                                onChanged: (value) {
                                  setState(() {
                                    currentplan = !currentplan;
                                    print("yearly:$currentplan");
                                  });
                                },
                                activeColor: thememodechecker
                                    ? theme.togglebuttoncolor
                                    : colorscheme == FlexScheme.blackWhite
                                        ? Colors.lightBlueAccent
                                        : Theme.of(context).colorScheme.primary,
                                inactiveTrackColor: colorscheme ==
                                        FlexScheme.blackWhite
                                    ? Colors.blue
                                    : Theme.of(context).colorScheme.secondary,
                                inactiveThumbColor: Colors.white,
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                              ),
                            ),
                      const SizedBox(width: 15),
                      Text(
                        'Płać rocznie'.tr,
                        style:
                            TextStyle(color: Theme.of(context).iconTheme.color),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    const Spacer(),
                    PremiumCard(
                      onPressed: () {
                        ref
                            .read(navigationService)
                            .pushNamedScreen(Routes.checkOut);
                      },
                      mainContainerHeight: 450,
                      innerContainerHeight: 400,
                      title: 'Standard',
                      originalPrice: plan.price,
                      discountedPrice: plan.discountPrice,
                      pricingDescription: '/month per user',
                      features: const [
                        'Track views, clicks, and leads',
                        'Priority visibility with a "Gold" badge',
                        'Advanced analytics and insights',
                        'Priority visibility with a "Gold" badge',
                        'Advanced analytics and insights',
                      ],
                    ),
                    const SizedBox(width: 20),
                    PremiumCard(
                      ispremium: true,
                      onPressed: () {
                        ref
                            .read(navigationHistoryProvider.notifier)
                            .addPage(Routes.checkOut);
                        ref
                            .read(navigationService)
                            .pushNamedReplacementScreen(Routes.checkOut);
                      },
                      mainContainerHeight: 500,
                      innerContainerHeight: 450,
                      title: 'Premium',
                      originalPrice: plan.price,
                      discountedPrice: plan.discountPrice,
                      pricingDescription: '/month per user',
                      features: const [
                        'Track views, clicks, and leads',
                        'Priority visibility with a "Gold" badge',
                        'Advanced analytics and insights',
                        'Priority visibility with a "Gold" badge',
                        'Advanced analytics and insights',
                      ],
                    ),
                    const SizedBox(width: 20),
                    PremiumCard(
                      onPressed: () {
                        ref
                            .read(navigationHistoryProvider.notifier)
                            .addPage(Routes.checkOut);
                        ref
                            .read(navigationService)
                            .pushNamedReplacementScreen(Routes.checkOut);
                      },
                      mainContainerHeight: 450,
                      innerContainerHeight: 400,
                      title: 'Gold',
                      originalPrice: plan.price,
                      discountedPrice: plan.discountPrice,
                      pricingDescription: '/month per user',
                      features: const [
                        'Track views, clicks, and leads',
                        'Priority visibility with a "Gold" badge',
                        'Advanced analytics and insights',
                        'Priority visibility with a "Gold" badge',
                        'Advanced analytics and insights',
                      ],
                    ),
                    const Spacer(),
                  ],
                ),
                const SizedBox(height: 40),
                FeaturesWidget(
                  ongoldpressed: () {
                    ref
                        .read(navigationHistoryProvider.notifier)
                        .addPage(Routes.checkOut);
                    ref
                        .read(navigationService)
                        .pushNamedReplacementScreen(Routes.checkOut);
                  },
                  onpremiumpressed: () {
                    ref
                        .read(navigationHistoryProvider.notifier)
                        .addPage(Routes.checkOut);
                    ref
                        .read(navigationService)
                        .pushNamedReplacementScreen(Routes.checkOut);
                  },
                  onstandardpressed: () {
                    ref
                        .read(navigationHistoryProvider.notifier)
                        .addPage(Routes.checkOut);
                    ref
                        .read(navigationService)
                        .pushNamedReplacementScreen(Routes.checkOut);
                  },
                ),
                const SizedBox(height: 15),
                SizedBox(
                  width: 950,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'MANAGEMENT AND CONTROLS',
                        style:
                            TextStyle(color: Theme.of(context).iconTheme.color),
                      ),
                      const SizedBox(height: 4),
                      Divider(
                          color: Theme.of(context)
                              .iconTheme
                              .color!
                              .withOpacity(0.5)),
                      FeatureRow(
                        featureLabel: 'Standard access',
                        isStandardFeatureEnabled:
                            standardFeatures['standardaccess'] ?? false,
                        isPremiumFeatureEnabled:
                            premiumFeatures['standardaccess'] ?? false,
                        isGoldFeatureEnabled:
                            goldFeatures['standardaccess'] ?? false,
                      ),
                      Divider(
                          color: Theme.of(context)
                              .iconTheme
                              .color!
                              .withOpacity(0.5)),
                      FeatureRow(
                        featureLabel: 'Priority support',
                        isStandardFeatureEnabled:
                            standardFeatures['prioritysupport'] ?? false,
                        isPremiumFeatureEnabled:
                            premiumFeatures['prioritysupport'] ?? false,
                        isGoldFeatureEnabled:
                            goldFeatures['prioritysupport'] ?? false,
                      ),
                      Divider(
                          color: Theme.of(context)
                              .iconTheme
                              .color!
                              .withOpacity(0.5)),
                      FeatureRow(
                        featureLabel: 'Exclusive features',
                        isStandardFeatureEnabled:
                            standardFeatures['exclusivefeatures'] ?? false,
                        isPremiumFeatureEnabled:
                            premiumFeatures['exclusivefeatures'] ?? false,
                        isGoldFeatureEnabled:
                            goldFeatures['exclusivefeatures'] ?? false,
                      ),
                      Divider(
                          color: Theme.of(context)
                              .iconTheme
                              .color!
                              .withOpacity(0.5)),
                      FeatureRow(
                        featureLabel: 'Boost productivity',
                        isStandardFeatureEnabled:
                            standardFeatures['boostprouctivity'] ?? false,
                        isPremiumFeatureEnabled:
                            premiumFeatures['boostprouctivity'] ?? false,
                        isGoldFeatureEnabled:
                            goldFeatures['boostprouctivity'] ?? false,
                      ),
                      Divider(
                          color: Theme.of(context)
                              .iconTheme
                              .color!
                              .withOpacity(0.5)),
                      FeatureRow(
                        featureLabel: 'Table',
                        isStandardFeatureEnabled:
                            standardFeatures['table'] ?? false,
                        isPremiumFeatureEnabled:
                            premiumFeatures['table'] ?? false,
                        isGoldFeatureEnabled: goldFeatures['table'] ?? false,
                      ),
                      Divider(
                          color: Theme.of(context)
                              .iconTheme
                              .color!
                              .withOpacity(0.5)),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                    width: 950,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'COLLOBRATION',
                            style: TextStyle(
                                color: Theme.of(context).iconTheme.color),
                          ),
                          const SizedBox(height: 4),
                          Divider(color: Theme.of(context).iconTheme.color),
                          Featuredatarow(
                              featureLabel: 'Disc',
                              standardFeatureQuota: standardFeatures['disc'],
                              premiumFeatureQuota: premiumFeatures['disc'],
                              goldFeatureQuota: goldFeatures['disc']),
                          FeatureRow(
                            featureLabel: 'Priority features',
                            isStandardFeatureEnabled:
                                standardFeatures['priority'] ?? false,
                            isPremiumFeatureEnabled:
                                premiumFeatures['priority'] ?? false,
                            isGoldFeatureEnabled:
                                goldFeatures['priority'] ?? false,
                          ),
                          Divider(
                              color: Theme.of(context)
                                  .iconTheme
                                  .color!
                                  .withOpacity(0.5)),
                          FeatureRow(
                            featureLabel: 'Exclusive features',
                            isStandardFeatureEnabled:
                                standardFeatures['exclusive'] ?? false,
                            isPremiumFeatureEnabled:
                                premiumFeatures['exclusive'] ?? false,
                            isGoldFeatureEnabled:
                                goldFeatures['exclusive'] ?? false,
                          ),
                          Divider(
                              color: Theme.of(context)
                                  .iconTheme
                                  .color!
                                  .withOpacity(0.5)),
                        ])),
                const SizedBox(
                  height: 70,
                ),
                SizedBox(
                  child: Center(
                    child: Text(
                      textAlign: TextAlign.center,
                      "Przystępne plany na każdą sytuację".tr,
                      style: TextStyle(
                          color: Theme.of(context).iconTheme.color,
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  width: 950,
                  child: Text(
                    textAlign: TextAlign.center,
                    "Wybór planu premium dla agentów odblokowuje zaawansowane narzędzia, priorytetowe wsparcie oraz ekskluzywne funkcje zaprojektowane w celu usprawnienia operacji, zwiększenia produktywności i poprawy satysfakcji klientów, zapewniając agentom łatwe świadczenie usług na najwyższym poziomie"
                        .tr,
                    style: TextStyle(
                      color:
                          Theme.of(context).iconTheme.color!.withOpacity(0.5),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: 950,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                          child: SecurityBanner(
                              onTap: () {},
                              message:
                                  'Your privacy and security are our top priorities.')),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                          child: SecurityBanner(
                              onTap: () {},
                              message:
                                  'Not satisfied? We offer a 30-day money-back guarantee.')),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                          child: SecurityBanner(
                              onTap: () {},
                              message:
                                  'Payment by VISA, Mastercard,PayPal or wire transfer')),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 100,
                ),
                Text(
                  'Najczęściej Zadawane Pytania'.tr,
                  style: TextStyle(
                      color: Theme.of(context).iconTheme.color,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 30,
                ),
                FAQPage(),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
