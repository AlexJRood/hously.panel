import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hously_flutter/const/icons.dart';
import 'package:hously_flutter/const/route_constant.dart';
import 'package:hously_flutter/routes/navigation_history_provider.dart';
import 'package:hously_flutter/screens/filters/filters_page.dart';
import 'package:hously_flutter/screens/pop_pages/view_pop_changer_page.dart';

import 'package:hously_flutter/state_managers/services/navigation_service.dart';
import 'package:hously_flutter/widgets/side_menu/slide_rotate_menu.dart';
import 'package:shared_preferences/shared_preferences.dart';

class KeyBoardShortcuts extends ChangeNotifier{
  // Function to handle the key events (Up or Down) and perform respective actions
  void handleKeyEvent(KeyEvent event, ScrollController _scrollController,
      int offsetvalue, int seconds) {
    // Check if the event is KeyDown (i.e., key is pressed)
    if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
      var offset = _scrollController.offset;

      if (kReleaseMode) {
        _scrollController.animateTo(offset - offsetvalue,
            duration: Duration(milliseconds: seconds), curve: Curves.linear);
      } else {
        _scrollController.animateTo(offset - offsetvalue,
            duration: Duration(milliseconds: seconds), curve: Curves.linear);
      }
    } else if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
      var offset = _scrollController.offset;
      if (kReleaseMode) {
        _scrollController.animateTo(offset + offsetvalue,
            duration: Duration(milliseconds: seconds), curve: Curves.linear);
      } else {
        _scrollController.animateTo(offset + offsetvalue,
            duration: Duration(milliseconds: seconds), curve: Curves.linear);
      }
    }
  }

  void handleBackspaceNavigation(KeyEvent event, WidgetRef ref) {
    if (event is KeyDownEvent &&
        event.logicalKey == ref.read(backspaceKeyProvider)) {
      final lastPage = ref.read(navigationHistoryProvider.notifier).lastPage;

      // Check if there is a valid page to navigate to
      if (lastPage.isNotEmpty) {
        ref.read(navigationService).pushNamedReplacementScreen(lastPage);
      } else {
        debugPrint("No page in navigation history to go back to.");
      }
    }
  }

  void handleKeyEvent2(KeyEvent event, ScrollController _scrollController,
      int offsetValue, int seconds) {
    // Check if the event is KeyDown (i.e., key is pressed)
    if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
      var offset = _scrollController.offset;
      // Move left
      _scrollController.animateTo(offset - offsetValue,
          duration: Duration(milliseconds: seconds), curve: Curves.linear);
    } else if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
      var offset = _scrollController.offset;
      // Move right
      _scrollController.animateTo(offset + offsetValue,
          duration: Duration(milliseconds: seconds), curve: Curves.linear);
    }
  }

  void filterpop(KeyEvent event, WidgetRef ref, BuildContext context) {
    final sortKey = ref.watch(filterKeyProvider);
    final Set<LogicalKeyboardKey> pressedKeys =
        HardwareKeyboard.instance.logicalKeysPressed;

    // Log all currently pressed keys
    debugPrint("Pressed Keys: $pressedKeys");

    if (pressedKeys.contains(sortKey) &&
        pressedKeys.contains(LogicalKeyboardKey.altLeft)) {
      debugPrint("Ctrl + ${sortKey} detected! Opening ViewPopChangerPage...");

      Navigator.of(context).push(
        PageRouteBuilder(
          opaque: false,
          pageBuilder: (_, __, ___) => const FiltersPage(tag: ''),
          transitionsBuilder: (_, anim, __, child) {
            return FadeTransition(opacity: anim, child: child);
          },
        ),
      );
    } else {
      debugPrint("Ctrl + ${sortKey} NOT detected.");
    }
  }

  void sortpopup(KeyEvent event, WidgetRef ref, BuildContext context) {
    final sortKey = ref.watch(sortKeyProvider);
    final Set<LogicalKeyboardKey> pressedKeys =
        HardwareKeyboard.instance.logicalKeysPressed;

    // Log all currently pressed keys
    debugPrint("Pressed Keys: $pressedKeys");

    if (pressedKeys.contains(sortKey) &&
        pressedKeys.contains(LogicalKeyboardKey.altLeft)) {
      debugPrint("Ctrl + ${sortKey} detected! Opening ViewPopChangerPage...");

      Navigator.of(context).push(
        PageRouteBuilder(
          opaque: false,
          pageBuilder: (_, __, ___) => const ViewPopChangerPage(),
          transitionsBuilder: (_, anim, __, child) {
            return FadeTransition(opacity: anim, child: child);
          },
        ),
      );
    } else {
      debugPrint("Ctrl + ${sortKey} NOT detected.");
    }
  }

  void handleKeyNavigation(
      KeyEvent event, WidgetRef ref, BuildContext context) {
    final Set<LogicalKeyboardKey> pressedKeys =
        HardwareKeyboard.instance.logicalKeysPressed;

    debugPrint("Pressed Keys: $pressedKeys");

    if (event is KeyDownEvent) {
      final altPressed = pressedKeys.contains(LogicalKeyboardKey.altLeft);
      if (altPressed) {
        final keyActionMap = {
          ref.read(crmKeyProvider): () {
            debugPrint("Alt + CRM Key detected! Navigating to Pro Dashboard");
            ref
                .read(navigationService)
                .pushNamedReplacementScreen(Routes.proDashboard);
          },
          ref.read(reportsKeyProvider): () {
            debugPrint("Alt + Reports Key detected! Navigating to Reports");
            ref
                .read(navigationService)
                .pushNamedReplacementScreen(Routes.reports);
          },
          ref.read(networkKeyProvider): () {
            debugPrint(
                "Alt + Network Key detected! Navigating to Network Monitoring");
            ref
                .read(navigationService)
                .pushNamedReplacementScreen(Routes.networkMonitoring);
          },
          ref.read(portalKeyProvider): () {
            debugPrint("Alt + Portal Key detected! Navigating to Homepage");
            ref
                .read(navigationService)
                .pushNamedReplacementScreen(Routes.homepage);
          },
        };

        for (var key in keyActionMap.keys) {
          if (pressedKeys.contains(key)) {
            keyActionMap[key]!(); // Execute the corresponding action
            return; // Exit after handling the key
          }
        }
        debugPrint("No matching key detected for navigation.");
      }
    }
    notifyListeners();
  }
}

