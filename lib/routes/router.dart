import 'package:beamer/beamer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hously_flutter/const/route_constant.dart';
import 'package:hously_flutter/extensions/seo.dart';
import 'package:hously_flutter/models/ad/monitoring_ads_model.dart';
import 'package:hously_flutter/models/article_model.dart';
import 'package:hously_flutter/models/bill_model.dart';
import 'package:hously_flutter/models/crm/clients_model.dart';
import 'package:hously_flutter/routes/router_observer.dart';
import 'package:hously_flutter/screens/add_client_form/add_client_form_screen.dart'
deferred as add_client_form;
import 'package:hously_flutter/screens/articles_pop_page/article_pop_page.dart'
    deferred as article_pop_page;
import 'package:hously_flutter/screens/calendar/calendar_page.dart'
    deferred as calendar_page;
import 'package:hously_flutter/screens/clients/clients_page.dart'
    deferred as clients_page;
import 'package:hously_flutter/screens/crm/agent_financial_plans_page.dart'
    deferred as agent_financial_plans;
import 'package:hously_flutter/screens/crm/dashboard_crm_page.dart'
    deferred as dashboard_crm_page;
import 'package:hously_flutter/screens/crm/finance_crm_page.dart'
    deferred as finance_crm_page;
import 'package:hously_flutter/screens/feed/basic_view/basic_page.dart'
    deferred as basic_page;
import 'package:hously_flutter/screens/feed/about_us/about_us_main.dart'
    deferred as about_us;
import 'package:hously_flutter/screens/feed/feed_pop/feed_pop.dart'
    deferred as feed_pop;
import 'package:hously_flutter/screens/feed/full_size/full_size_page.dart'
    deferred as full_size_page;
import 'package:hously_flutter/screens/feed/grid/grid_page.dart'
    deferred as grid_page;
import 'package:hously_flutter/screens/feed/list_view/list_view_page.dart'
    deferred as list_view_page;
import 'package:hously_flutter/screens/feed/map/map_view_page.dart'
    deferred as map_view_page;
import 'package:hously_flutter/screens/feed/map/pv_mobile_page.dart'
    deferred as full_map_mobile;
import 'package:hously_flutter/screens/network_monitoring/feed_pop/nm_feed_pop.dart'
    deferred as nm_feed_pop;
import 'package:hously_flutter/screens/filters/filters_page.dart'
    deferred as filters_page;
import 'package:hously_flutter/screens/go_pro/checkout/checkout_page.dart'
    deferred as checkout_page;
import 'package:hously_flutter/screens/go_pro/checkout/success_page.dart'
    deferred as success_page;
import 'package:hously_flutter/screens/go_pro/go_pro_page.dart'
    deferred as go_pro_page;
import 'package:hously_flutter/screens/home_page/home_pc_page.dart'
    deferred as home_page;
import 'package:hously_flutter/screens/learn_center/learn_center_page.dart'
    deferred as learn_center_page;
import 'package:hously_flutter/screens/network_monitoring/list_with_save_searches/list_with_save_search_screen.dart'
    deferred as list_with_save_search_screen;
import 'package:hously_flutter/screens/network_monitoring/network_home_page/network_home_new/screens/monitoring_home_screen.dart'
    deferred as monitoring_home_screen;
import 'package:hously_flutter/screens/pop_pages/mobile_pop_appbar_page.dart'
    deferred as mobile_pop_appbar_page;
import 'package:hously_flutter/screens/pop_pages/sort_pop_mobile_page.dart'
    deferred as sort_pop_mobile_page;
import 'package:hously_flutter/screens/pop_pages/sort_pop_page.dart'
    deferred as sort_pop_page;
import 'package:hously_flutter/screens/preview.dart' deferred as preview_page;
import 'package:hously_flutter/screens/profile/add_offer/add_offer_page.dart'
    deferred as add_offer_page;
import 'package:hously_flutter/screens/profile/edit_offer/edit_offer_page.dart'
    deferred as edit_offer_page;
import 'package:hously_flutter/screens/profile/fav/fav_page.dart'
    deferred as fav_page;
import 'package:hously_flutter/screens/profile/login/edit_user/edit_account_page.dart'
    deferred as edit_account_page;
import 'package:hously_flutter/screens/profile/login/login/login_page.dart'
    deferred as login_page;
import 'package:hously_flutter/screens/profile/login/register/register_page.dart'
    deferred as register_page;
import 'package:hously_flutter/screens/profile/login_pro/login_pop_page.dart'
    deferred as login_pop_page;
import 'package:hously_flutter/screens/profile/profile_page/profile_page.dart'
    deferred as profile_page;
import 'package:hously_flutter/screens/profile_register/register_pro_pc_page.dart'
    deferred as register_pro_pc_page;
import 'package:hously_flutter/screens/reports/raporty_page.dart'
    deferred as raporty_page;
import 'package:hously_flutter/screens/network_monitoring/.old/save_monitoring_page.dart'
    deferred as save_monitoring_page;
import 'package:hously_flutter/screens/network_monitoring/search_page/network_monitoring_page.dart'
    deferred as network_monitoring_page;
import 'package:hously_flutter/screens/settings/settings_page.dart'
    deferred as settings_page;
import 'package:hously_flutter/screens/todo/board/board_page.dart'
    deferred as board_page;
import 'package:hously_flutter/screens/todo/todo_page.dart'
    deferred as todo_page;
import 'package:hously_flutter/screens/top_pages/rent/rent_page.dart'
    deferred as rent_page;
import 'package:hously_flutter/screens/top_pages/sell/sell_page.dart'
    deferred as sell_page;
