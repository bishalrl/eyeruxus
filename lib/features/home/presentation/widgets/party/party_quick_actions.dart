import 'package:eye_rex_us/core/extensions/context_extensions.dart';
import 'package:eye_rex_us/features/home/presentation/theme/home_colors.dart';
import 'package:flutter/material.dart';

class PartyQuickActions extends StatelessWidget {
  const PartyQuickActions({
    super.key,
    required this.onCreateParty,
    required this.onPartyThemes,
  });

  final VoidCallback onCreateParty;
  final VoidCallback onPartyThemes;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      child: Row(
        children: [
          Expanded(
            child: _ActionButton(
              icon: Icons.celebration_outlined,
              label: l10n.homePartyCreate,
              gradient: HomeColors.goLiveGradient,
              onTap: onCreateParty,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: _ActionButton(
              icon: Icons.palette_outlined,
              label: l10n.homePartyThemes,
              color: HomeColors.profileCard,
              onTap: onPartyThemes,
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
    this.gradient,
    this.color,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Gradient? gradient;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Ink(
          decoration: BoxDecoration(
            gradient: gradient,
            color: gradient == null ? color : null,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: 20,
                  color: gradient != null ? HomeColors.textWhite : HomeColors.partyAccent,
                ),
                const SizedBox(width: 8),
                Flexible(
                  child: Text(
                    label,
                    style: TextStyle(
                      color: gradient != null ? HomeColors.textWhite : HomeColors.textWhite,
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