final popKeyProvider = StateProvider<LogicalKeyboardKey?>((ref) => null);
final pedfKeyProvider = StateProvider<LogicalKeyboardKey?>((ref) => null);
final filterKeyProvider = StateProvider<LogicalKeyboardKey?>((ref) => null);
final sortKeyProvider = StateProvider<LogicalKeyboardKey?>((ref) => null);
final portalKeyProvider = StateProvider<LogicalKeyboardKey?>((ref) => null);
final crmKeyProvider = StateProvider<LogicalKeyboardKey?>((ref) => null);
final reportsKeyProvider = StateProvider<LogicalKeyboardKey?>((ref) => null);
final networkKeyProvider = StateProvider<LogicalKeyboardKey?>((ref) => null);
final togglesidemenu1 = StateProvider<LogicalKeyboardKey?>((ref) => null);
final togglesidemenu2 = StateProvider<LogicalKeyboardKey?>((ref) => null);
final adclientprovider = StateProvider<LogicalKeyboardKey?>((ref) => null);
final backspaceKeyProvider = StateProvider<LogicalKeyboardKey?>((ref) => null);

// Helper function to map string labels to LogicalKeyboardKey
LogicalKeyboardKey? mapKeyLabelToLogicalKey(String label) {
  final keyMap = {
    // Alphabet keys
    'A': LogicalKeyboardKey.keyA,
    'B': LogicalKeyboardKey.keyB,
    'C': LogicalKeyboardKey.keyC,
    'D': LogicalKeyboardKey.keyD,
    'E': LogicalKeyboardKey.keyE,
    'F': LogicalKeyboardKey.keyF,
    'G': LogicalKeyboardKey.keyG,
    'H': LogicalKeyboardKey.keyH,
    'I': LogicalKeyboardKey.keyI,
    'J': LogicalKeyboardKey.keyJ,
    'K': LogicalKeyboardKey.keyK,
    'L': LogicalKeyboardKey.keyL,
    'M': LogicalKeyboardKey.keyM,
    'N': LogicalKeyboardKey.keyN,
    'O': LogicalKeyboardKey.keyO,
    'P': LogicalKeyboardKey.keyP,
    'Q': LogicalKeyboardKey.keyQ,
    'R': LogicalKeyboardKey.keyR,
    'S': LogicalKeyboardKey.keyS,
    'T': LogicalKeyboardKey.keyT,
    'U': LogicalKeyboardKey.keyU,
    'V': LogicalKeyboardKey.keyV,
    'W': LogicalKeyboardKey.keyW,
    'X': LogicalKeyboardKey.keyX,
    'Y': LogicalKeyboardKey.keyY,
    'Z': LogicalKeyboardKey.keyZ,

    // Digit keys
    '0': LogicalKeyboardKey.digit0,
    '1': LogicalKeyboardKey.digit1,
    '2': LogicalKeyboardKey.digit2,
    '3': LogicalKeyboardKey.digit3,
    '4': LogicalKeyboardKey.digit4,
    '5': LogicalKeyboardKey.digit5,
    '6': LogicalKeyboardKey.digit6,
    '7': LogicalKeyboardKey.digit7,
    '8': LogicalKeyboardKey.digit8,
    '9': LogicalKeyboardKey.digit9,

    // Function keys
    'F1': LogicalKeyboardKey.f1,
    'F2': LogicalKeyboardKey.f2,
    'F3': LogicalKeyboardKey.f3,
    'F4': LogicalKeyboardKey.f4,
    'F5': LogicalKeyboardKey.f5,
    'F6': LogicalKeyboardKey.f6,
    'F7': LogicalKeyboardKey.f7,
    'F8': LogicalKeyboardKey.f8,
    'F9': LogicalKeyboardKey.f9,
    'F10': LogicalKeyboardKey.f10,
    'F11': LogicalKeyboardKey.f11,
    'F12': LogicalKeyboardKey.f12,

    // Modifier keys
    'Shift Left': LogicalKeyboardKey.shiftLeft,
    'Shift Right': LogicalKeyboardKey.shiftRight,
    'Control Left': LogicalKeyboardKey.controlLeft,
    'Control Right': LogicalKeyboardKey.controlRight,
    'Alt Left': LogicalKeyboardKey.altLeft,
    'Alt Right': LogicalKeyboardKey.altRight,
    'Meta Left': LogicalKeyboardKey.metaLeft,
    'Meta Right': LogicalKeyboardKey.metaRight,

    // Editing keys
    'Backspace': LogicalKeyboardKey.backspace,
    'Delete': LogicalKeyboardKey.delete,
    'Enter': LogicalKeyboardKey.enter,
    'Space': LogicalKeyboardKey.space,
    'Tab': LogicalKeyboardKey.tab,

    // Numpad keys
    'Numpad0': LogicalKeyboardKey.numpad0,
    'Numpad1': LogicalKeyboardKey.numpad1,
    'Numpad2': LogicalKeyboardKey.numpad2,
    'Numpad3': LogicalKeyboardKey.numpad3,
    'Numpad4': LogicalKeyboardKey.numpad4,
    'Numpad5': LogicalKeyboardKey.numpad5,
    'Numpad6': LogicalKeyboardKey.numpad6,
    'Numpad7': LogicalKeyboardKey.numpad7,
    'Numpad8': LogicalKeyboardKey.numpad8,
    'Numpad9': LogicalKeyboardKey.numpad9,
    'NumpadAdd': LogicalKeyboardKey.numpadAdd,
    'NumpadSubtract': LogicalKeyboardKey.numpadSubtract,
    'NumpadMultiply': LogicalKeyboardKey.numpadMultiply,
    'NumpadDivide': LogicalKeyboardKey.numpadDivide,
    'NumpadEnter': LogicalKeyboardKey.numpadEnter,
    'NumpadDecimal': LogicalKeyboardKey.numpadDecimal,

    // Miscellaneous keys
    'Escape': LogicalKeyboardKey.escape,
    'CapsLock': LogicalKeyboardKey.capsLock,
    'NumLock': LogicalKeyboardKey.numLock,
    'ScrollLock': LogicalKeyboardKey.scrollLock,
    'PrintScreen': LogicalKeyboardKey.printScreen,
    'Pause': LogicalKeyboardKey.pause,
  };
  print(keyMap[label]);
  return keyMap[label];
}

