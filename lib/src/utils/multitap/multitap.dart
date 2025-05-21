import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class MultiTapGestureRecognizerEx extends GestureRecognizer {
  GestureMultiTapCallback? onShortTap;
  GestureMultiTapDownCallback? onLongTapDown;
  final recognizer = MultiTapGestureRecognizer(longTapDelay: kLongPressTimeout);

  bool _isLongTap = false;
  MultiTapGestureRecognizerEx({
    this.onShortTap,
    this.onLongTapDown,
  }) {
    recognizer.onTap = _onTap;
    recognizer.onLongTapDown = _onLongTapDown;
  }

  void _onTap(int pointer) {
    if (_isLongTap) {
      // not a short tap
      // reset for next tap
      _isLongTap = false;
      return;
    }

    onShortTap?.call(pointer);
  }

  void _onLongTapDown(int pointer, TapDownDetails details) {
    _isLongTap = true;
    onLongTapDown?.call(pointer, details);
  }

  @override
  void acceptGesture(int pointer) => recognizer.acceptGesture(pointer);

  @override
  String get debugDescription => recognizer.debugDescription;

  @override
  void rejectGesture(int pointer) => recognizer.rejectGesture(pointer);

  @override
  void addPointerPanZoom(PointerPanZoomStartEvent event) => recognizer.addPointerPanZoom(event);

  @override
  void addPointer(PointerDownEvent event) => recognizer.addPointer(event);

  @override
  void addAllowedPointer(PointerDownEvent event) => recognizer.addAllowedPointer(event);

  @protected
  @override
  PointerDeviceKind getKindForPointer(int pointer) => recognizer.getKindForPointer(pointer);

  @override
  void dispose() {
    recognizer.dispose(); // Prevents gesture conflicts and memory leaks
    super.dispose();
  }
}

class MultiTapGestureWrapper extends StatelessWidget {
  final Widget child;
  final GestureMultiTapCallback? onShortTap;
  final GestureMultiTapDownCallback? onLongTapDown;

  const MultiTapGestureWrapper({
    super.key,
    required this.child,
    this.onShortTap,
    this.onLongTapDown,
  });

  @override
  Widget build(BuildContext context) {
    return RawGestureDetector(
      gestures: {
        MultiTapGestureRecognizerEx: GestureRecognizerFactoryWithHandlers<MultiTapGestureRecognizerEx>(
          () => MultiTapGestureRecognizerEx(
            onShortTap: onShortTap,
            onLongTapDown: onLongTapDown,
          ),
          (instance) {},
        ),
      },
      behavior: HitTestBehavior.opaque,
      child: child,
    );
  }
}
