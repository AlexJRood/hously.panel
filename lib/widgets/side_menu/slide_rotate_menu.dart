import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/const/backgroundgradient.dart';


class SideMenu extends ConsumerStatefulWidget {
  final Widget child;
  final Color? background;
  final BorderRadius? radius;
  final Icon? closeIcon;
  final Widget menu;
  final double maxMenuWidth;
  final ValueChanged<bool>? onChange;
  final int _inverse;

  const SideMenu({
    super.key,
    required this.child,
    this.background,
    this.radius,
    this.closeIcon = const Icon(Icons.arrow_forward_ios,
        color: Color.fromARGB(255, 255, 255, 255)),
    required this.menu,
    this.maxMenuWidth = 1920.0,
    bool inverse = false,
    this.onChange,
  }) : _inverse = inverse ? -1 : 1;

  @override
  SideMenuState createState() => SlideRotateSideMenuState();

  bool get inverse => _inverse == -1;
}

abstract class SideMenuState extends ConsumerState<SideMenu> {
  late bool _opened;

  @override
  void initState() {
    super.initState();
    _opened = false;
  }

  void openSideMenu() {
    setState(() => _opened = true);
    widget.onChange?.call(true);
  }

  void closeSideMenu() {
    setState(() => _opened = false);
    widget.onChange?.call(false);
  }

  bool get isOpened => _opened;
}

class SlideRotateSideMenuState extends SideMenuState {
  final GlobalKey _menuKey = GlobalKey();

  Matrix4 _getMatrix4(Size size) {
    if (_opened) {
      double scale = 0.75;
      double multiplier = size.width > 900 ? 0.335 : 0.75;
      double horizontalTranslation = size.width * multiplier * widget._inverse;
      double verticalTranslation = size.height * 0.125;

      return Matrix4.identity()
        ..scale(scale, scale)
        ..translate(horizontalTranslation, verticalTranslation);
    }
    return Matrix4.identity();
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final size = mq.size;

   
    return Material(
      child: Container(
        decoration: BoxDecoration(
          gradient:
              CustomBackgroundGradients.getSideMenuBackgroundcustom(context,ref)
         
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Positioned(
              key: _menuKey,
              top: 0,
              bottom: 0,
              width: min(500, widget.maxMenuWidth),
              right: widget._inverse == 1 ? null : 0,
              child: widget.menu,
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 550),
              curve: Curves.fastLinearToSlowEaseIn,
              transform: _getMatrix4(size),
              child: widget.child,
            ),
            if (!_opened)
              const SizedBox.shrink()
            else
              AnimatedPositioned(
                duration: const Duration(milliseconds: 50),
                curve: Curves.decelerate,
                top: 0,
                left: 0,
                right: 0,
                bottom: 0,
                child: GestureDetector(
                  onTap: closeSideMenu,
                  child: Transform(
                    transform: _getMatrix4(size),
                    child: Container(
                      alignment: Alignment.center,
                      child: ClipRect(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                          child: Container(
                            width: size.width,
                            height: size.height,
                            color: const Color.fromARGB(255, 0, 0, 0)
                                .withOpacity(0.2),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
