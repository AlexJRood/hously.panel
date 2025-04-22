import 'package:beamer/beamer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hously_flutter/modules/leads/utils/lead_model.dart';
import 'package:hously_flutter/routing/route_constant.dart';
import 'package:hously_flutter/utils/extensions/seo.dart';
import 'package:hously_flutter/modules/articles_managment/models/article_model.dart';
import 'package:hously_flutter/routing/router_observer.dart';


//////////////////////STARTIN PAGE//////////////////////////////
import 'package:hously_flutter/modules/login/login_page.dart'
    deferred as login_page;


import 'package:hously_flutter/modules/leads/screens/lead_list.dart'
    deferred as lead_page;

import 'package:hously_flutter/modules/leads/screens/board_screen.dart'
    deferred as lead_board;

import 'package:hously_flutter/modules/leads/screens/lead_details.dart'
    deferred as single_lead;

import 'package:hously_flutter/modules/mail_view/lead_mail.dart'
    deferred as lead_mail;

import 'package:hously_flutter/modules/mail_view/mail.dart'
    deferred as mail_admin;



import 'package:hously_flutter/modules/leads/screens/lead_add.dart'
    deferred as add_lead;




import 'package:hously_flutter/modules/todo/board/board_page.dart'
    deferred as board_page;
import 'package:hously_flutter/modules/todo/todo_page.dart'
    deferred as todo_page;


import 'package:hously_flutter/modules/nm_managment/pc.dart'
    deferred as nm_managment;



/////////////////////// REBUILD FOR ADDING ARTICLES ///////////////////////
import 'package:hously_flutter/modules/articles_managment/screens/article_pop_page.dart'
    deferred as article_pop_page;


import 'package:hously_flutter/modules/calendar/calendar_page.dart'
    deferred as calendar_page;


import 'package:hously_flutter/modules/about_us_managment/about_us_main.dart'
    deferred as about_us;


import 'package:hously_flutter/modules/login/edit_account_page.dart'
    deferred as edit_account_page;
import 'package:hously_flutter/modules/login/reset/reset_password_page.dart'
    deferred as forgot_password;



import 'package:hously_flutter/modules/settings/settings_page.dart'
    deferred as settings_page;


import 'package:hously_flutter/modules/calendar/widgets/calendar_search_screen_widget.dart'
    deferred as calendar_search_screen_widget;

    

import 'package:hously_flutter/modules/calendar/widgets/custom_repeat_widget.dart'
    deferred as custom_repeat_widget;
import 'package:hously_flutter/modules/calendar/widgets/events/event_widget.dart'
    deferred as event_widget;
import 'package:hously_flutter/modules/calendar/widgets/events/guest_widget.dart'
    deferred as guest_widget;
import 'package:hously_flutter/modules/calendar/widgets/events/repeat_widget.dart'
    deferred as repeat_widget;
import 'package:hously_flutter/modules/settings/settings_router.dart'
    deferred as settings_page_router;

    
import 'package:meta_seo/meta_seo.dart';
import 'package:sentry_flutter/sentry_flutter.dart';




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
                  login_page.loadLibrary, () => login_page.LoginPage()),
            );
          },

          



          Routes.leadsPanel: (context, state, data) {
            setupMetaTag(context);
            return BeamPage(
              key: const ValueKey(Routes.leadsPanel),
              title: Routes.getWebsiteTitle(context),
              child: _buildDeferredScreen(
                  lead_page.loadLibrary, () => lead_page.LeadsPage()),
            );
          },

          Routes.leadsBoard: (context, state, data) {
            setupMetaTag(context);
            return BeamPage(
              key: const ValueKey(Routes.leadsBoard),
              title: Routes.getWebsiteTitle(context),
              child: _buildDeferredScreen(
                  lead_board.loadLibrary, () => lead_board.DraggableBoardPc()),
            );
          },

          
          Routes.singleLeadBoard: (context, state, data) {
            final id = int.parse(state.pathParameters['id']!);

            setupMetaTag(context);
            return BeamPage(
              key: const ValueKey(Routes.singleLead),
              title: Routes.getWebsiteTitle(context),
              child: _buildDeferredScreen(
                  single_lead.loadLibrary, () => single_lead.LeadDetailsPage(leadId: id)),
            );
          },


          Routes.singleLead: (context, state, data) {
            final id = int.parse(state.pathParameters['id']!);

            setupMetaTag(context);
            return BeamPage(
              key: const ValueKey(Routes.singleLead),
              title: Routes.getWebsiteTitle(context),
              child: _buildDeferredScreen(
                  single_lead.loadLibrary, () => single_lead.LeadDetailsPage(leadId: id)),
            );
          },


          Routes.leadEmailView: (context, state, data) {
            final id = int.parse(state.pathParameters['id']!);
            final lead = data is Lead ? data : null;

            setupMetaTag(context);
            return BeamPage(
              key: const ValueKey(Routes.leadEmailView),
              title: Routes.getWebsiteTitle(context),
              child: _buildDeferredScreen(
                  mail_admin.loadLibrary, () => mail_admin.EmailView(leadId: id, lead: lead)),
            );
          },


          Routes.emailView: (context, state, data) {
            setupMetaTag(context);
            return BeamPage(
              key: const ValueKey(Routes.emailView),
              title: Routes.getWebsiteTitle(context),
              child: _buildDeferredScreen(
                  mail_admin.loadLibrary, () => mail_admin.EmailView(leadId: null)),
            );
          },





          Routes.addLead: (context, state, data) {

            setupMetaTag(context);
            return BeamPage(
              key: const ValueKey(Routes.addLead),
              title: Routes.getWebsiteTitle(context),
              child: _buildDeferredScreen(
                  add_lead.loadLibrary, () => add_lead.AddLeadPage()),
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



          Routes.NetworkMonitorigManagment: (context, state, data) {
            setupMetaTag(context);
            return BeamPage(
              key: const ValueKey(Routes.NetworkMonitorigManagment),
              title: Routes.getWebsiteTitle(context),
              child: _buildDeferredScreen(
                  nm_managment.loadLibrary, () => nm_managment.NetworkMonitoringManagment()),
            );
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
          Routes.settingsEmail: (context, state, data) {
            setupMetaTag(context);
            return BeamPage(
                key: const ValueKey(Routes.settingsEmail),
                title: Routes.getWebsiteTitle(context),
                child: _buildDeferredScreen(settings_page_router.loadLibrary,
                    () => settings_page_router.SettingsEmailPageRouter()));
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


          Routes.forgotpassword: (context, state, data) {
            setupMetaTag(context);
            return BeamPage(
                key: const ValueKey(Routes.forgotpassword),
                title: Routes.getWebsiteTitle(context),
                child: _buildDeferredScreen(
                    forgot_password.loadLibrary,
                    () => forgot_password.ResetPasswordPage()
                        .seoController(context)));
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
          Routes.calendarSearchScreen: (context, state, data) {
            setupMetaTag(context);

            return BeamPage(
              key: const ValueKey(Routes.calendarSearchScreen),
              title: Routes.getWebsiteTitle(context),
              child: _buildDeferredScreen(
                calendar_search_screen_widget.loadLibrary,
                () =>
                    calendar_search_screen_widget.CalendarSearchScreenWidget(),
              ),
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

          







        },
      ).call,
    );



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
