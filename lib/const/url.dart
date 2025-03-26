// lib/safehouse/url.dart

class URLs {
  //production set up

  static const baseUrl = 'https://www.hously.cloud';
  static const httpOrHttps = 'https';
  static const webSocketUrl = 'wss://www.hously.cloud';
  static const urlNetworkMonitoring = 'http://www.hously.space';

  /// Append base url
  static String appendBaseUrl(String url) => '$baseUrl$url';

  /// Sub URL
  ///
  ///
  ///
  ///
  ///
  ////////////////////////////////// User url's //////////////////////////////////
  ///
  /// Fetch user profile
  static final userProfile = appendBaseUrl('/user/profile/');

  static String avatar(String userDetails) => appendBaseUrl(userDetails);

  /// Fetch user public profile
  static String singleSeller(String sellerId) =>
      appendBaseUrl('/user/seller/$sellerId/');

  /// Login
  static final restAuthLogin = appendBaseUrl('/user/login/');

  /// Register
  static final register = appendBaseUrl('/user/register/');

  /// Pro user register
  static final proRegister = appendBaseUrl('/user/pro-register/');

  /// Edit user
  static final editProfile = appendBaseUrl('/user/edit-account/');

  ///
  /// Social login
  static final restAuthApple = appendBaseUrl('/login/apple/');
  static final restAuthFacebook = appendBaseUrl('/login/facebook/');
  static final restAuthGoogle = appendBaseUrl('/login/google/');

  ///
  ///
  ///
  ///
  ///
  ////////////////////////////////// Chat url's //////////////////////////////////
  ///
  /// Fetch rooms
  static final rooms = appendBaseUrl('/chat/rooms/');

  /// Create room
  static final roomsCreate = appendBaseUrl('/chat/rooms/create/');

  ///
  ///
  static final adRoomsCreate = appendBaseUrl('/chat/rooms/');
  ///
  /// Fetch messages
  static String getRoomMessages(String roomId) =>
      appendBaseUrl('/chat/rooms/$roomId/messages/');

  /// Update messages
  static String chatUpdateMessage(String messageId) =>
      appendBaseUrl('/messages/update-message/$messageId/');

  /// Update messages
  static String chatUpdateMessageWithFile(String fileId) =>
      appendBaseUrl('/messages/update-message/$fileId/');

  ///
  /// Search in chat
  static final chatSearch = appendBaseUrl('/chat/search/');

  /// Web sockets url's
  static String webSocketChat(String roomId, String token) =>
      '$webSocketUrl/ws/chat/$roomId/?token=$token';

  ///
  ///
  ///
  ///
  ///
  ////////////////////////////////// Gpt url's //////////////////////////////////
  ///
  /// Send message to gpt get response from request
  static final gptChatBot = appendBaseUrl('/chat/chatbot/');

  ///
  ///
  ///
  ///
  ///
  ////////////////////////////////// Offers url's //////////////////////////////////
  ///
  static String offerImage(String url) => appendBaseUrl(url);

  static String updateOffer(String offerId) =>
      appendBaseUrl('/portal/draft/advertisements/update/$offerId/');
  static final addDraftAdvertisement =
      appendBaseUrl('/portal/draft/add_advertisement/');

  static String draftAdvertisement(String adId) =>
      appendBaseUrl('/portal/draft/advertisements/$adId');

  ///
  ///
  ///
  ///
  ///
  ////////////////////////////////// Estate agent crm url's //////////////////////////////////
  ///
  /// Fetch list of draft advertisments (GET)
  static final estateAgentAdvertismentDrafts =
      appendBaseUrl('/portal/draft/advertisements/');

  /// Fetch single draft advertisement (GET)
  static String singleEstateAgentAdvertismentDraft(String offerId) =>
      appendBaseUrl('/portal/draft/advertisements/$offerId/');

  /// Create advertisment draft (POST)
  static final createEstateAgentAdvertismentDraft =
      appendBaseUrl('/portal/draft/add_advertisement/');

  /// Fetch single draft advertisement (PATCH)
  static String updateEstateAgentAdvertismentDraft(String offerId) =>
      appendBaseUrl('/portal/draft/advertisements/update/$offerId/');