import 'package:hously_flutter/state_managers/data/crm/clients/clients_provider.dart'
    deferred as client_fetcher;
import 'package:hously_flutter/state_managers/data/network_monitoring/feed_pop/nm_ad_provider.dart'
    deferred as nm_ad_provider;
import 'package:hously_flutter/widgets/calendar/custom_repeat_widget.dart'
    deferred as custom_repeat_widget;
import 'package:hously_flutter/widgets/calendar/events/event_widget.dart'
    deferred as event_widget;
import 'package:hously_flutter/widgets/calendar/events/guest_widget.dart'
    deferred as guest_widget;
import 'package:hously_flutter/widgets/calendar/events/repeat_widget.dart'
    deferred as repeat_widget;
import 'package:hously_flutter/widgets/crm/add_field/add_field.dart'
    deferred as add_field;
import 'package:hously_flutter/widgets/crm/clients/add_clients.dart'
    deferred as add_client;
import 'package:hously_flutter/widgets/crm/clients/clients_view_page.dart'
    deferred as client_view_page;
import 'package:hously_flutter/widgets/crm/view/view/clientview/pc/Draft/crm_edit_offer_page.dart'
    deferred as crm_edit_offer_page;
import 'package:hously_flutter/widgets/crm/finance/features/pdf/detail.dart'
    deferred as detail;
import 'package:hously_flutter/widgets/crm/finance/features/pop/status_expenses_pop.dart'
    deferred as status_expenses_pop;
import 'package:hously_flutter/widgets/crm/finance/features/pop/status_revenue_pop.dart'
    deferred as status_revenue_pop;
import 'package:hously_flutter/widgets/crm/finance/features/pop/view_pop_changer.dart'
    deferred as view_pop_changer;
import 'package:hously_flutter/widgets/crm/view/view/clientview/mobile/components/transaction_full_screen.dart'
    deferred as transaction_screen;
import 'package:hously_flutter/widgets/crm/view/view/clientview/mobile/screens/mobile_all_transaction.dart'
    deferred as mobile_all_transaction;
import 'package:hously_flutter/widgets/network_monitoring/nm_full_screen_image.dart'
    deferred as nm_full_screen_image;
import 'package:hously_flutter/widgets/screens/profile/register_pc_pop.dart'
    deferred as register_pc_pop;
import 'package:hously_flutter/screens/settings/settings_router.dart'
    deferred as settings_page_router;
import 'package:meta_seo/meta_seo.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../models/ad/ad_list_view_model.dart';
import '../screens/feed/about_us/about_us_main.dart';
import '../state_managers/data/feed/feed_pop/providers/ad_provider.dart'
    deferred as ad_provider;

final meta = kIsWeb ? MetaSEO() : null;

void setupMetaTag(BuildContext context) {
  if (kIsWeb) {
    meta?.description(description: Routes.getWebsiteTitle(context));
    meta?.twitterDescription(
        twitterDescription: Routes.getWebsiteTitle(context));
    meta?.twitterTitle(twitterTitle: Routes.getWebsiteTitle(context));
    meta?.ogDescription(ogDescription: Routes.getWebsiteTitle(context));
    meta?.ogTitle(ogTitle: Routes.getWebsiteTitle(context));
  }
}

Widget _buildDeferredScreen(
  Future<void> Function() loadLibrary,
  Widget Function() builder,
) {
  return FutureBuilder(
    future: loadLibrary(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        // Display loading indicator while the screen is loading
        return const SizedBox();
      } else if (snapshot.hasError) {
        // Handle any error that occurs during the lazy loading
        return Center(child: Text('Error loading page: ${snapshot.error}'));
      } else {
        // Once loaded, build the widget using the builder
        return builder();
      }
    },
  );
}