Future<void> initializeLogicalKeyboardKeys(WidgetRef ref) async {
  final prefs = await SharedPreferences.getInstance();

  // Default keys mapped to their preferences keys
  final keyMappings = {
    'Pop': LogicalKeyboardKey.escape,
    'PDF': LogicalKeyboardKey.keyP,
    'Filter': LogicalKeyboardKey.keyA,
    'Sort': LogicalKeyboardKey.keyS,
    'Portal': LogicalKeyboardKey.digit1,
    'CRM': LogicalKeyboardKey.digit2,
    'Reports': LogicalKeyboardKey.digit3,
    'Network': LogicalKeyboardKey.digit4,
    'Sidemenu': LogicalKeyboardKey.shiftLeft,
    'Sidemenu2': LogicalKeyboardKey.altLeft,
    'Addview': LogicalKeyboardKey.altLeft,
    'Backspace': LogicalKeyboardKey.backspace,
  };

  keyMappings.forEach((prefKey, defaultKey) {
    final storedValue = prefs.getString(prefKey);
    final logicalKey =
        storedValue != null ? mapKeyLabelToLogicalKey(storedValue) : defaultKey;

    switch (prefKey) {
      case 'Pop':
        ref
            .read(popKeyProvider.notifier)
            .update((state) => state ?? logicalKey);
        break;
      case 'PDF':
        ref
            .read(pedfKeyProvider.notifier)
            .update((state) => state ?? logicalKey);
        break;
      case 'Filter':
        ref
            .read(filterKeyProvider.notifier)
            .update((state) => state ?? logicalKey);
        break;
      case 'Sort':
        ref
            .read(sortKeyProvider.notifier)
            .update((state) => state ?? logicalKey);
        break;
      case 'Portal':
        ref
            .read(portalKeyProvider.notifier)
            .update((state) => state ?? logicalKey);
        break;
      case 'CRM':
        ref
            .read(crmKeyProvider.notifier)
            .update((state) => state ?? logicalKey);
        break;
      case 'Reports':
        ref
            .read(reportsKeyProvider.notifier)
            .update((state) => state ?? logicalKey);
        break;
      case 'Network':
        ref
            .read(networkKeyProvider.notifier)
            .update((state) => state ?? logicalKey);
        break;
      case 'Sidemenu':
        ref
            .read(togglesidemenu1.notifier)
            .update((state) => state ?? logicalKey);
        break;
      case 'Sidemenu2':
        ref
            .read(togglesidemenu2.notifier)
            .update((state) => state ?? logicalKey);

        break;
      case 'Addview':
        ref
            .read(adclientprovider.notifier)
            .update((state) => state ?? logicalKey);
        break;
      case 'Backspace':
        ref
            .read(backspaceKeyProvider.notifier)
            .update((state) => state ?? logicalKey);
        break;
    }
  });
}

