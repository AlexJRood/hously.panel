import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/data/design/button_style.dart';
import 'package:hously_flutter/screens/pop_pages/view_settings_page.dart';

class TestFile extends ConsumerWidget {
  const TestFile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          const Text(
            'Testing 2222',
            style: TextStyle(color: Colors.black, fontSize: 30),
          ),
          // Normal content of the first screen
          Center(
            child: ElevatedButton(
              style: elevatedButtonStyleRounded,
              onPressed: () {
                Navigator.of(context).push(
                  PageRouteBuilder(
                    opaque: false,
                    pageBuilder: (_, __, ___) => const ViewSettingsPage(),
                    transitionsBuilder: (_, anim, __, child) {
                      return FadeTransition(opacity: anim, child: child);
                    },
                  ),
                );
              },
              child: Hero(
                tag: 'CoToMaRobic',
                child: Container(
                  height: 35,
                  width: 35,
                  color: Colors.transparent,
                  child: const Icon(Icons.pie_chart,
                      size: 30.0, color: Colors.red),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