BeamerDelegate generateRouterDelegate() => BeamerDelegate(
      initialPath: Routes.entry,
      notFoundRedirectNamed: Routes.entry,
      navigatorObservers: [
        RouterObserver(),
        SentryNavigatorObserver(setRouteNameAsTransaction: true),
      ],
      locationBuilder: RoutesLocationBuilder(
        routes: {
          Routes.entry: (context, state, data) {
            setupMetaTag(context);
            return BeamPage(
              key: const ValueKey(Routes.entry),
              title: Routes.getWebsiteTitle(context),
              child: _buildDeferredScreen(
                  home_page.loadLibrary, () => home_page.HomePage()),
            );
          },
          Routes.homepage: (context, state, data) {
            setupMetaTag(context);
            return BeamPage(
                key: const ValueKey(Routes.homepage),
                title: Routes.getWebsiteTitle(context),
                child: _buildDeferredScreen(home_page.loadLibrary,
                    () => home_page.HomePage().seoController(context)));
          },
          Routes.eventWidget: (context, state, data) {
            setupMetaTag(context);
            return BeamPage(
                key: const ValueKey(Routes.eventWidget),
                title: Routes.getWebsiteTitle(context),
                child: _buildDeferredScreen(event_widget.loadLibrary,
                    () => event_widget.EventWidget().seoController(context)));
          },
          Routes.settings: (context, state, data) {
            setupMetaTag(context);
            return BeamPage(
                key: const ValueKey(Routes.settings),
                title: Routes.getWebsiteTitle(context),
                child: _buildDeferredScreen(settings_page.loadLibrary,
                    () => settings_page.SettingsPage()));
          },
          Routes.settingsprofile: (context, state, data) {
            setupMetaTag(context);
            return BeamPage(
                key: const ValueKey(Routes.settingsprofile),
                title: Routes.getWebsiteTitle(context),
                child: _buildDeferredScreen(settings_page_router.loadLibrary,
                    () => settings_page_router.ProfilePageRouter()));
          },
          Routes.settingsnotification: (context, state, data) {
            setupMetaTag(context);
            return BeamPage(
                key: const ValueKey(Routes.settingsnotification),
                title: Routes.getWebsiteTitle(context),
                child: _buildDeferredScreen(settings_page_router.loadLibrary,
                    () => settings_page_router.NotificationPageRouter()));
          },
          Routes.settingssecurity: (context, state, data) {
            setupMetaTag(context);
            return BeamPage(
                key: const ValueKey(Routes.settingssecurity),
                title: Routes.getWebsiteTitle(context),
                child: _buildDeferredScreen(settings_page_router.loadLibrary,
                    () => settings_page_router.SecurityPageRouter()));
          },
          Routes.settingspayments: (context, state, data) {
            setupMetaTag(context);
            return BeamPage(
              key: const ValueKey(Routes.settingspayments),
              title: Routes.getWebsiteTitle(context),
              child: _buildDeferredScreen(settings_page_router.loadLibrary,
                  () => settings_page_router.SettingsPaymentPageRouter()),
            );
          },
          Routes.settingslanguage: (context, state, data) {
            setupMetaTag(context);
            return BeamPage(
              key: const ValueKey(Routes.settingslanguage),
              title: Routes.getWebsiteTitle(context),
              child: _buildDeferredScreen(settings_page_router.loadLibrary,
                  () => settings_page_router.SettingsLanguagePageRouter()),
            );
          },
          Routes.settingstheme: (context, state, data) {
            setupMetaTag(context);
            return BeamPage(
              key: const ValueKey(Routes.settingstheme),
              title: Routes.getWebsiteTitle(context),
              child: _buildDeferredScreen(settings_page_router.loadLibrary,
                  () => settings_page_router.SettingsThemePageRouter()),
            );
          },
          Routes.settingschat: (context, state, data) {
            setupMetaTag(context);
            return BeamPage(
              key: const ValueKey(Routes.settingschat),
              title: Routes.getWebsiteTitle(context),
              child: _buildDeferredScreen(settings_page_router.loadLibrary,
                  () => settings_page_router.SettingsChatsPageRouter()),
            );
          },
          Routes.settingsupport: (context, state, data) {
            setupMetaTag(context);
            return BeamPage(
              key: const ValueKey(Routes.settingsupport),
              title: Routes.getWebsiteTitle(context),
              child: _buildDeferredScreen(settings_page_router.loadLibrary,
                  () => settings_page_router.SettingsSupportPageRouter()),
            );
          },
          Routes.settinglogout: (context, state, data) {
            setupMetaTag(context);
            return BeamPage(
              key: const ValueKey(Routes.settinglogout),
              title: Routes.getWebsiteTitle(context),
              child: _buildDeferredScreen(settings_page_router.loadLibrary,
                  () => settings_page_router.SettingsLogoutPageRouter()),
            );
          },
          Routes.add: (context, state, data) {
            setupMetaTag(context);
            return BeamPage(
                key: const ValueKey(Routes.add),
                title: Routes.getWebsiteTitle(context),
                child: _buildDeferredScreen(add_offer_page.loadLibrary,
                    () => add_offer_page.AddOfferPage()));
          },
          Routes.goPro: (context, state, data) {
            setupMetaTag(context);
            return BeamPage(
                key: const ValueKey(Routes.add),
                title: Routes.getWebsiteTitle(context),
                child: _buildDeferredScreen(go_pro_page.loadLibrary,
                    () => go_pro_page.GoProPage().seoController(context)));
          },
          Routes.fav: (context, state, data) {
            setupMetaTag(context);
            return BeamPage(
                key: const ValueKey(Routes.fav),
                title: Routes.getWebsiteTitle(context),
                child: _buildDeferredScreen(
                  fav_page.loadLibrary,
                  () => fav_page.FavPage().seoController(context),
                ));
          },
          Routes.register: (context, state, data) {
            setupMetaTag(context);
            return BeamPage(
              key: const ValueKey(Routes.register),
              title: Routes.getWebsiteTitle(context),
              child: _buildDeferredScreen(register_page.loadLibrary,
                  () => register_page.RegisterPage()),
            );
          },
          Routes.login: (context, state, data) {
            setupMetaTag(context);
            return BeamPage(
                key: const ValueKey(Routes.login),
                title: Routes.getWebsiteTitle(context),
                child: _buildDeferredScreen(
                  login_page.loadLibrary,
                  () => login_page.LoginPage().seoController(context),
                ));
          },
          Routes.editAccount: (context, state, data) {
            setupMetaTag(context);
            return BeamPage(
                key: const ValueKey(Routes.editAccount),
                title: Routes.getWebsiteTitle(context),
                child: _buildDeferredScreen(
                  edit_account_page.loadLibrary,
                  () => edit_account_page.EditAccountPage()
                      .seoController(context),
                ));
          },
          Routes.reports: (context, state, data) {
            setupMetaTag(context);
            return BeamPage(
                key: const ValueKey(Routes.reports),
                title: Routes.getWebsiteTitle(context),
                child: _buildDeferredScreen(
                  raporty_page.loadLibrary,
                  () => raporty_page.RaportyPage().seoController(context),
                ));
          },
          Routes.learnCenter: (context, state, data) {
            setupMetaTag(context);
            return BeamPage(
                key: const ValueKey(Routes.learnCenter),
                title: Routes.getWebsiteTitle(context),
                child: _buildDeferredScreen(
                    learn_center_page.loadLibrary,
                    () => learn_center_page.LearnCenterPage()
                        .seoController(context)));
          },
          Routes.feedView: (context, state, data) {
            setupMetaTag(context);
            return BeamPage(
                key: const ValueKey(Routes.feedView),
                title: Routes.getWebsiteTitle(context),
                child: _buildDeferredScreen(
                  grid_page.loadLibrary,
                  () => grid_page.GridPage().seoController(context),
                ));
          },
          Routes.checkOut: (context, state, data) {
            setupMetaTag(context);
            return BeamPage(
                key: const ValueKey(Routes.checkOut),
                title: Routes.getWebsiteTitle(context),
                child: _buildDeferredScreen(
                  checkout_page.loadLibrary,
                  () => checkout_page.CheckoutPage().seoController(context),
                ));
          },
          Routes.success: (context, state, data) {
            setupMetaTag(context);
            return BeamPage(
                key: const ValueKey(Routes.success),
                title: Routes.getWebsiteTitle(context),
                child: _buildDeferredScreen(
                  success_page.loadLibrary,
                  () =>
                      success_page.PaymentSuccessPage().seoController(context),
                ));
          },
          Routes.basicview: (context, state, data) {
            setupMetaTag(context);
            return BeamPage(
                key: const ValueKey(Routes.basicview),
                title: Routes.getWebsiteTitle(context),
                child: _buildDeferredScreen(
                  basic_page.loadLibrary,
                  () => basic_page.BasicPage().seoController(context),
                ));
          },
          //does't know if correct
          Routes.aboutusview: (context, state, data) {
            setupMetaTag(context);
            return BeamPage(
                key: const ValueKey(Routes.aboutusview),
                title: Routes.getWebsiteTitle(context),
                child: _buildDeferredScreen(
                  about_us.loadLibrary,
                  () => about_us.BasicAboutUsPage().seoController(context),
                ));
          },
          Routes.profile: (context, state, data) {
            setupMetaTag(context);
            return BeamPage(
              key: const ValueKey(Routes.profile),
              title: Routes.getWebsiteTitle(context),
              child: _buildDeferredScreen(
                  profile_page.loadLibrary, () => profile_page.ProfilePage()),
            );
          },
          Routes.rentPage: (context, state, data) {
            setupMetaTag(context);
            return BeamPage(
              key: const ValueKey(Routes.rentPage),
              title: Routes.getWebsiteTitle(context),
              child: _buildDeferredScreen(rent_page.loadLibrary,
                  () => rent_page.RentPage().seoController(context)),
            );
          },
          Routes.sellPage: (context, state, data) {
            setupMetaTag(context);
            return BeamPage(
              key: const ValueKey(Routes.sellPage),
              title: Routes.getWebsiteTitle(context),
              child: _buildDeferredScreen(
                  sell_page.loadLibrary, () => sell_page.SellPage()),
            );
          },
          Routes.networkMonitoring: (context, state, data) {
            setupMetaTag(context);
            return BeamPage(
                key: const ValueKey(Routes.networkMonitoring),
                title: Routes.getWebsiteTitle(context),
                child: _buildDeferredScreen(
                  network_monitoring_page.loadLibrary,
                  () => network_monitoring_page.NetworkMonitoringPage(),
                ));
          },
          Routes.networkMonitoringSingle: (context, state, data) {
            final monitoringId = state.pathParameters['monitoringId']!;
            final networkTag = (data as Map)['tagNetworkPop'] as String? ?? '';
            final networkAd = (data)['adNetworkPop'] as MonitoringAdsModel?;

            setupMetaTag(context);

            if (networkTag.isEmpty) {
              return BeamPage(
                  key: const ValueKey(Routes.networkMonitoringSingle),
                  title: Routes.getWebsiteTitle(context),
                  child: _buildDeferredScreen(
                    nm_ad_provider.loadLibrary,
                    () => nm_ad_provider.NMAdFetcher(
                      adNetworkPop: int.parse(monitoringId),
                      tagNetworkPop: networkTag,
                    ),
                  ));
            } else {
              return BeamPage(
                  key: const ValueKey(Routes.networkMonitoringSingle),
                  title: Routes.getWebsiteTitle(context),
                  child: _buildDeferredScreen(
                    nm_feed_pop.loadLibrary,
                    () => nm_feed_pop.NMFeedPop(
                      adNetworkPop: networkAd!,
                      tagNetworkPop: networkTag,
                    ),
                  ));
            }
          },
          Routes.imageView: (context, state, data) {
            final tag = ((data as Map)['tag'] ?? '') as String;
            final initialPage = (data)['initialPage'] as int? ?? 0;
            final images = (data)['images'] as List<String>? ?? [];

            setupMetaTag(context);

            return BeamPage(
              key: const ValueKey(Routes.imageView),
              title: Routes.getWebsiteTitle(context),
              child: _buildDeferredScreen(
                nm_full_screen_image.loadLibrary,
                () => nm_full_screen_image.NMFullScreenImageView(
                  tag: tag,
                  images: images,
                  initialPage: initialPage,
                ),
              ),
              type: BeamPageType.fadeTransition,
            );
          },

          // Route: Pro Dashboard
          Routes.proDashboard: (context, state, data) {
            setupMetaTag(context);

            return BeamPage(
              key: const ValueKey(Routes.proDashboard),
              title: Routes.getWebsiteTitle(context),
              child: _buildDeferredScreen(dashboard_crm_page.loadLibrary,
                  () => dashboard_crm_page.DashboardCrmPage()),
            );
          },

          // Route: Pro Clients
          Routes.proClients: (context, state, data) {
            setupMetaTag(context);

            return BeamPage(
              key: const ValueKey(Routes.proClients),
              title: Routes.getWebsiteTitle(context),
              child: _buildDeferredScreen(
                clients_page.loadLibrary,
                () => clients_page.ClientsPage(),
              ),
            );
          },
          Routes.transaction: (context, state, data) {
            setupMetaTag(context);

            return BeamPage(
              key: const ValueKey(Routes.transaction),
              title: Routes.getWebsiteTitle(context),
              child: _buildDeferredScreen(transaction_screen.loadLibrary,
                  () => transaction_screen.TransactionScreen()),
            );
          },
          Routes.allTransaction: (context, state, data) {
            setupMetaTag(context);

            return BeamPage(
              key: const ValueKey(Routes.allTransaction),
              title: Routes.getWebsiteTitle(context),
              child: _buildDeferredScreen(mobile_all_transaction.loadLibrary,
                  () => mobile_all_transaction.MobileAllTransaction()),
              routeBuilder: (context, settings, child) =>
                  transparentRouteBuilder(context, settings, child),
            );
          },
          Routes.proFinance: (context, state, data) {
            setupMetaTag(context);
            return BeamPage(
                key: const ValueKey(Routes.proFinance),
                title: Routes.getWebsiteTitle(context),
                child: _buildDeferredScreen(
                  finance_crm_page.loadLibrary,
                  () => finance_crm_page.FinanceCrmPage(),
                ));
          },
          Routes.proDraggable: (context, state, data) {
            setupMetaTag(context);
            return BeamPage(
              key: const ValueKey(Routes.proDraggable),
              title: Routes.getWebsiteTitle(context),
              child: _buildDeferredScreen(finance_crm_page.loadLibrary,
                  () => finance_crm_page.FinanceCrmPage()),
            );
          },
          Routes.proPlans: (context, state, data) {
            setupMetaTag(context);
            return BeamPage(
              key: const ValueKey(Routes.proPlans),
              title: Routes.getWebsiteTitle(context),
              child: _buildDeferredScreen(
                agent_financial_plans.loadLibrary,
                () => agent_financial_plans.AgentFinancialPlansPage(),
              ),
            );
          },
          Routes.proTodo: (context, state, data) {
            setupMetaTag(context);
            return BeamPage(
              key: const ValueKey(Routes.proTodo),
              title: Routes.getWebsiteTitle(context),
              child: _buildDeferredScreen(
                todo_page.loadLibrary,
                () => todo_page.ToDoPage(),
              ),
            );
          },
          Routes.proBoard: (context, state, data) {
            setupMetaTag(context);
            return BeamPage(
              key: const ValueKey(Routes.proBoard),
              title: Routes.getWebsiteTitle(context),
              child: _buildDeferredScreen(
                board_page.loadLibrary,
                () => board_page.BoardPage(),
              ),
            );
          },
          // Route: Save Network Monitoring
          Routes.saveNetworkMonitoring: (context, state, data) {
            setupMetaTag(context);

            return BeamPage(
              key: const ValueKey(Routes.saveNetworkMonitoring),
              title: Routes.getWebsiteTitle(context),
              child: _buildDeferredScreen(
                list_with_save_search_screen.loadLibrary,
                () => list_with_save_search_screen.ListWithSaveSearchScreen(),
              ),
            );
          },

          // Example for a general lazy-loaded route
          Routes.proCalendar: (context, state, data) {
            setupMetaTag(context);

            return BeamPage(
              key: const ValueKey(Routes.proCalendar),
              title: Routes.getWebsiteTitle(context),
              child: _buildDeferredScreen(
                calendar_page.loadLibrary,
                () => calendar_page.AgentCalendarPage(),
              ),
            );
          },
          Routes.homeNetworkMonitoring: (context, state, data) {
            setupMetaTag(context);
            return BeamPage(
              key: const ValueKey(Routes.homeNetworkMonitoring),
              title: Routes.getWebsiteTitle(context),
              child: _buildDeferredScreen(monitoring_home_screen.loadLibrary,
                  () => monitoring_home_screen.MonitoringHomeScreen()),
            );
          },
          Routes.proAddClient: (context, state, data) {
            setupMetaTag(context);
            return BeamPage(
              key: const ValueKey(Routes.proAddClient),
              title: Routes.getWebsiteTitle(context),
              child: _buildDeferredScreen(add_client.loadLibrary,
                  () => add_client.AddClientPopPc()),
            );
          },
          Routes.proRegister: (context, state, data) {
            setupMetaTag(context);
            return BeamPage(
              key: const ValueKey(Routes.proRegister),
              title: Routes.getWebsiteTitle(context),
              child: _buildDeferredScreen(register_pro_pc_page.loadLibrary,
                  () => register_pro_pc_page.ProRegisterPcPage()),
            );
          },
          Routes.repeatWidget: (context, state, data) {
            setupMetaTag(context);
            return BeamPage(
              key: const ValueKey(Routes.repeatWidget),
              title: Routes.getWebsiteTitle(context),
              child: _buildDeferredScreen(repeat_widget.loadLibrary,
                  () => repeat_widget.RepeatWidget()),
            );
          },
          Routes.guestWidget: (context, state, data) {
            setupMetaTag(context);
            return BeamPage(
              key: const ValueKey(Routes.guestWidget),
              title: Routes.getWebsiteTitle(context),
              child: _buildDeferredScreen(
                  guest_widget.loadLibrary, () => guest_widget.GuestWidget()),
            );
          },
          Routes.fullmap: (context, state, data) {
            setupMetaTag(context);
            return BeamPage(
              key: const ValueKey(Routes.fullmap),
              title: Routes.getWebsiteTitle(context),
              child: _buildDeferredScreen(full_map_mobile.loadLibrary,
                  () => full_map_mobile.PvMobilePage()),
            );
          },
          Routes.mapView: (context, state, data) {
            setupMetaTag(context);
            return BeamPage(
              key: const ValueKey(Routes.mapView),
              title: Routes.getWebsiteTitle(context),
              child: _buildDeferredScreen(
                  map_view_page.loadLibrary, () => map_view_page.MapViewPage()),
            );
          },
          Routes.fullSize: (context, state, data) {
            setupMetaTag(context);
            return BeamPage(
              key: const ValueKey(Routes.fullSize),
              title: Routes.getWebsiteTitle(context),
              child: _buildDeferredScreen(full_size_page.loadLibrary,
                  () => full_size_page.FullSizePage()),
            );
          },
          Routes.listview: (context, state, data) {
            setupMetaTag(context);
            return BeamPage(
              key: const ValueKey(Routes.listview),
              title: Routes.getWebsiteTitle(context),
              child: _buildDeferredScreen(list_view_page.loadLibrary,
                  () => list_view_page.ListViewPage()),
            );
          },
          Routes.singeEditOffer: (context, state, data) {
            final offerId = int.parse(state.pathParameters['offerId']!);
            setupMetaTag(context);
            return BeamPage(
              key: const ValueKey(Routes.singeEditOffer),
              title: Routes.getWebsiteTitle(context),
              child: _buildDeferredScreen(edit_offer_page.loadLibrary,
                  () => edit_offer_page.EditOfferPage(offerId: offerId)),
            );
          },
          Routes.filters: (context, state, data) {
            setupMetaTag(context);
            return BeamPage(
              key: const ValueKey(Routes.filters),
              type: BeamPageType.fadeTransition, // Use built-in fade transition
              title: Routes.getWebsiteTitle(context),
              child: _buildDeferredScreen(
                  filters_page.loadLibrary, () => filters_page.FiltersPage()),
            );
          },
          Routes.articlePop: (context, state, data) {
            final articles = ((data as Map)['articles'] ?? '') as Article;
            final tagArticlesPop = (data)['tagArticlesPop'] as String;

            setupMetaTag(context);
            return BeamPage(
                key: const ValueKey(Routes.articlePop),
                title: Routes.getWebsiteTitle(context),
                child: _buildDeferredScreen(
                  article_pop_page.loadLibrary,
                  () => article_pop_page.ArticlePop(
                    articlePop: articles,
                    tagArticlePop: tagArticlesPop,
                  ),
                ));
          },
          Routes.pdfPreview: (context, state, data) {
            final singleBillItem =
                ((data as Map)['singleBillItem'] ?? '') as BillModel;

            setupMetaTag(context);
            return BeamPage(
              key: const ValueKey(Routes.pdfPreview),
              title: Routes.getWebsiteTitle(context),
              child: _buildDeferredScreen(preview_page.loadLibrary,
                  () => preview_page.PdfPreviewPage(bill: singleBillItem)),
            );
          },
          Routes.detail: (context, state, data) {
            final singleBillItem =
                ((data as Map)['singleBillItem'] ?? '') as BillModel;

            setupMetaTag(context);
            return BeamPage(
              key: const ValueKey(Routes.detail),
              title: Routes.getWebsiteTitle(context),
              child: _buildDeferredScreen(detail.loadLibrary,
                  () => detail.DetailPage(singleBillItem: singleBillItem)),
            );
          },
          Routes.viewPopChanger: (context, state, data) {
            setupMetaTag(context);
            return BeamPage(
              key: const ValueKey(Routes.viewPopChanger),
              title: Routes.getWebsiteTitle(context),
              child: _buildDeferredScreen(view_pop_changer.loadLibrary,
                  () => view_pop_changer.ViewPopPageChangerCrmFinance()),
            );
          },

          Routes.statusPopRevenue: (context, state, data) {
            setupMetaTag(context);
            return BeamPage(
              key: const ValueKey(Routes.statusPopRevenue),
              title: Routes.getWebsiteTitle(context),
              child: _buildDeferredScreen(
                status_revenue_pop.loadLibrary,
                () => status_revenue_pop.StatusPopRevenue(),
              ),
            );
          },
          Routes.statusPopExpenses: (context, state, data) {
            setupMetaTag(context);
            return BeamPage(
              key: const ValueKey(Routes.statusPopExpenses),
              title: Routes.getWebsiteTitle(context),
              child: _buildDeferredScreen(
                status_expenses_pop.loadLibrary,
                () => status_expenses_pop.StatusPopExpenses(),
              ),
            );
          },
          Routes.crmEditSell: (context, state, data) {
            final offerId = ((data as Map)['offerId'] ?? '') as int;

            setupMetaTag(context);
            return BeamPage(
              key: const ValueKey(Routes.crmEditSell),
              title: Routes.getWebsiteTitle(context),
              child: _buildDeferredScreen(
                crm_edit_offer_page.loadLibrary,
                () =>
                    crm_edit_offer_page.CrmEditSellOfferPage(offerId: offerId),
              ),
            );
          },
          Routes.customRepeat: (context, state, data) {
            setupMetaTag(context);
            return BeamPage(
              key: const ValueKey(Routes.customRepeat),
              title: Routes.getWebsiteTitle(context),
              child: _buildDeferredScreen(
                custom_repeat_widget.loadLibrary,
                () => custom_repeat_widget.CustomRepeatWidget(),
              ),
            );
          },
          Routes.proFinanceRevenueAdd: (context, state, data) {
            setupMetaTag(context);
            return BeamPage(
              key: const ValueKey(Routes.proFinanceRevenueAdd),
              title: Routes.getWebsiteTitle(context),
              child: _buildDeferredScreen(
                add_field.loadLibrary,
                () => add_field.CrmAddPopPc(initialForm: 'AddViewerForm'),
              ),
            );
          },
          Routes.addClientForm: (context, state, data) {
            setupMetaTag(context);
            return BeamPage(
              key: const ValueKey(Routes.addClientForm),
              title: Routes.getWebsiteTitle(context),
              child: _buildDeferredScreen(
                add_client_form.loadLibrary,
                    () => add_client_form.AddClientFormScreen(),
              ),
            );
          },
          // Routes.chatMobile: (context, state, data) {
          //   setupMetaTag(context);
          //   return BeamPage(
          //     key: const ValueKey(Routes.chatMobile),
          //     title: Routes.getWebsiteTitle(context),
          //     child: ChatScreenPc(),
          //   );
          // },
          // Routes.chatScreenMobile: (context, state, data) {
          //   final selectedRoomId =
          //       ((data as Map)['selectedRoomId'] ?? '') as String;
          //
          //   setupMetaTag(context);
          //   return BeamPage(
          //     key: const ValueKey(Routes.chatScreenMobile),
          //     type: BeamPageType.fadeTransition,
          //     title: Routes.getWebsiteTitle(context),
          //     child: ChatScreenMobilePage(
          //       key: ValueKey(data['selectedRoomId']),
          //       channel: data['channel'],
          //       username: data['username'],
          //       roomId: data['selectedRoomId'],
          //     ),
          //   );
          // },
          // Routes.feedPop: (context, state, data) {
          //   final feedAdId = state.pathParameters['adId']!;
          //   final tag = ((data as Map)['tag'] ?? '') as String;
          //   final feedAd = (data)['ad'] as AdsListViewModel;
          //
          //   if (tag.isEmpty) {
          //     setupMetaTag(context);
          //     return TransparentBeamPage(
          //       key: const ValueKey(Routes.adSingle),
          //       name: Routes.adSingle,
          //       child: AdFetcher(feedAdId: feedAdId as int, tag: tag),
          //     );
          //   } else {
          //     setupMetaTag(context);
          //     return TransparentBeamPage(
          //       key: const ValueKey(Routes.adSingle),
          //       name: Routes.adSingle,
          //       child: _buildDeferredScreen(feed_pop.loadLibrary, () => feed_pop.FeedPopPage(adFeedPop: feedAd, tagFeedPop: tag),),
          //     );
          //   }
          // },
          Routes.registerPop: (context, state, data) {
            setupMetaTag(context);
            return BeamPage(
              key: const ValueKey(Routes.registerPop),
              title: Routes.getWebsiteTitle(context),
              child: _buildDeferredScreen(
                register_pc_pop.loadLibrary,
                () => register_pc_pop.RegisterPcPop(),
              ),
            );
          },
          Routes.sortPop: (context, state, data) {
            setupMetaTag(context);
            return BeamPage(
              key: const ValueKey(Routes.sortPop),
              type: BeamPageType.fadeTransition,
              title: Routes.getWebsiteTitle(context),
              child: _buildDeferredScreen(
                sort_pop_page.loadLibrary,
                () => sort_pop_page.SortPopPage(),
              ),
              routeBuilder: (context, state, child) {
                return PageRouteBuilder(
                  pageBuilder: (_, animation, __) => FadeTransition(
                    opacity: animation,
                    child: child,
                  ),
                  opaque: false, // Make the page non-opaque
                );
              },
            );
          },
          Routes.sortPopMobile: (context, state, data) {
            setupMetaTag(context);

            return BeamPage(
              key: const ValueKey(Routes.sortPopMobile),
              type: BeamPageType.fadeTransition,
              title: Routes.getWebsiteTitle(context),
              child: _buildDeferredScreen(
                sort_pop_mobile_page.loadLibrary,
                () => sort_pop_mobile_page.SortPopMobilePage(),
              ),
            );
          },
          Routes.loginPop: (context, state, data) {
            setupMetaTag(context);

            return BeamPage(
              key: const ValueKey(Routes.loginPop),
              type: BeamPageType.fadeTransition,
              title: Routes.getWebsiteTitle(context),
              child: _buildDeferredScreen(
                login_pop_page.loadLibrary,
                () => login_pop_page.LoginPopPage(),
              ),
            );
          },
          // Routes.profile: (context, state, data) {
          //   setupMetaTag(context);
          //
          //   return BeamPage(
          //     key: const ValueKey(Routes.profile),
          //     type: BeamPageType.fadeTransition,
          //     title: Routes.getWebsiteTitle(context),
          //     child: const ProfilePage(),
          //   );
          // },
          Routes.mobilePop: (context, state, data) {
            setupMetaTag(context);

            return BeamPage(
              key: const ValueKey(Routes.mobilePop),
              type: BeamPageType.fadeTransition,
              title: Routes.getWebsiteTitle(context),
              child: _buildDeferredScreen(
                mobile_pop_appbar_page.loadLibrary,
                () => mobile_pop_appbar_page.MobilePopAppBarPage(),
              ),
            );
          },

          Routes.proSingleClient: (context, state, data) =>
              clientViewPage(state, context, data),
          Routes.proCalenderClient: (context, state, data) =>
              clientViewPage(state, context, data),
          Routes.proDashboardClient: (context, state, data) =>
              clientViewPage(state, context, data),
          Routes.proPlansClient: (context, state, data) =>
              clientViewPage(state, context, data),
          Routes.proFinanceClient: (context, state, data) =>
              clientViewPage(state, context, data),
          Routes.proHomeNetworkClient: (context, state, data) =>
              clientViewPage(state, context, data),
          Routes.proSaveNetworkClient: (context, state, data) =>
              clientViewPage(state, context, data),
          Routes.networkMonitoringClient: (context, state, data) =>
              clientViewPage(state, context, data),
          Routes.proTodoClient: (context, state, data) =>
              clientViewPage(state, context, data),
          Routes.adFeedView: (context, state, data) =>
              adViewPage(state, context, data),
          Routes.adHomePage: (context, state, data) =>
              adViewPage(state, context, data),
          Routes.adProfile: (context, state, data) =>
              adViewPage(state, context, data),
          Routes.adFav: (context, state, data) =>
              adViewPage(state, context, data),
          Routes.adMapView: (context, state, data) =>
              adViewPage(state, context, data),
          Routes.adListView: (context, state, data) =>
              adViewPage(state, context, data),
          Routes.adFullSize: (context, state, data) =>
              adViewPage(state, context, data),
        },
      ).call,
    );

