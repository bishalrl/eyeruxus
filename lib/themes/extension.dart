import 'package:flutter/material.dart';

extension WidgetExtension on Widget {
  Widget unfocus(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: this,
      behavior: HitTestBehavior.opaque,
    );
  }
}

extension BuildContextExtension on BuildContext {
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
}