  ///
  ///
  /// Fetch agent transactions (GET)
  static final agentTransactionsCrm = appendBaseUrl('/agent/transaction/');

  /// Fetch agent transaction by client (userContact) (GET)
  static String agentTransactionByUserContact(String clientId) =>
      appendBaseUrl('/agent/transaction/$clientId/');

  /// Create agent transaction (POST)
  static final createCrm = appendBaseUrl('/agent/transaction/create/');

  /// Update agent transaction (PATCH)
  static String updateRevenuesCrm(String id) =>
      appendBaseUrl('/agent/transaction/update/$id/');

  /// Delete agent transaction (DELETE)
  static String deleteRevenuesCrm(String id) =>
      appendBaseUrl('/agent/transaction/delete/$id/');

  ///
  ///
  /////////// for transaction view like to do
  /// Fetch a new transaction status (GET)
  static final getAgentTransactionStatus =
      appendBaseUrl('/agent/transaction/statuses/');

  /// Create a new transaction status (POST)
  static final createAgentTransactionStatus =
      appendBaseUrl('/agent/transaction/statuses/');

  /// Update a transaction status (PATCH)
  static final agentTransactionUpdateColumnIndexes =
      appendBaseUrl('/agent/status/update-column-indexes/');

  /// Update order of transactions inside a column (PATCH)
  static final updateAgentTransactionStatus =
      appendBaseUrl('/agent/status/update-statuses/');

  ///
  ///
  /////////// Add all together
  /// Add client + transaction + draft + event
  static final estateAgentAddSellOffer =
      appendBaseUrl('/agent/add/sell/offer/');

  /// Add client + transaction + draft + event
  static final estateAgentAddBuyOffer = appendBaseUrl('/agent/add/buy/offer/');

  /// Add client + transaction + draft + event
  static final estateAgentAddViewer = appendBaseUrl('/agent/add/viewer/');

  ///
  /// Summary
  static final estateAgentCountTranasctions =
      appendBaseUrl('/tranasaction/count/');

  ///
  ///
  ///
  ///
  ///
  ////////////////////////////////// Estate developer crm url's //////////////////////////////////
  /// here developer apis
  ///
  ///
  ///
  ///
  ///
  ////////////////////////////////// Estate developer crm url's //////////////////////////////////
  /// here fliper apis
  ///
  ///
  /// Negotiation history
  static final fetchNegotiationHistory = appendBaseUrl('/fliper/fliper/negotiation_history/');
  static final createNegotiationHistory = appendBaseUrl('/fliper/fliper/negotiation_history/');
  ///
  /// Refurbishment tasks
  static final refurbishmentFetchTasks = appendBaseUrl('/fliper/fliper/renovation-tasks');
  static final refurbishmentCreateTask = appendBaseUrl('/fliper/fliper/renovation-tasks/');
  ///
  /// Refurbishment progress
  static final refurbishmentFetchProgress = appendBaseUrl('/fliper/fliper/renovation-progress');
  static final refurbishmentCreateProgress = appendBaseUrl('/fliper/fliper/renovation-progress/');
  ///
  /// Activity timeline
  static final fetchActivityTimeLine = appendBaseUrl('/fliper/fliper/activity_timeline');
  static final createActivityTimeLine = appendBaseUrl('/fliper/fliper/negotiation_history/');
  ///
  /// Sales
  static final fetchFlipperSales = appendBaseUrl('/fliper/fliper/sales');
  static final createFlipperSale = appendBaseUrl('/fliper/fliper/sales/');
  ///
  /// Sales client
  static final fetchSaleClient = appendBaseUrl('/fliper/fliper/sale-clients');
  static final createSaleClient = appendBaseUrl('/fliper/fliper/sale-clients/');
  ///
  /// Sales document
  static final fetchSaleDocument = appendBaseUrl('/fliper/fliper/sale-documents');
  static final createSaleDocument = appendBaseUrl('/fliper/fliper/sale-documents/');
  ///
  /// Revenue
  static final fetchRevenues = appendBaseUrl('/fliper/fliper/revenues');
  static final createRevenue = appendBaseUrl('/fliper/fliper/revenues/');
  ///
  /// Expenses
  static final fetchExpenses = appendBaseUrl('/fliper/fliper/expenses');
  static final createExpenses = appendBaseUrl('/fliper/fliper/expenses/');
  ///
  ///
  ///
  ///
  ///
  ////////////////////////////////// UserContacts url's ////////////////////////////////// (clients, contractors, viewers)
  ///
  ///
  /// Fetch list user contacts (GET)
  static final userContacts = appendBaseUrl('/contacts/list/');

