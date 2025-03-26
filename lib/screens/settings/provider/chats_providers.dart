import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatsSetings {
  Map<String, bool> settings;

  ChatsSetings({
    Map<String, bool>? initialSettings,
  }) : settings =
            initialSettings ?? {'activestatus': false, "outofoffice": false};

  void toggleSetting(String key) {
    if (settings.containsKey(key)) {
      settings[key] = !settings[key]!;
    }
  }
}

class ChatsSettingsNotifier extends StateNotifier<ChatsSetings> {
  ChatsSettingsNotifier() : super(ChatsSetings());

  // Toggle a specific setting based on its key
  void toggleSetting(String key) {
    state.toggleSetting(key);
    state = ChatsSetings(
        initialSettings:
            Map.from(state.settings)); // Recreate state to trigger change
  }
}

final chatsSettingsProvider =
    StateNotifierProvider<ChatsSettingsNotifier, ChatsSetings>(
  (ref) => ChatsSettingsNotifier(),
);