BeamPage clientViewPage(BeamState state, BuildContext context, dynamic data) {
  final clientId = int.parse(state.pathParameters['clientId']!);
  final activeSectionFetch = state.pathParameters['activeSection'] ??
      'dashboard'; //change to production set directory to dashboard
  final activeAdFetch = state.pathParameters['activeAd'] ?? 'dashboard';

  if (data == null) {
    return BeamPage(
      key: const ValueKey(Routes.proSingleClient),
      title: Routes.getWebsiteTitle(context),
      child: _buildDeferredScreen(
        client_fetcher.loadLibrary,
        () => client_fetcher.ClientsFetcher(
          clientId: clientId,
          tagClientViewPop: '',
          activeSection: activeSectionFetch,
          activeAd: activeAdFetch,
        ),
      ),
      routeBuilder: (context, settings, child) =>
          transparentRouteBuilder(context, settings, child),
    );
  }

  setupMetaTag(context);

  final clientViewPop =
      ((data as Map)['clientViewPop'] ?? '') as UserContactModel;
  final activeSection = ((data)['activeSection'] ?? '') as String;
  final activeAd = ((data)['activeAd'] ?? '') as String;
  final tagClientViewPop = ((data)['tagClientViewPop'] ?? '') as String;

  if (tagClientViewPop.isEmpty) {
    return BeamPage(
      key: const ValueKey(Routes.proSingleClient),
      title: Routes.getWebsiteTitle(context),
      child: _buildDeferredScreen(
        client_fetcher.loadLibrary,
        () => client_fetcher.ClientsFetcher(
          clientId: clientId,
          tagClientViewPop: '',
          activeSection: activeSectionFetch,
          activeAd: activeAdFetch,
        ),
      ),
      routeBuilder: (context, settings, child) =>
          transparentRouteBuilder(context, settings, child),
    );
  } else {
    final clientViewPop = ((data)['clientViewPop'] ?? '') as UserContactModel;
    return BeamPage(
      key: const ValueKey(Routes.proSingleClient),
      title: Routes.getWebsiteTitle(context),
      child: client_view_page.ClientsViewPop(
        clientViewPop: clientViewPop,
        tagClientViewPop: tagClientViewPop,
        activeSection: activeSection,
        activeAd: activeAd,
      ),
      routeBuilder: (context, settings, child) =>
          transparentRouteBuilder(context, settings, child),
    );
  }
}