final assignedKeysProvider = Provider<Map<LogicalKeyboardKey?, String>>((ref) {
  return {
    ref.watch(popKeyProvider): "Pop",
    ref.watch(portalKeyProvider): "Portal",
    ref.watch(networkKeyProvider): "Network",
    ref.watch(reportsKeyProvider): "Reports",
    ref.watch(crmKeyProvider): "CRM",
    ref.watch(backspaceKeyProvider): "Backspace",
    ref.watch(pedfKeyProvider): "PDF",
    ref.watch(filterKeyProvider): "Filter",
    ref.watch(sortKeyProvider): "Sort",
    ref.watch(togglesidemenu2): "Sidemenu",
  };
});
void updateShortcutKey(
    {required LogicalKeyboardKey newKey,
    required StateProvider<LogicalKeyboardKey?> targetProvider,
    required WidgetRef ref,
    required String shortcutname}) {
  final assignedKeys = ref.read(assignedKeysProvider);

  // Check if the new key is already assigned
  if (assignedKeys.containsKey(newKey)) {
    // Find the conflicting provider
    final conflictingShortcut = assignedKeys[newKey];

    // Swap keys for the conflicting shortcut
    switch (conflictingShortcut) {
      case "Pop":
        ref.read(popKeyProvider.notifier).state = ref.read(targetProvider);
        saveMap(ref.read(targetProvider)!, 'Pop');

        break;
      case "Portal":
        ref.read(portalKeyProvider.notifier).state = ref.read(targetProvider);
        saveMap(ref.read(targetProvider)!, 'Portal');

        break;
      case "Network":
        ref.read(networkKeyProvider.notifier).state = ref.read(targetProvider);
        saveMap(ref.read(targetProvider)!, 'Network');

        break;
      case "Reports":
        ref.read(reportsKeyProvider.notifier).state = ref.read(targetProvider);
        saveMap(ref.read(targetProvider)!, 'Reports');

        break;
      case "CRM":
        ref.read(crmKeyProvider.notifier).state = ref.read(targetProvider);
        saveMap(ref.read(targetProvider)!, 'CRM');

        break;
      case "Backspace":
        ref.read(backspaceKeyProvider.notifier).state =
            ref.read(targetProvider);
        saveMap(ref.read(targetProvider)!, 'Backspace');
        break;
      case "PDF":
        ref.read(pedfKeyProvider.notifier).state = ref.read(targetProvider);
        saveMap(ref.read(targetProvider)!, 'PDF');
        break;
      case "Filter":
        ref.read(filterKeyProvider.notifier).state = ref.read(targetProvider);
        saveMap(ref.read(targetProvider)!, 'Filter');
        break;
      case "Sort":
        ref.read(sortKeyProvider.notifier).state = ref.read(targetProvider);
        saveMap(ref.read(targetProvider)!, 'Sort');
        break;
      case "Sidemenu2":
        ref.read(togglesidemenu2.notifier).state = ref.read(targetProvider);
        saveMap(ref.read(targetProvider)!, 'Sidemenu2');
        break;
    }
  }

  // Update the target shortcut key
  ref.read(targetProvider.notifier).state = newKey;
  saveMap(ref.read(targetProvider.notifier).state!, shortcutname);
}

