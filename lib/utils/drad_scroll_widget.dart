import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/routing/navigation_service.dart';

class DragScrollView extends StatelessWidget {
  final ScrollController controller;
  final Widget child;
  final Axis scrollDirection;

  const DragScrollView({
    Key? key,
    required this.controller,
    required this.child,
    this.scrollDirection = Axis.horizontal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
        behavior: const MaterialScrollBehavior().copyWith(
          scrollbars: true, // Enable scrollbars for better UX
          dragDevices: {
            PointerDeviceKind.mouse,
            PointerDeviceKind.touch,
            PointerDeviceKind.stylus,
            PointerDeviceKind.trackpad,
          }, // Allow dragging with mouse
        ),
        child: child);
  }
}

class DragScrollPop extends ConsumerWidget {
  final Widget child;
  final scrollcontroller;
  const DragScrollPop({
    Key? key,
    required this.scrollcontroller,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    return GestureDetector(
      onVerticalDragUpdate: (details) {
        if (scrollcontroller.offset == 0 && details.primaryDelta! > 0) {
          // Close the page when dragged down at the top
          ref.read(navigationService).beamPop();
        } else {
          scrollcontroller.jumpTo(
            scrollcontroller.offset - details.primaryDelta!,
          );
        }
      },
      child: child,
    );
  }
}

class DragPoponlyWidget extends ConsumerWidget {
  final Widget child;

  const DragPoponlyWidget({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    return GestureDetector(
      onVerticalDragUpdate: (details) {
        if (details.primaryDelta != null && details.primaryDelta! > 10) {
          ref.read(navigationService).beamPop();
        }
      },
      child: child,
    );
  }
}
