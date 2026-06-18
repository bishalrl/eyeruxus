import 'package:eye_rex_us/features/auth/presentation/theme/auth_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum AuthGender { male, female }

class AuthGenderSelector extends StatelessWidget {
  const AuthGenderSelector({
    super.key,
    required this.value,
    required this.maleLabel,
    required this.femaleLabel,
    required this.onChanged,
    this.enabled = true,
  });

  final AuthGender value;
  final String maleLabel;
  final String femaleLabel;
  final ValueChanged<AuthGender> onChanged;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _GenderPill(
            label: maleLabel,
            icon: Icons.male,
            selected: value == AuthGender.male,
            enabled: enabled,
            onTap: () => onChanged(AuthGender.male),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _GenderPill(
            label: femaleLabel,
            icon: Icons.female,
            selected: value == AuthGender.female,
            enabled: enabled,
            onTap: () => onChanged(AuthGender.female),
          ),
        ),
      ],
    );
  }
}

class _GenderPill extends StatelessWidget {
  const _GenderPill({
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
    required this.enabled,
  });

  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final bg = selected ? AuthTheme.formGenderSelected : AuthTheme.formGenderUnselected;
    final fg = selected ? Colors.white : AuthTheme.brandMuted;

    return Material(
      color: bg,
      borderRadius: BorderRadius.circular(999),
      child: InkWell(
        onTap: enabled ? onTap : null,
        borderRadius: BorderRadius.circular(999),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 20, color: fg),
              const SizedBox(width: 6),
              Text(
                label,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: fg,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