  /// Fetch single user contact (GET)
  static String singleUserContacts(String clientId) =>
      appendBaseUrl('/contacts/$clientId/');

  /// Add user contacts (POST)
  static final clientsCreate = appendBaseUrl('/contacts/create/');

  /// Update user contacts (PATCH)
  static String clientsUpdate(String id) =>
      appendBaseUrl('/contacts/$id/update/');

  /// Delete user contacts (DELETE)
  static String clientsDelete(String id) =>
      appendBaseUrl('/contacts/$id/delete/');

  ///
  ///
  ////////////// User contacts statuses //////////////
  /// Fetch contacts statuses (GET)
  static final userContactsStatuses = appendBaseUrl('/contacts/statuses/');

  /// Add contacts status (POST)
  static final addUserContactsStatuses = appendBaseUrl('/contacts/statuses/');

  /// Fetch contacts types (GET)
  static final userContactsTypes = appendBaseUrl('/contacts/types/');

  /// Add contacts types (POST)
  static final addUserContactsTypes = appendBaseUrl('/contacts/types/');

  /// Update user contacts (PATCH)
  static String userContactStatusUpdate(int id) =>
      appendBaseUrl('/contacts/status/update/$id/');

  /// Update order of user contacts statuses (PATCH)
  static final userContactStatusUpdateStatusesIndexes =
      appendBaseUrl('/contacts/status/update-column-indexes/');

  /// Update order id's list of user contacts in contact_index (PATCH)
  static final userContactStatusUpdateColumns =
      appendBaseUrl('/contacts/status/update-status-list/');

  ///
  ///
  ////// Comment section //////
  ///Fetch comments assign to userContenct
  static String commentsByUserContacts(String clientId) =>
      appendBaseUrl('/contacts/$clientId/comments/');

  static String userContactsCommentDetails(String commentId) =>
      appendBaseUrl('/contacts/comments/$commentId/');

  ///
  ///
  ///
  ///
  ///
  ////////////////////////////////// Financial plans url's //////////////////////////////////
  ///
  ////////////// Expenses plans //////////////
  static final expensesFinancialPlans =
      appendBaseUrl('/financial-plans/expenses/');

  static String singleExpensesFinancialPlans(String planId) =>
      appendBaseUrl('/financial-plans/expenses/$planId');

  static String addPlanExpenseFinancialPlans(String planId) =>
      appendBaseUrl('/financial-plans/expenses/add_plan_to/$planId/');

  /// Actions expenses plans
  static final availableYearsExpensesFinancialPlans =
      appendBaseUrl('/financial-plans/expenses/available_years/');
  static final payedStatusExpensesFinancialPlans =
      appendBaseUrl('/financial-plans/expenses/toggle_is_payed_status/');

  ///
  ///
  ///
  ////////////// Revenues plans //////////////
  static final revenueFinancialPlans =
      appendBaseUrl('/financial-plans/revenues/');

  static String singleRevenueFinancialPlans(String planId) =>
      appendBaseUrl('/financial-plans/revenues/$planId/');

  static String addPlanRevenueFinancialPlans(String planId) =>
      appendBaseUrl('/financial-plans/revenues/add_plan_to/$planId');

  /// Actions revenues plans
  static final payedStatusRevenueFinancialPlans =
      appendBaseUrl('/financial-plans/revenues/toggle_is_payed_status/');
  static final availableYearsRevenueFinancialPlans =
      appendBaseUrl('/financial-plans/revenues/available_years/');

  ///
  ////////////// Summary plans //////////////
  static final summaryFinancialPlans =
      appendBaseUrl('/financial-plans/summary/');

  ///
  ///
  ///
  ///
  ///
  ////////////////////////////////// Finance url's //////////////////////////////////
  ///
  ///
  ////////////// Expenses //////////////
  /// Fetch expenses (GET)
  static final financeAppExpenses = appendBaseUrl('/finance/expenses/');

