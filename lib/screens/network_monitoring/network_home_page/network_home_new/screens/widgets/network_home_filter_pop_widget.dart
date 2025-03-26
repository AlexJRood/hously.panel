import 'package:flutter/material.dart';
import 'package:hously_flutter/data/design/design.dart';
import 'dart:ui' as ui;
import 'package:hously_flutter/screens/filters/new_screens/new_filters_pop_pc.dart';
import 'package:hously_flutter/screens/network_monitoring/network_home_page/network_home_new/screens/widgets/search_history_list_widget.dart';

class NetworkHomeFilterPopWidget extends StatelessWidget {
  const NetworkHomeFilterPopWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final screenWidth = size.width;
    print(screenWidth);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          BackdropFilter(
            filter: ui.ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(
              color: AppColors.dark75,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            }),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if(screenWidth> 1080)
                      const SearchHistoryList(),
                      const SizedBox(
                        width: 870,
                        child: NewFiltersPopPc())
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
