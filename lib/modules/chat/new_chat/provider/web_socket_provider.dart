import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'dart:convert';

class WebSocketNotifier extends StateNotifier<Stream<dynamic>?> {
  WebSocketNotifier() : super(null);

  WebSocketChannel? _channel;
  bool _isConnected = false;
  String? _currentUrl;

  /// Check if the WebSocket is connected
  bool get isConnected => _isConnected;

  /// Connect to a new WebSocket URL
  void connect(String url) {
    // If already connected to the same WebSocket URL, return early
    if (_isConnected && _currentUrl == url) {
      print('Already connected to WebSocket: $url');
      return;
    }

    // Disconnect from the previous WebSocket if connected
    disconnect();

    // Connect to the new WebSocket
    _currentUrl = url;
    _isConnected = true;

    _channel = WebSocketChannel.connect(Uri.parse(url));
    state = _channel!.stream; // Expose the WebSocket stream
    print('Connected to WebSocket: $url');
  }

  /// Disconnect from the current WebSocket
  void disconnect() {
    if (_isConnected) {
      print('Disconnecting from WebSocket: $_currentUrl');
      _isConnected = false;
      _currentUrl = null;
      _channel?.sink.close();
      _channel = null;
      state = null;
      print('WebSocket disconnected.');
    }
  }

  @override
  void dispose() {
    disconnect();
    super.dispose();
  }
}

final webSocketProvider = StateNotifierProvider<WebSocketNotifier, Stream<dynamic>?>(
      (ref) => WebSocketNotifier(),
);