  /// Create expenses (POST)
  static final addFinanceAppExpenses =
      appendBaseUrl('/finance/expenses/create/');

  /// Update expenses (PATCH)
  static String updateFinanceAppExpenses(String financeAppExpensesId) =>
      appendBaseUrl('/finance/expenses/update/$financeAppExpensesId');

  /// Fetch expenses (DELETE)
  static String deleteFinanceAppExpenses(String financeAppExpensesId) =>
      appendBaseUrl('/finance/expenses/delete/$financeAppExpensesId');

  ///
  ////// Statuses expenses //////
  /// GET indexes of status columns and transaction order (GET)
  static final financeAppExpensesStatus =
      appendBaseUrl('/finance/expenses/statuses/');

  /// Create status column (POST)
  static final createFinanceAppExpensesStatus =
      appendBaseUrl('/finance/expenses/statuses/');

  /// Update indexes of status columns (PATCH)
  static final expensesUpdateColumn =
      appendBaseUrl('/finance/expenses/update-column-indexes/');

  /// Update transaction order inside column (PATCH)
  static final expensesUpdateTransaction =
      appendBaseUrl('/finance/expenses/update-statuses/');

  ///
  ///
  ///
  ////////////// Revenues //////////////
  ///  /// Fetch revenues (GET)
  static final financeAppRevenues = appendBaseUrl('/finance/revenues/');

  /// Create revenues (POST)
  static final addFinanceAppRevenues =
      appendBaseUrl('/finance/revenues/create/');

  /// Update revenues (PATCH)
  static String updateFinanceAppRevenues(String financeAppRevenuesId) =>
      appendBaseUrl('/finance/revenues/update/$financeAppRevenuesId');

  /// Fetch revenues (DELETE)
  static String deleteFinanceAppRevenues(String financeAppRevenuesId) =>
      appendBaseUrl('/finance/revenues/delete/$financeAppRevenuesId');

  ///
  ////// Statuses revenues //////
  /// GET indexes of status columns and transaction order (GET)
  static final financeAppRevenuesStatus =
      appendBaseUrl('/finance/revenues/statuses/');

  /// Create status column (POST)
  static final createFinanceAppRevenuesStatus =
      appendBaseUrl('/finance/revenues/statuses/');

  /// Update indexes of status columns (PATCH)
  static final revenuesUpdateColumn =
      appendBaseUrl('/finance/revenues/update-column-indexes/');

  /// Update transaction order inside column (PATCH)
  static final revenuesUpdateTransaction =
      appendBaseUrl('/finance/revenues/update-statuses//');

  ///
  ///
  ////////////// Summary //////////////
  static final transactionSummary =
      appendBaseUrl('/finance/transaction_type_summary/');
  static final financeAppRevenuesCount = appendBaseUrl('/revenues/count/');
  static final financeAppExpensesCount = appendBaseUrl('/expenses/count/');

  ///
  ///
  ///
  ///
  ///
  ////////////////////////////////// Portal url's //////////////////////////////////
  ///
  /// Fetch offers
  static final apiAdvertisements = appendBaseUrl('/portal/advertisements/');

  /// Fetch single offer
  static String advertiseOffer(String offerId) =>
      appendBaseUrl('/portal/advertisements/$offerId/');

  /// Fetch offers by user
  static String advertiseBaseUser(String userId) =>
      appendBaseUrl('/portal/advertisements/?user=$userId');

  /// Fetch simmilar offer
  static String similarAdvertisements(String offerId) =>
      appendBaseUrl('/portal/advertisements/$offerId/similar-ads/');

  /// Fetch nearby offers
  static String nearbyAdvertisements(String offerId) =>
      appendBaseUrl('/portal/advertisements/$offerId/nearby/');

  /// Fetch hot offers
  static String hotAdvertisements(String offerId) =>
      appendBaseUrl('/portal/advertisements/hot/');

  ///
  /// Edit offer
  static String updateAdvertise(String offerId) =>
      appendBaseUrl('/portal/advertisements/update/$offerId/');

  /// Edit offer add more advertisment time
  static String addAdvertiseTime(String offerId) =>
      appendBaseUrl('/portal/advertisements/update/$offerId/add-time/');

