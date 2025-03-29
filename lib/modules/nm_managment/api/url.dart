
class NetworkMonitoringURLs {
  //production set up

  static const urlNetworkMonitoring = 'http://www.hously.space';

  /// Append base url
  static String appendSpaceUrl(String url) => '$urlNetworkMonitoring$url';

  static final sendToCloud = appendSpaceUrl('send-advertisement/');
  static final mergeListings = appendSpaceUrl('merge-listings/');
  static final serviceStatus = appendSpaceUrl('service-status/');


  static final scrapersDiagnostics = appendSpaceUrl('scrapers/diagnostics/');
  static final scrapersConfig = appendSpaceUrl('scrapers/config/');
  static final scrapersHealth = appendSpaceUrl('scrapers/health/');
  static final scrapersStatus = appendSpaceUrl('scrapers/status/');



  static final statsRefresh = appendSpaceUrl('stats/refresh/');
  static final statsLatest = appendSpaceUrl('stats/latest/');
  static final statsCompare = appendSpaceUrl('stats/compare/');
  static final statsCheckPhotos = appendSpaceUrl('stats/check-photos/');
  static final statsImageLinks = appendSpaceUrl('stats/image-links/');

  
  static final statsUpdateSource = appendSpaceUrl('stats/update-source/');
  static final statsUniqueValues = appendSpaceUrl('stats/unique-values/');
  static final statsArchiveInactive = appendSpaceUrl('stats/archive-inactive/');



  static String singleLead(String listingId) => appendSpaceUrl('check-listing/$listingId/');
}