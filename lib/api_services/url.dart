// lib/safehouse/url.dart

class URLs {
  //production set up

  static const baseUrl = 'https://www.hously.cloud';
  static const baseUrlAdminPanel = 'https://www.hously.cloud/admin-panel/';
  static const baseUrlLeadsPanel = 'https://www.hously.cloud/admin-panel/leads-panel/';
  static const baseUrlMail = 'https://www.hously.cloud/mail/';
  static const httpOrHttps = 'https';
  static const webSocketUrl = 'wss://www.hously.cloud';
  static const urlNetworkMonitoring = 'http://www.hously.space';

  /// Append base url
  static String appendBaseUrl(String url) => '$baseUrl$url';
  static String appendAdminPanelUrl(String url) => '$baseUrlAdminPanel$url';
  static String appendLeadsPanelUrl(String url) => '$baseUrlLeadsPanel$url';
  static String appendMailUrl(String url) => '$baseUrlMail$url';


////////////////////////////////////////////////////ADMIN PANEL////////////////////////////////////////////////////


  // LEADS
  static final leads = appendLeadsPanelUrl('leads/');
  static String singleLead(String leadId) => appendLeadsPanelUrl('leads/$leadId/');
  static String leadAddInteraction(String leadId) => appendLeadsPanelUrl('leads/$leadId/add_interaction/');
  static String leadAssignOwner(String leadId) => appendLeadsPanelUrl('leads/$leadId/assign_owner/');
  static String leadChangeStatus(String leadId) => appendLeadsPanelUrl('leads/$leadId/change_status/');

  static String leadUpdateStatus(String leadId) => appendLeadsPanelUrl('/status/update/$leadId/');
  static final getLeadStatus = appendLeadsPanelUrl('statuses/');
  /// Create a new transaction status (POST)
  static final createLeadStatus = appendLeadsPanelUrl('statuses/');  
  static String singleStatus(String statusId) => appendLeadsPanelUrl('statuses/$statusId/');
  static String leadStatusUpdate(String statusId) => appendLeadsPanelUrl('status/update/$statusId/');
  /// Update a transaction status (PATCH)
  static final leadUpdateColumnIndexes = appendLeadsPanelUrl('status/update-column-indexes/');
  /// Update order of transactions inside a column (PATCH)
  static final updateLeadStatus = appendLeadsPanelUrl('status/update-status-list/');











  // INTERACTIONS
  static final interactions = appendLeadsPanelUrl('interactions/');
  static String singleInteraction(String interactionId) => appendLeadsPanelUrl('interactions/$interactionId/');

  // INTERVALS
  static final intervals = appendLeadsPanelUrl('intervals/');
  static String singleInterval(String intervalId) => appendLeadsPanelUrl('intervals/$intervalId/');

  // PREDEFINED ACTIONS
  static final predefinedActions = appendLeadsPanelUrl('predefined-actions/');
  static String singlePredefinedAction(String id) => appendLeadsPanelUrl('predefined-actions/$id/');









///////////////////////////////////EMAIL////////////////////////////////////
///
///
  static final emails = appendMailUrl('emails/');
  static final emailSearch = appendMailUrl('emails/');
  static final emailAccount = appendMailUrl('email-accounts/');












/////////////////////////////////////////////////END OF ADMIN PANEL//////////////////////////////////////////////////





















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
  
  static String networkMonitoringBrowseListAdd(String adId) => appendBaseUrl('/networkmonitoring/browselist/add/$adId/');          //////////////[POST]///////////////
  static String networkMonitoringBrowseListRemove(String adId) => appendBaseUrl('/networkmonitoring/browselist/remove/$adId/');    //////////////[DELETE]///////////////
  static final networkMonitoringBrowseListClear = appendBaseUrl('/networkmonitoring/browselist/clear/');                           //////////////[DELETE]///////////////
  static final networkMonitoringBrowseList = appendBaseUrl('/networkmonitoring/browselist/');                                     //////////////[GET]///////////////
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
////////////////////////////////// Event url's //////////////////////////////////

static final getCreateEvent = appendBaseUrl('/calendar/event/');
static String updateDetailEvent(String id)=> appendBaseUrl('/calendar/event/$id/');

}