  ///
  /// Add offer
  static final addAdvertisement = appendBaseUrl('/portal/add_advertisement/');

  ///
  /// Archive offer (use for delete)
  static String advertisementsArchive(String adId) =>
      appendBaseUrl('/portal/advertisements/$adId/archive/');

  ///
  /// Displayed offer's actions
  static String addDisplayed(String adId) =>
      appendBaseUrl('/portal/displayed/add/$adId/?sort=date_asc');

  static String removeDisplayed(String adId) =>
      appendBaseUrl('/portal/displayed/remove/$adId/');
  static final apiDisplayed = appendBaseUrl('/portal/displayed/?sort=date_asc');

  ///
  /// favorite offer's actions
  static String apiFavoriteAdd(String adId) =>
      appendBaseUrl('/portal/favorite/add/$adId/');

  static String apiFavoriteRemove(String adId) =>
      appendBaseUrl('/portal/favorite/remove/$adId/');
  static final apiFavorite = appendBaseUrl('/portal/favorite/');

  ///
  /// Hide offer's actions
  static String apiHideAdd(String adId) =>
      appendBaseUrl('/portal/hide/add/$adId/');

  static String apiHideRemove(String adId) =>
      appendBaseUrl('/portal/hide/remove/$adId/');
  static final apiHide = appendBaseUrl('/portal/hide/');

  ///
  /// BrowseList offer's actions
  
  static String portalBrowseListAdd(String adId) => appendBaseUrl('/portal/browselist/add/$adId/');          //////////////[POST]///////////////
  static String portalBrowseListRemove(String adId) => appendBaseUrl('/portal/browselist/remove/$adId/');    //////////////[DELETE]///////////////
  static final portalBrowseListClear = appendBaseUrl('/portal/browselist/clear/');                           //////////////[DELETE]///////////////
  static final portalBrowseList = appendBaseUrl('/portal/browselist/');                                     //////////////[GET]///////////////
  ///
  ///
  ///
  ///
  ///
  ////////////////////////////////// Network monitoring url's //////////////////////////////////
  ///
  /// Fetch offers
  static String advertiseMonitoring(String adId) =>
      appendBaseUrl('/networkmonitoring/advertisements/$adId');
  static final singleAdMonitoring =
      appendBaseUrl('/networkmonitoring/advertisements/');

  ///
  /// Displayed offer's actions
  static String monitoringDisplay(String adId) =>
      appendBaseUrl('/networkmonitoring/displayed/add/$adId/?sort=date_asc');

  static String removeMonitoring(String adId) =>
      appendBaseUrl('/networkmonitoring/displayed/remove/$adId');
  static final networkMonitoring =
      appendBaseUrl('/networkmonitoring/displayed/?sort=date_asc');

  ///
  /// favorite offer's actions
  static String addFavoriteNetwork(String adId) =>
      appendBaseUrl('/networkmonitoring/favorite/add/$adId/');

  static String removeFavoriteNetwork(String adId) =>
      appendBaseUrl('/networkmonitoring/favorite/remove/$adId/');
  static final favoriteNetwork = appendBaseUrl('/networkmonitoring/favorite/');

  ///
  /// Hide offer's actions
  static String addHideMonitoring(String adId) =>
      appendBaseUrl('/networkmonitoring/hide/add/$adId');

  static String removeHideMonitoring(String adId) =>
      appendBaseUrl('/networkmonitoring/hide/remove/$adId/');
  static final hideMonitoring = appendBaseUrl('/networkmonitoring/hide/');

  ///
  ///
  /// BrowseList offer's actions
  
  static String networkMonitoringBrowseListAdd(String adId) => appendBaseUrl('/networkmonitoring/browselist/add/$adId/');          //////////////[POST]///////////////
  static String networkMonitoringBrowseListRemove(String adId) => appendBaseUrl('/networkmonitoring/browselist/remove/$adId/');    //////////////[DELETE]///////////////
  static final networkMonitoringBrowseListClear = appendBaseUrl('/networkmonitoring/browselist/clear/');                           //////////////[DELETE]///////////////
  static final networkMonitoringBrowseList = appendBaseUrl('/networkmonitoring/browselist/');                                     //////////////[GET]///////////////
  ///
  ///
  ///
  ///
  ///
  ////////////////////////////////// Saved Searches NM url's //////////////////////////////////
  /// Fetch list of saved searches
  static final savedSearches = appendBaseUrl('/saved_searches/');

