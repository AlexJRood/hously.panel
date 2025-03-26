import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:hously_flutter/const/strings_const.dart';

class Routes {
  static const entry = '/';
  static const needDescriptionMeta = 'Need An App build flutter app';
  static const tester = '/tester';
  static const profile = '/profile';
  static const homepage = '/homepage';
  static const eventWidget = '/event-widget';
  static const settings = '/settings';
    static const addCard = '/addcard';
     static const addpayment = '/addpayment';
      static const twostep = '/two-step';
  static const settingsprofile = '/settings/profile';
  static const settingsnotification = '/settings/notification';
  static const settingssecurity = '/settings/security';
  static const settingspayments = '/settings/payments';
  static const settingslanguage = '/settings/language';
  static const settingstheme = '/settings/theme';
  static const settingschat = '/settings/chat';
  static const settingsupport = '/settings/support';
    static const settinglogout = '/settings/logout';
  static const add = '/add';
  static const fav = '/fav';
  static const register = '/register';
  static const login = '/login';
  static const editAccount = '/editAccount';
  static const reports = '/reports';
  static const learnCenter = '/learnCenter';
  static const sellPage = '/sprzedaj-nieruchomosc';
  static const rentPage = '/wynajmnij-nieruchomość';
  static const feedView = '/feedview';
  static const adFeedView = '$feedView/:id';
  static const adHomePage = '$homepage/:id';
  static const adProfile = '$profile/:id';
  static const adFav = '$fav/:id';
  static const adMapView = '$mapView/:id';
  static const adListView = '$listview/:id';
  static const adFullSize = '$fullSize/:id';
  static const basicviewAd = '$basicview/:id';



//////////////////////////NETWORK MONITORING///////////////////////////////////
  static const networkMonitoring = '/network-monitoring';
  static const homeNetworkMonitoring = '/home-network-monitoring';
  static const saveNetworkMonitoring = '/save-network-monitoring';

  static const networkMonitoringSingle = '$networkMonitoring/:offer/:id';
  static const nmAdHomePage = '$homeNetworkMonitoring/:offer/:id';
  // static const nmAdFeedView = '$networkMonitoring/offer/:monitoringId';


///////CLIENTS
  static const proHomeNetworkClient = '$homeNetworkMonitoring/:clientId/:activeSection';
  static const proSaveNetworkClient = '$saveNetworkMonitoring/:clientId/:activeSection';
  static const networkMonitoringClient ='$networkMonitoring/client/:clientId/:activeSection';




  static const fullSize = '/full-size';
  static const listview = '/listview';
  static const mapView = '/mapview';
  static const basicview = '/basicview';
  static const aboutusview = '/aboutusview';
  static const fullmap = '/fullmap';
  static const proRegister = '/pro/register';
  static const goPro = '/go-pro';
    static const forgotpassword = '/forgotpassword';
  static const checkOut = '/checkout';
  static const success = '/success';
  static const chat = '/chat';
  static const registerPop = '/register-pop';
  static const imageView = '/image-view';
  static const fullImage = '/full-image';
  static const proDashboard = '/pro/dashboard';
  static const proFinance = '/pro/finance';
  static const proDraggable = '/pro/finance/draggable';
  static const proPlans = '/pro/finance/plans';
  static const proTodo = '/pro/todo';
  static const proBoard = '/pro/board';
  static const proCalendar = '/pro/calendar';
  static const calendarSearchScreen = '$proCalendar/calendar-search-screen';
  static const proClients = '/pro/clients';
  static const repeatWidget = '/repeat-widget';
  static const guestWidget = '/guest-widget';
  static const editOffer = '/edit-offer';
  static const singeEditOffer = '/edit-offer/:offerId';
  static const mobilePop = '/mobile-pop';
  static const chatWrapper = '/chat-wrapper';
  static const filters = '/filters';
  static const articlePop = '/article-pop';
  static const pdfPreview = '/pdf-preview';
  static const detail = '/detail';
  static const viewPopChanger = '/view-pop-changer';
  static const clientsViewFull = '/clients-view-full';
  static const statusPopRevenue = '/status-pop-revenue';
  static const statusPopExpenses = '/status-pop-expenses';
  static const crmEditSell = '/crm-edit-sell';
  static const chatMobile = '/chat-mobile';
  static const chatScreenMobile = '/chat-screen-mobile';
  static const feedPop = '/feed-pop';
  static const sortPopMobile = '/sort-pop-mobile';
  static const sortPop = '/sort-pop';
  static const loginPop = '/login-pop';
  static const customRepeat = '/custom-repeat';
  static const chatAi = '/chat-ai';

  static const proSingleClient = '$proClients/:clientId/:activeSection';
  static const proCalenderClient = '$proCalendar/:clientId/:activeSection';
  static const proDashboardClient = '$proDashboard/:clientId/:activeSection';
  static const proPlansClient = '$proPlans/:clientId/:activeSection';
  static const proFinanceClient = '$proFinance/:clientId/:activeSection';
  static const proTodoClient = '$proTodo/:clientId/:activeSection';
  static const proFinanceCosts = 'pro/finance/costs/add';
  static const proFinanceRevenue = '/pro/finance/revenue';
  static const proFinanceRevenueAdd = '/pro/finance/revenue/add/AddViewerForm';
  static const proAddClient = '/pro/add/client';
  static const transaction = '$proSingleClient/:transactionid';
  static const allTransaction = '$proSingleClient/alltransaction';
  
  
  static const addClientForm = '/add-client';
  static const addClientFormDashboard = '$proDashboard$addClientForm';
  static const addClientFormFinance = '$proFinance$addClientForm';
  static const addClientFormCalendar = '$proCalendar$addClientForm';
  static const addClientFormToDo = '$proTodo$addClientForm';
  static const addClientFormClientList = '$proSingleClient$addClientForm';



