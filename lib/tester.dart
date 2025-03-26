import 'package:flutter/material.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/const/route_constant.dart';
import 'package:hously_flutter/state_managers/services/navigation_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WebScaffold extends ConsumerWidget {
  final Widget currentPage;

  WebScaffold({required this.currentPage});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navService = ref.read(navigationService);

    return Scaffold(
      body: Row(
        children: [
          // Sidebar
          Container(
            width: 250,
            color: Colors.black87,
            child: Column(
              children: [
                const SizedBox(height: 50),
                ListTile(
                  title: Text("Profile", style: TextStyle(color: Colors.white)),
                  onTap: () =>
                      navService.pushNamedReplacementScreen(Routes.settingsprofile),
                ),
                ListTile(
                  title: Text("Notification",
                      style: TextStyle(color: Colors.white)),
                  onTap: () =>
                      navService.pushNamedReplacementScreen(Routes.settingsnotification),
                ),
                ListTile(
                  title: Text("Security & Privacy",
                      style: TextStyle(color: Colors.white)),
                  onTap: () => navService.pushNamedScreen('/tester/security'),
                ),
                ListTile(
                  title:
                      Text("Payments", style: TextStyle(color: Colors.white)),
                  onTap: () => navService.pushNamedScreen('/tester/payments'),
                ),
                ListTile(
                  title:
                      Text("Language", style: TextStyle(color: Colors.white)),
                  onTap: () => navService.pushNamedScreen('/tester/language'),
                ),
              ],
            ),
          ),

          // Main Content (Changes based on currentPage)
          Expanded(
            child: currentPage, // Dynamic content
          ),
        ],
      ),
    );
  }
}