// Save the map to SharedPreferences
Future<void> saveMap(LogicalKeyboardKey value, String key) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  //prefs.clear();
  await prefs.setString(key, value.keyLabel);
  print(prefs.getString(key));

  final Set<String> keys = prefs.getKeys();
  for (String key in keys) {
    final value = prefs.get(key); // Get the value for each key
    print('Key: $key, Value: $value');
  }
}

class KeyboardSettingsScreen extends ConsumerStatefulWidget {
  @override
  _KeyboardSettingsScreenState createState() => _KeyboardSettingsScreenState();
}

class _KeyboardSettingsScreenState
    extends ConsumerState<KeyboardSettingsScreen> {
  final FocusNode _focusNode = FocusNode();
  final Map<LogicalKeyboardKey, String> keyActionMap = {};
  final ScrollController _scrollController = ScrollController();
  final Map<int, bool> rowVisibility = {};

  @override
  void initState() {
    super.initState();
    _focusNode.requestFocus(); // Automatically focus on the listener
  }

  void scrollToExpandedTile(GlobalKey expansionKey) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final context = expansionKey.currentContext;
      if (context != null) {
        Scrollable.ensureVisible(
          context,
          duration: const Duration(milliseconds: 300),
          alignment: 0.1, // Adjust alignment as needed
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final shortcuts = {
      "Pop": popKeyProvider,
      "Portal": portalKeyProvider,
      "Network": networkKeyProvider,
      "Reports": reportsKeyProvider,
      "CRM": crmKeyProvider,
      "Backspace": backspaceKeyProvider,
      "PDF": pedfKeyProvider,
      "Filter": filterKeyProvider,
      "Sort": sortKeyProvider,
      "Sidemenu2": togglesidemenu2,
    };

    // Update keyActionMap based on the current shortcut assignments
    keyActionMap.clear();
    shortcuts.forEach((action, provider) {
      final assignedKey = ref.watch(provider);
      if (assignedKey != null) {
        keyActionMap[assignedKey] = action;
      }
    });
    bool lastValue =
        rowVisibility.isNotEmpty ? rowVisibility.values.last : false;

    return SizedBox(
      height: lastValue ? 600 : 400,
      child: ListView.builder(
        controller: _scrollController,
        itemCount: shortcuts.length,
        itemBuilder: (context, index) {
          final shortcutName = shortcuts.keys.elementAt(index);
          final shortcutProvider = shortcuts.values.elementAt(index);
          final currentKey = ref.watch(shortcutProvider);

          return Column(
            children: [
              const SizedBox(height: 15),
              GestureDetector(
                  onTap: () {
                    setState(() {
                      rowVisibility[index] = !(rowVisibility[index] ?? false);
                    });
                  },
                  child: Row(
                    children: [
                      SizedBox(
                        width: 150, // Fixed width for the "Shortcut" text
                        child: Text(
                          "$shortcutName Shortcut",
                          style: TextStyle(
                              color: Theme.of(context).iconTheme.color),
                        ),
                      ),
                      Spacer(),
                      SizedBox(
                        width: 200, // Fixed width for the "Current: ..." text
                        child: Text(
                          "Current: ${currentKey?.keyLabel ?? "Not set"}",
                          style: TextStyle(
                              color: Theme.of(context).iconTheme.color),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Spacer(),
                      SvgPicture.asset(
                        AppIcons.pencil,
                        color: Theme.of(context).iconTheme.color,
                      ),
                    ],
                  )),
              if (rowVisibility[index] ?? false) ...[
                SizedBox(
                  height: 200, // Limit height of the child list
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: KeySelectionScreen(
                      currentkey: currentKey,
                      shortcutName: shortcutName,
                      ref: ref,
                      targetProvider: shortcutProvider,
                    ),
                  ),
                ),
              ],
            ],
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }
}

class KeySelectionScreen extends StatefulWidget {
  final String shortcutName;
  final LogicalKeyboardKey? currentkey;
  final StateProvider<LogicalKeyboardKey?> targetProvider;
  final WidgetRef ref;

  KeySelectionScreen(
      {required this.shortcutName,
      required this.targetProvider,
      required this.currentkey,
      required this.ref});

  @override
  _KeySelectionScreenState createState() => _KeySelectionScreenState();
}

class _KeySelectionScreenState extends State<KeySelectionScreen> {
  LogicalKeyboardKey? selectedKey;

  // Define key sets based on the action
  List<LogicalKeyboardKey> get availableKeys {
    switch (widget.shortcutName) {
      case "CRM":
      case "Portal":
      case "Network":
      case "Reports":
        // Number keys for CRM, Portal, Network, Reports
        return [
          LogicalKeyboardKey.digit1,
          LogicalKeyboardKey.digit2,
          LogicalKeyboardKey.digit3,
          LogicalKeyboardKey.digit4,
          LogicalKeyboardKey.digit5,
          LogicalKeyboardKey.digit6,
          LogicalKeyboardKey.digit7,
          LogicalKeyboardKey.digit8,
          LogicalKeyboardKey.digit9,
          LogicalKeyboardKey.digit0,
        ];
      case "Sort":
      case "PDF":
      case "Filter":
        // A limited set of alphabetic keys for Sort, PDF, Filter
        return [
          LogicalKeyboardKey.keyA,
          LogicalKeyboardKey.keyB,
          LogicalKeyboardKey.keyC,
          LogicalKeyboardKey.keyD,
          LogicalKeyboardKey.keyE,
        ];
      case "Pop":
        return [
          LogicalKeyboardKey.delete,
          LogicalKeyboardKey.escape,
          LogicalKeyboardKey.f1,
          LogicalKeyboardKey.f2,
          LogicalKeyboardKey.f3,
        ];
      case "Sidemenu2":
        return [
          LogicalKeyboardKey.altLeft,
          LogicalKeyboardKey.altRight,
          LogicalKeyboardKey.controlLeft,
          LogicalKeyboardKey.controlRight,
          LogicalKeyboardKey.shiftRight,
        ];
      default:
        // Default case (just return numbers)
        return [
          LogicalKeyboardKey.digit1,
          LogicalKeyboardKey.digit2,
          LogicalKeyboardKey.digit3,
        ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: availableKeys.map((key) {
        return ListTile(
          title: widget.shortcutName == 'Sidemenu2'
              ? Text(
                  "Lshift + ${key.keyLabel}",
                  style: TextStyle(color: Theme.of(context).iconTheme.color),
                )
              : Text(key.keyLabel,
                  style: TextStyle(color: Theme.of(context).iconTheme.color)),
          trailing: widget.currentkey == key
              ? SvgPicture.asset(AppIcons.check, color: Colors.green)
              : null,
          onTap: () {
            setState(() {
              selectedKey = key;
              updateShortcutKey(
                shortcutname: widget.shortcutName,
                newKey: selectedKey!,
                targetProvider: widget.targetProvider,
                ref: widget.ref,
              );
            });
          },
        );
      }).toList(),
    );
  }
}

final keyboardVisiblityprovider =
    StateNotifierProvider<keyboardVisiblity, bool>(
  (ref) => keyboardVisiblity(),
);

class keyboardVisiblity extends StateNotifier<bool> {
  keyboardVisiblity() : super(false); // Initial state is hidden (false)

  // Toggle visibility
  void toggleVisibility() {
    state = !state;
    print('Visibility toggled: $state');
  }
}
