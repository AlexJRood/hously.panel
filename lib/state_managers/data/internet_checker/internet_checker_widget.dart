import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/utils/api_services.dart';
import 'Internet_checker_provider.dart';

class InternetCheckWidget extends ConsumerStatefulWidget {
  final Widget child;

  const InternetCheckWidget({super.key, required this.child});

  @override
  ConsumerState<InternetCheckWidget> createState() =>
      _InternetCheckWidgetState();
}

class _InternetCheckWidgetState extends ConsumerState<InternetCheckWidget> {
  bool? _previousConnectionStatus;

  @override
  Widget build(BuildContext context) {
    final hasInternet = ref.watch(internetProvider);

    // Detect internet reconnection
    if (_previousConnectionStatus != null &&
        hasInternet != _previousConnectionStatus) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (hasInternet) {
          _retryFailedRequests(ref);
          _showInternetStatusSnackBar(
            context,
            'Internet connected. Retrying failed requests...',
            Colors.green,
            10
          );
        } else {
          _showInternetStatusSnackBar(
            context,
            'No internet connection.',
            Colors.red,
            300
          );
        }
      });
    }

    _previousConnectionStatus = hasInternet;

    return widget.child;
  }

  Future<void> _retryFailedRequests(WidgetRef ref) async {
    final failedRequests = ref.read(failedApiProvider);
    if (failedRequests.isEmpty) return;
    for (var request in failedRequests) {
      try {
        await ApiServices.get(
          ref: ref,
          request.url,
          queryParameters: request.queryParameters,
          headers: request.headers,
          hasToken: true,
        );
      } catch (e) {
        debugPrint("Retry failed for ${request.url}: $e");
      }
    }

    ref.read(failedApiProvider.notifier).clearRequests();
  }

  void _showInternetStatusSnackBar(BuildContext context, String message, Color color,int duration) {
    ScaffoldMessenger.of(context).clearSnackBars(); // Clear previous snack bars
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
        duration:  Duration(seconds: duration),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
