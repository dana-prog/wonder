import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../logger.dart';

OverlayEntry? _overlayEntry;

typedef OverlayContentFrameBuilder = Widget Function(
  BuildContext context,
  Widget child,
);

Widget _defaultFrameBuilder(
  BuildContext context,
  Widget child,
) =>
    // TODO: add a close button
    ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 500), // or whatever you want
      child: IntrinsicWidth(
        child: IntrinsicHeight(
          child: Material(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: child,
                ),
              )),
        ),
      ),
    );
// Container(
//   // width: MediaQuery.of(context).size.width * 0.8,
//   padding: const EdgeInsets.all(16),
//   decoration: BoxDecoration(
//     color: Colors.white,
//     borderRadius: BorderRadius.circular(12),
//   ),
//   child: child,
// );

void showBlurredOverlay(
  BuildContext context,
  Widget content, {
  String? route,
  OverlayContentFrameBuilder? frameBuilder,
}) {
  logger.d('[showBlurredOverlay] show blurred overlay');

  final overlay = Overlay.of(context);

  _overlayEntry = OverlayEntry(
    builder: (context) => Stack(
      children: [
        // tap on the background will close the overlay
        const _OverlayBlurredBackdrop(onTap: _closeOverlay),
        _OverlayContent(
          // tap on the content will close the overlay and navigate to the route (if exists)
          onTap: () {
            if (route != null) {
              logger.d('[showBlurredOverlay] navigate to $route');
              _closeOverlay();
              context.push(route);
            }
          },
          content: content,
          frameBuilder: frameBuilder,
        ),
      ],
    ),
  );

  overlay.insert(_overlayEntry!);
}

void _closeOverlay() {
  logger.d('[_closeOverlay] close overlay');
  _overlayEntry?.remove();
  _overlayEntry = null;
}

class _OverlayBlurredBackdrop extends StatelessWidget {
  final GestureTapCallback? onTap;

  const _OverlayBlurredBackdrop({this.onTap});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: GestureDetector(
            onTap: onTap,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(color: const Color.fromRGBO(0, 0, 0, 0.5)),
            ),
          ),
        ),
      ],
    );
  }
}

class _OverlayContent extends StatelessWidget {
  final Widget content;
  final GestureTapCallback? onTap;
  final OverlayContentFrameBuilder? frameBuilder;

  const _OverlayContent({required this.content, this.onTap, this.frameBuilder});

  @override
  Widget build(BuildContext context) {
    // return Center(
    return Align(
      // alignment: Alignment.center,
      child: Material(
        color: Colors.transparent,
        child: GestureDetector(
          onTap: onTap,
          // TODO: why do we need Stack here?
          child: Stack(
            children: [
              frameBuilder?.call(context, content) ?? _defaultFrameBuilder(context, content),
            ],
          ),
        ),
      ),
    );
  }
}