BeamPage adViewPage(BeamState state, BuildContext context, dynamic data) {
  final feedAdId = int.parse(state.pathParameters['id']!);
  final route = state.pathParameters['route'];

  if (data == null) {
    setupMetaTag(context);
    return BeamPage(
      key: ValueKey('commonPagfeed_pop.e-$route-$feedAdId'),
      title: 'AD',
      child: _buildDeferredScreen(ad_provider.loadLibrary,
          () => ad_provider.AdFetcher(feedAdId: feedAdId, tag: '')),
      routeBuilder: (context, settings, child) =>
          transparentRouteBuilder(context, settings, child),
    );
  }

  final tag = ((data as Map)['tag'] ?? '') as String;
  final feedAd = (data)['ad'] as AdsListViewModel;

  if (tag.isEmpty) {
    setupMetaTag(context);
    return BeamPage(
      key: ValueKey('commonPage-$route-$feedAdId'),
      title: 'AD',
      child: _buildDeferredScreen(
        ad_provider.loadLibrary,
        () => ad_provider.AdFetcher(feedAdId: feedAdId, tag: tag),
      ),
      routeBuilder: (context, settings, child) =>
          transparentRouteBuilder(context, settings, child),
    );
  } else {
    setupMetaTag(context);
    return BeamPage(
      key: ValueKey('commonPage-$route-$feedAdId'),
      title: 'AD',
      child: _buildDeferredScreen(
        feed_pop.loadLibrary,
        () => feed_pop.FeedPopPage(adFeedPop: feedAd, tagFeedPop: tag),
      ),
      routeBuilder: (context, settings, child) =>
          transparentRouteBuilder(context, settings, child),
    );
  }
}

PageRouteBuilder<dynamic> transparentRouteBuilder(
  BuildContext context,
  RouteSettings settings,
  Widget child,
) {
  return PageRouteBuilder(
    settings: settings,
    pageBuilder: (context, animation, secondaryAnimation) => child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(parent: animation, curve: Curves.easeOut),
        ),
        child: child,
      );
    },
    opaque: false,
    barrierColor: Colors.transparent,
  );
}
