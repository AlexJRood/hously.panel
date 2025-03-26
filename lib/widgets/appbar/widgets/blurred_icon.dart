import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class BlurredIconDemo extends StatelessWidget {
  const BlurredIconDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 1) Tło – może być czymkolwiek (kolor, obrazek, layout)
          Container(color: Colors.green),
          
          // 2) Warstwa rozmywająca CAŁE tło (Positioned.fill => rozciąga się na cały ekran)
          Positioned.fill(
            child: BackdropFilter(
              filter: ui.ImageFilter.blur(sigmaX: 15, sigmaY: 15),
              child: Container(color: Colors.transparent),
            ),
          ),
          
          // 3) "Maska" (ShaderMask) z blendMode, który sprawi,
          // że widoczny będzie tylko kształt ikony = rozmazany fragment tła.
          Positioned.fill(
            child: ShaderMask(
              blendMode: BlendMode.srcIn,
              shaderCallback: (Rect bounds) {
                // Tutaj wystarczy biały gradient
                return const LinearGradient(
                  colors: [Colors.white, Colors.white],
                ).createShader(bounds);
              },
              child: BackdropFilter(
              filter: ui.ImageFilter.blur(sigmaX: 15, sigmaY: 15),
              child: Center(
                child: Icon(
                  Icons.android,
                  size: 120,
                  // color w przypadku srcIn nie będzie ostatecznie widoczny –
                  // „kolorem” ikony będzie ten rozmyty obszar z warstwy 2.
                  color: Colors.white,
                ),
              ),
            ),
          ),),
        ],
      ),
    );
  }
}
