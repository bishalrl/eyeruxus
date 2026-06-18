import 'package:flutter/material.dart';

import '../theme/auth_theme.dart';

class AuthGlassTextField extends StatefulWidget {
  const AuthGlassTextField({
    super.key,
    required this.controller,
    required this.label,
    this.hint,
    this.icon = Icons.mail_outline,
    this.obscureText = false,
    this.keyboardType,
    this.validator,
    this.suffix,
    this.hideLabel = false,
  });

  final TextEditingController controller;
  final String label;
  final bool hideLabel;
  final String? hint;
  final IconData icon;
  final bool obscureText;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final Widget? suffix;

  @override
  State<AuthGlassTextField> createState() => _AuthGlassTextFieldState();
}

class _AuthGlassTextFieldState extends State<AuthGlassTextField> {
  final _focusNode = FocusNode();

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!widget.hideLabel && widget.label.isNotEmpty)
          ListenableBuilder(
            listenable: _focusNode,
            builder: (context, _) {
              final focused = _focusNode.hasFocus;
              return Padding(
                padding: const EdgeInsets.only(left: 4, bottom: 4),
                child: Text(
                  widget.label,
                  style: AuthTheme.labelMd(
                    context,
                    color: focused ? AuthTheme.primary : AuthTheme.onSurfaceVariant,
                  ),
                ),
              );
            },
          ),
        ListenableBuilder(
          listenable: _focusNode,
          builder: (context, _) {
            final focused = _focusNode.hasFocus;
            return TextFormField(
              controller: widget.controller,
              focusNode: _focusNode,
              obscureText: widget.obscureText,
              keyboardType: widget.keyboardType,
              validator: widget.validator,
              style: AuthTheme.bodyMd(context),
              decoration: InputDecoration(
                hintText: widget.hint,
                hintStyle: AuthTheme.bodyMd(context).copyWith(color: AuthTheme.outline),
                prefixIcon: Icon(
                  widget.icon,
                  size: 20,
                  color: focused ? AuthTheme.primary : AuthTheme.outline,
                ),
                suffixIcon: widget.suffix,
                filled: true,
                fillColor: focused
                    ? AuthTheme.surfaceContainerLowest
                    : const Color(0xB3F9FAFB),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: AuthTheme.onBackground.withValues(alpha: 0.08),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: AuthTheme.onBackground.withValues(alpha: 0.08),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AuthTheme.primary, width: 1.5),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AuthTheme.error),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AuthTheme.error),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
