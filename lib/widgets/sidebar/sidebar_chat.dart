import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/const/route_constant.dart';
import 'package:hously_flutter/data/design/design.dart';
import 'package:hously_flutter/state_managers/services/navigation_service.dart';
import 'dart:ui' as ui;
import 'package:hously_flutter/theme/apptheme.dart';


class SidebarChat extends ConsumerWidget {
  const SidebarChat({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeColorsProvider);
    
    return Container(
      width: 60, height: double.infinity,
      child: ClipRRect(
        child: Stack(
          children: [        
            BackdropFilter(
              filter: ui.ImageFilter.blur(sigmaX: 50, sigmaY: 50),
              child: Container(
                  color: theme.fillColor.withOpacity(0.15),
                width: double.infinity,
                height: double.infinity,
              ),
            ),
            Container(
              width: 60.0,
              height: MediaQuery.of(context).size.height,
              padding: const EdgeInsets.only(top: 25, bottom: 10.0),
              // decoration: BoxDecoration(
              //     gradient: CustomBackgroundGradients.getSideMenuBackgroundcustom(
              //         context, ref)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Column(
                          children: [
                            Icon(Icons.arrow_back_ios_new_rounded,
                                color: Theme.of(context).iconTheme.color,
                                size: 25.0), // Poprawne użycie ikony jako widgetu
                            const SizedBox(height: 5.0),
                            const Text('',
                                style:
                                    TextStyle(fontSize: 10, color: Colors.white)),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () => ref
                            .read(navigationService)
                            .pushNamedReplacementScreen(Routes.mapView),
                        child: Text('AI',
                            style: AppTextStyles.interLight.copyWith(
                                fontSize: 18,
                                color: Theme.of(context).iconTheme.color)),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Column(
                    children: [
                      InkWell(
                        onTap: () => ref
                            .read(navigationService)
                            .pushNamedReplacementScreen(Routes.settings),
                        child: Column(
                          children: [
                            Icon(
                              Icons.settings,
                              color: Theme.of(context).iconTheme.color,
                              size: 25.0,
                            ), // Upewnij się, że AppColors jest poprawnie zdefiniowane
                            const SizedBox(height: 5.0),
                            const Text(
                              '',
                              style: TextStyle(fontSize: 10, color: Colors.white),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
