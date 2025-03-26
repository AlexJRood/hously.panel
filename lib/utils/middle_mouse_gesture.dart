import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class MiddleClickDetector extends StatefulWidget {
  final Widget child;
  final VoidCallback onMiddleClick;

  const MiddleClickDetector({
    Key? key,
    required this.child,
    required this.onMiddleClick,
  }) : super(key: key);

  @override
  _MiddleClickDetectorState createState() => _MiddleClickDetectorState();
}

class _MiddleClickDetectorState extends State<MiddleClickDetector> {
  Offset? _pointerDownPosition;
  bool _scrollOccurred = false;
  int? _activePointer;

  // Ustalony próg ruchu – jeśli kursor poruszy się o więcej niż 50 pikseli, gest zostanie anulowany.
  static const double _movementThreshold = 50.0;

  void _reset() {
    _pointerDownPosition = null;
    _scrollOccurred = false;
    _activePointer = null;
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (PointerDownEvent event) {
        if (event.kind == PointerDeviceKind.mouse && event.buttons == kMiddleMouseButton) {
          _pointerDownPosition = event.position;
          _activePointer = event.pointer;
          _scrollOccurred = false;
        }
      },
      onPointerSignal: (PointerSignalEvent event) {
        // Jeśli wykryjemy event scrolla (np. z kółka myszy), ustawiamy flagę.
        if (event is PointerScrollEvent && _activePointer != null) {
          _scrollOccurred = true;
        }
      },
      onPointerUp: (PointerUpEvent event) {
        if (event.kind == PointerDeviceKind.mouse && event.pointer == _activePointer) {
          // Sprawdzamy, czy nie wystąpił scroll oraz czy ruch jest niewielki.
          if (!_scrollOccurred && _pointerDownPosition != null) {
            final distance = (event.position - _pointerDownPosition!).distance;
            if (distance <= _movementThreshold) {
              widget.onMiddleClick();
            }
          }
          _reset();
        }
      },
      onPointerCancel: (PointerCancelEvent event) {
        if (event.pointer == _activePointer) {
          _reset();
        }
      },
      behavior: HitTestBehavior.opaque,
      child: widget.child,
    );
  }
}