  /// Fetch list saved searches assign to client
  static String clientSearches(String clientId) =>
      appendBaseUrl('/contacts/$clientId/saved_searches/');
      
  /// Saved searches actions
  static final savedSearch = appendBaseUrl('/saved_searches/create/');

  static String editSavedSearch(String savedSearchId) =>
      appendBaseUrl('/saved_searches/$savedSearchId/edit/');

  static String deleteSavedSearch(String savedSearchId) =>
      appendBaseUrl('/saved_searches/$savedSearchId/delete/');

  /// Assgin to client (userContact) actions
  static String clientSavedSearch(String clientId, String savedSearchId) =>
      appendBaseUrl('/contacts/$clientId/add_saved_searches/$savedSearchId/');

  ///
  ///
  ///
  ///
  ///
  ////////////////////////////////// Article url's //////////////////////////////////
  ///
  /// Fetch article
  static final apiArticles = appendBaseUrl('/article/');

  ///
  ///
  ///
  ///
  ///
  ////////////////////////////////// Map url's //////////////////////////////////
  ///
  static String nominatimMap(String encodedAddress) =>
      'https://nominatim.openstreetmap.org/search?format=json&q=$encodedAddress';

  ///
  ///
  ///
  ///
  ///
  ////////////////////////////////// Task managment system url's //////////////////////////////////
  ///
  static String sendRoomMessages(String roomId) =>
      appendBaseUrl('/chat/rooms/$roomId/messages/');

  ///
  ///
  ///
  ///
  ///
  ////////////////////////////////// Community wall url's //////////////////////////////////
  ///
  /// Fetch posts (GET)
  static final communityPosts = appendBaseUrl('/community/posts/');

  /// Create posts(POST)
  static final communityPostsCreate = appendBaseUrl('/community/posts/');

  ///
  /// Update (PATCH)
  static String communityPostUpdate(String communityPostsId) =>
      appendBaseUrl('/community/posts/$communityPostsId/');

  /// Delete post (DELETE)
  static String communityPostDelete(String communityPostsId) =>
      appendBaseUrl('/community/posts/$communityPostsId/');

  ///
  /// Add like to post  (POST)
  static String communityPostAddLike(String communityPostsId) =>
      appendBaseUrl('/community/posts/$communityPostsId/add_like/');

  /// Remove like to post  (POST)
  static String communityPostRemoveLike(String communityPostsId) =>
      appendBaseUrl('/community/posts/$communityPostsId/remove_like/');

  ///
  /// Add comment to post  (POST)
  static String communityPostAddComment(String communityPostsId) =>
      appendBaseUrl('/community/comments/');

  /// Fetch comment to post  (GET)
  static String communityPostGetComments(String communityPostsId) =>
      appendBaseUrl('/community/comments/?post=$communityPostsId');

  /// Remove like to post  (DELETE)
  static String communityPostRemoveComment(String communityPostsId) =>
      appendBaseUrl('/community/comments/$communityPostsId/');

  /// Update like to post  (PATCH)
  static String communityPostEditComment(String communityPostsId) =>
      appendBaseUrl('/community/comments/$communityPostsId/');

  ///
  ///
  ///
  ///
  ///
  ////////////////////////////////// Autocomplete url's //////////////////////////////////
  ///
  /// Fetch autocomplete
  static final autocompleteApi = appendBaseUrl('/autocomplete/');

  ///
  ///
  ///
  ///
  ///
  ////////////////////////////////// Calendar url's //////////////////////////////////
  ///
  ///
  ///
  ///
  ///
  ///
  ////////////////////////////////// Gateway url's //////////////////////////////////
  ///
  ///
  ///
  ///
  ///
  ///
  ////////////////////////////////// Landlord url's //////////////////////////////////
  ///
  ///
  ///
  ///
  ///
  ///
  ////////////////////////////////// Notifications url's //////////////////////////////////
  ///
  static final fcmAddDevice = appendBaseUrl('/api/devices/');
  static final userNotifications = appendBaseUrl('/api/notifications/');

