import 'package:eye_rex_us/features/auth/presentation/theme/auth_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

/// Underlined form field from the registration mockup.
class AuthFormField extends StatelessWidget {
  const AuthFormField({
    super.key,
    required this.label,
    required this.controller,
    this.hint,
    this.labelSuffix,
    this.keyboardType,
    this.obscureText = false,
    this.readOnly = false,
    this.onTap,
    this.validator,
    this.suffix,
    this.onChanged,
    this.inputFormatters,
    this.maxLength,
  });

  final String label;
  final String? labelSuffix;
  final TextEditingController controller;
  final String? hint;
  final TextInputType? keyboardType;
  final bool obscureText;
  final bool readOnly;
  final VoidCallback? onTap;
  final String? Function(String?)? validator;
  final Widget? suffix;
  final ValueChanged<String>? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AuthTheme.formLabel,
              ),
            ),
            if (labelSuffix != null) ...[
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  labelSuffix!,
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    color: AuthTheme.brandMuted,
                  ),
                ),
              ),
            ],
          ],
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obscureText,
          readOnly: readOnly,
          onTap: onTap,
          onChanged: onChanged,
          validator: validator,
          inputFormatters: inputFormatters,
          maxLength: maxLength,
          style: GoogleFonts.poppins(fontSize: 15, color: AuthTheme.onSurface),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.poppins(fontSize: 14, color: AuthTheme.brandMuted),
            counterText: '',
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(vertical: 10),
            border: const UnderlineInputBorder(
              borderSide: BorderSide(color: AuthTheme.formDivider),
            ),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: AuthTheme.formDivider),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: AuthTheme.formTeal, width: 1.5),
            ),
            suffixIcon: suffix,
            suffixIconConstraints: const BoxConstraints(minWidth: 32, minHeight: 32),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
