import 'package:flutter/material.dart';

/// Consistent full-screen container for legacy live UIs.
class LiveSessionShell extends StatelessWidget {
  const LiveSessionShell({
    super.key,
    required this.child,
    this.embedded = false,
  });

  /// When true, fills the parent (e.g. bottom-nav tab) without adding a scaffold.
  final bool embedded;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (embedded) {
      return LayoutBuilder(
        builder: (context, constraints) {
          return Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              width: constraints.maxWidth,
              height: constraints.maxHeight,
              child: child,
            ),
          );
        },
      );
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        top: false,
        bottom: false,
        child: SizedBox.expand(child: child),
      ),
    );
  }
}