  static String notificationsSeen(String id) =>
      appendBaseUrl('/api/notifications/$id/make-notification-seen/');

  ///
  ///
  ///
  ///
  ///
  ////////////////////////////////// Payments url's //////////////////////////////////
  ///

  static final stripeCheckout =
      appendBaseUrl('/advertisement/create-stripe-session/');
  static final userPayments = appendBaseUrl('/payments/user-payments/');
  static final handleWebhook = appendBaseUrl('/handle-webhook/');

  ///
  ///
  ///
  ///
  ///
  ////////////////////////////////// User tracking url's //////////////////////////////////
  ///
  ///
  ///
  ///
  ///
  ///
  ////////////////////////////////// User Config url's //////////////////////////////////
  ///
  /// Fetch config (GET)
  static final userConfigGET = appendBaseUrl('/config/settings/');

  /// Update all data (PUT)
  static final userConfigPUT = appendBaseUrl('/config/settings/');

  /// Udpate one or more data (PATCH)
  static final userConfigPATCH = appendBaseUrl('/config/settings/');

  ////////////////////////////////// Tms url's //////////////////////////////////

  static final apiTask = appendBaseUrl('/tms/project/');

  static String addComment(String taskId) =>
      appendBaseUrl('/tms/task/$taskId/add-comment/');

  static String getComments(String taskId) =>
      appendBaseUrl('/tms/task/$taskId/get-comments/');

  static String deleteComments(String taskId, String commentId) =>
      appendBaseUrl('/tms/task/$taskId/delete-task-comment/$commentId/');
  static final addTask = appendBaseUrl('/tms/task/');

  static String addProgressBar(String projectId) =>
      appendBaseUrl('/tms/project/$projectId/create-progress-bar-field/');

  static String projectDetails(String projectId) =>
      appendBaseUrl('/tms/project/$projectId/');

  static String editTask(String progressId) =>
      appendBaseUrl('/tms/task/$progressId/');

  static String reOrderTask(String projectId) =>
      appendBaseUrl('/tms/project/$projectId/ordering-tasks/');

  static String reProgressTask(String taskId) =>
      appendBaseUrl('/tms/task/$taskId/update-progress-bar/');

  static String addFileToTask(String taskId) =>
      appendBaseUrl('/tms/task/$taskId/add-task-file/');

  static String deleteProgressBar(String projectId, String progressId) =>
      appendBaseUrl(
          '/tms/project/$projectId/update-progress-bar-field/$progressId/');

  static String updateProgressBar(String projectId, String progressId) =>
      appendBaseUrl(
          '/tms/project/$projectId/update-progress-bar-field/$progressId/');

  ///
  ///
  ///
  ///
  ///
  ///
  ////////////////////////////////// Chat Ai url's //////////////////////////////////

  static String getAiRooms = appendBaseUrl('/ai/rooms/');
  static String createAiRoom = appendBaseUrl('/ai/rooms/create/');

  static String removeAiRoom(String id) =>
      appendBaseUrl('/ai/rooms/delete/$id/');
  static String getAiMessages = appendBaseUrl('/ai/chat/');

  static String messageListInRoomAi(String id) =>
      appendBaseUrl('/ai/rooms/messages/$id/');

  static String addMessageToRoomAi(String id) =>
      appendBaseUrl('/ai/rooms/messages/add/$id/');
  static String queryUserChatBot = appendBaseUrl('/ai/chat/');

  static String editAiMessage(String roomId, String messageId) =>
      appendBaseUrl('/ai/rooms/edit/$roomId/messages/$messageId/');

  ///
  ///
  ///
  ///
  ///
  ///
  ////////////////////////////////// Add transactions url's //////////////////////////////////

  static final sellTransAction = appendBaseUrl('/agent/add/sell/offer/');
  static final buyTransAction = appendBaseUrl('/agent/add/buy/offer/');
  static final estateViewing = appendBaseUrl('/agent/add/viewer/');
///
///
///
///
///
///
////////////////////////////////// Event url's //////////////////////////////////

static final getCreateEvent = appendBaseUrl('/calendar/event/');
static String updateDetailEvent(String id)=> appendBaseUrl('/calendar/event/$id/');

}
