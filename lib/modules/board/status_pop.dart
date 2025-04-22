import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/modules/board/status_dialog.dart';
import 'package:hously_flutter/routing/navigation_service.dart';
import 'package:hously_flutter/theme/design/design.dart';

class StatusPop extends ConsumerWidget {
  const StatusPop({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // Efekt rozmycia tła
          BackdropFilter(
            filter: ui.ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(
              color: Colors.black.withOpacity(0.85),
              width: double.infinity,
              height: double.infinity,
            ),
          ),

          // Warstwa obsługująca zamknięcie modalu po kliknięciu w tło
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color:
                  Colors.transparent, // Przezroczyste tło, żeby było klikalne
            ),
          ),

          // Modal z zawartością
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: EdgeInsets.only(
                right: screenWidth * 0.2 - 45,
                top: screenHeight * 0.05,
              ),
              child: Hero(
                tag: 'StatusPopRevenue-${UniqueKey().toString()}', // need to be change both sides of hero need the same tag 
                child: Material(
                  color: Colors.transparent, // Usuń domyślne tło material
                  child: 
                        BackdropFilter(
            filter: ui.ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(
                      width: screenWidth * 0.2 <= 500 ? 450 : 450,
                      height: screenHeight * 0.8,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.0),
              color: Colors.black.withOpacity(0.85),
                      ),
                      child:
                           Row(
                              children: const [                              
                                BoardStatusDialog(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
