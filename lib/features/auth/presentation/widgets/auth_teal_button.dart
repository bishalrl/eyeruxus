import 'package:eye_rex_us/features/auth/presentation/theme/auth_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Primary teal "Save" button from the registration mockup.
class AuthTealButton extends StatelessWidget {
  const AuthTealButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: FilledButton(
        onPressed: onPressed,
        style: FilledButton.styleFrom(
          backgroundColor: AuthTheme.formTeal,
          foregroundColor: Colors.white,
          disabledBackgroundColor: AuthTheme.formTeal.withValues(alpha: 0.45),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 0,
        ),
        child: Text(
          label,
          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
