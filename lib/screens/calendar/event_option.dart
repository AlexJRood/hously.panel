import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hously_flutter/const/icons.dart';
import 'package:hously_flutter/state_managers/services/navigation_service.dart';
import 'package:hously_flutter/theme/apptheme.dart';

class EventOption extends ConsumerWidget {
  final String title;
  final Widget pageWidget;

  const EventOption({super.key, required this.title, required this.pageWidget});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme=ref.watch(themeColorsProvider);
    return Scaffold(
      backgroundColor:theme.fillColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              IconButton(
                onPressed: () {
                  ref.read(navigationService).beamPop(context);
                },
                icon:  SvgPicture.asset(AppIcons.iosArrowLeft,color: theme.textFieldColor,),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    Text(title,
                        style: TextStyle(
                            fontSize: 20,
                            color:  theme.textFieldColor)),
                    const SizedBox(height: 30),
                    pageWidget,
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