  /// To handle the cookies
  // static const paths = [Routes.entry];

  static String getWebsiteTitle(BuildContext context) {
    final state = Beamer.of(context).currentBeamLocation.state as BeamState;
    final path = state.routeInformation.uri.path;
    final routeTitle = _allWebsiteTitles[path];

    if (routeTitle != null) {
      return '${StringsConst.websiteTitle} | $routeTitle';
    } else {
      return StringsConst.websiteTitle;
    }
  }

// static String getCourseEntityRoute({
//   required String courseId,
//   required String? courseEntityId,
// }) =>
//     courseEntityId == null
//         ? '${Routes.courses}/$courseId'
//         : '${Routes.courses}/$courseId/$courseEntityId';
//
// static String getCourseRoute({required String courseId}) =>
//     '${Routes.courses}/$courseId';
//
// static String getCertificateRoute({required String certificateId}) =>
//     '${Routes.certificates}/$certificateId';
//
// static String getVerifyCertificateRoute({required String certificateId}) =>
//     '${Routes.verifyCertificate}?id=$certificateId';
}

/// Home title also needs to be updated for both tags inside: web/index.html
/// 1) title tag
/// 2) meta tag named 'apple-mobile-web-app-title'
/// Reason: Home title needs to be more promotional since it is displayed in search engines!
const _homeTitle = StringsConst.publicTitle;

final Map<String, String> _allWebsiteTitles = {
  Routes.entry: _homeTitle,
  Routes.profile: 'Profile',
  Routes.homepage: 'Home Page',
  Routes.eventWidget: 'Event',
  Routes.settings: 'Settings',
  Routes.add: 'Add Offer',
  Routes.fav: 'Favorite',
  Routes.register: 'Register',
  Routes.login: 'Login',
  Routes.editAccount: 'Edit Account',
  Routes.reports: 'Raporty',
  Routes.learnCenter: 'Learn Center',
  Routes.sellPage: 'Sell',
  Routes.rentPage: 'Rent',
  Routes.networkMonitoring: 'Network Monitoring',
  Routes.networkMonitoringSingle: 'Network Monitoring',
  Routes.homeNetworkMonitoring: 'Home Network Monitoring',
  Routes.saveNetworkMonitoring: 'Save Network Monitoring',
  Routes.fullSize: 'Full Size',
  Routes.basicview: 'Basic View',
  Routes.basicviewAd: 'Basic View Ad',
  Routes.aboutusview: 'About Us View',
  Routes.listview: 'List',
  Routes.mapView: 'Map',
  Routes.feedView: 'Feed',
  Routes.fullmap: 'Full Map',
  Routes.proRegister: 'Pro Register',
  Routes.goPro: 'Go Pro',
  Routes.chat: 'Chat',
  Routes.sortPop: 'Sort Pop',
  Routes.registerPop: 'Register',
  Routes.imageView: 'Image View',
  Routes.fullImage: 'Full Image',
  Routes.proDashboard: 'Pro Dashboard',
  Routes.proFinance: 'Pro Finance',
  Routes.proDraggable: 'Pro Draggable',
  Routes.proPlans: 'Pro Plans',
  Routes.proTodo: 'Pro Todo',
  Routes.proCalendar: 'Pro Calendar',
  Routes.proClients: 'Pro Clients',
  Routes.proAddClient: 'Pro Add Client',
  Routes.repeatWidget: 'Repeat Widget',
  Routes.guestWidget: 'Guest Widget',
  Routes.editOffer: 'Edit Offer',
  Routes.singeEditOffer: 'Edit Offer',
  Routes.mobilePop: 'Mobile Pop',
  Routes.chatWrapper: 'Chat Wrapper',
  Routes.filters: 'Filters',
  Routes.articlePop: 'Article Pop',
  Routes.pdfPreview: 'PDF Preview',
  Routes.detail: 'Details',
  Routes.viewPopChanger: 'View Pop Changer',
  Routes.clientsViewFull: 'Client View',
  Routes.statusPopRevenue: 'Status Pop Revenue',
  Routes.statusPopExpenses: 'Status Pop Expenses',
  Routes.crmEditSell: 'CRM Edit Sell',
  Routes.chatMobile: 'Chat Mobile',
  Routes.chatScreenMobile: 'Chat Screen Mobile',
  Routes.feedPop: 'Feed Pop',
  Routes.sortPopMobile: 'Sort Pop Mobile',
  Routes.loginPop: 'Login Pop',
  Routes.success: 'Success',
  Routes.customRepeat: 'Custom Repeat',
  Routes.proSingleClient: 'Single Client',
  Routes.proFinanceCosts: 'Finance Cost',
  Routes.proFinanceRevenue: 'Finance Revenue',
  Routes.proFinanceRevenueAdd: 'Add Finance Revenue',
};
