import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class InternetNotifier extends StateNotifier<bool> {
  late StreamSubscription<InternetConnectionStatus> _subscription;

  InternetNotifier() : super(true) {
    _subscription = InternetConnectionChecker.instance.onStatusChange.listen((status) {
      state = (status == InternetConnectionStatus.connected);
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

final internetProvider = StateNotifierProvider<InternetNotifier, bool>(
      (ref) => InternetNotifier(),
);

class FailedApiRequest {
  final String url;
  final Map<String, String>? headers;
  final Map<String, dynamic>? queryParameters;
  final bool hasToken;

  FailedApiRequest({
    required this.url,
    this.headers,
    this.queryParameters,
    this.hasToken = false,
  });
}

class FailedApiNotifier extends StateNotifier<List<FailedApiRequest>> {
  FailedApiNotifier() : super([]);

  // Add a failed request to the queue, ensuring no duplicates
  void addRequest(FailedApiRequest request) {
    final isDuplicate = state.any((existingRequest) =>
    existingRequest.url == request.url &&
        _mapEquals(existingRequest.queryParameters, request.queryParameters) &&
        _mapEquals(existingRequest.headers, request.headers) &&
        existingRequest.hasToken == request.hasToken);

    if (!isDuplicate) {
      state = [...state, request];
    }
  }

  // Clear all requests after retrying
  void clearRequests() {
    state = [];
  }

  // Retrieve all failed requests
  List<FailedApiRequest> get requests => state;

  // Helper function to compare maps
  bool _mapEquals(Map<String, dynamic>? a, Map<String, dynamic>? b) {
    if (a == null || b == null) return a == b;
    if (a.length != b.length) return false;
    for (final key in a.keys) {
      if (a[key] != b[key]) return false;
    }
    return true;
  }
}

final failedApiProvider = StateNotifierProvider<FailedApiNotifier, List<FailedApiRequest>>(
      (ref) => FailedApiNotifier(),
);

