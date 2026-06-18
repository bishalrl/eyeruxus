import 'package:eye_rex_us/core/extensions/context_extensions.dart';
import 'package:eye_rex_us/features/auth/presentation/theme/auth_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// eRupai logo block from the login mockup — white card + wordmark + coins.
class AuthErupaiLogo extends StatelessWidget {
  const AuthErupaiLogo({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Column(
      children: [
        Text(
          l10n.authLogoLabel,
          style: AuthTheme.captionMuted(context).copyWith(letterSpacing: 1.2),
        ),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 32),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.06),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'e',
                      style: GoogleFonts.poppins(
                        fontSize: 42,
                        fontWeight: FontWeight.w600,
                        color: AuthTheme.brandRed,
                      ),
                    ),
                    TextSpan(
                      text: 'R',
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 48,
                        fontWeight: FontWeight.w700,
                        color: AuthTheme.brandBlue,
                        height: 1,
                      ),
                    ),
                    TextSpan(
                      text: 'upai',
                      style: GoogleFonts.poppins(
                        fontSize: 42,
                        fontWeight: FontWeight.w600,
                        color: AuthTheme.brandRed,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              const _CoinStack(),
            ],
          ),
        ),
      ],
    );
  }
}

class _CoinStack extends StatelessWidget {
  const _CoinStack();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 36,
      height: 40,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(bottom: 0, left: 4, child: _coin(28, 0.85)),
          Positioned(bottom: 6, left: 10, child: _coin(26, 0.95)),
          Positioned(bottom: 12, left: 2, child: _coin(24, 1)),
        ],
      ),
    );
  }

  Widget _coin(double size, double opacity) {
    return Opacity(
      opacity: opacity,
      child: Container(
        width: size,
        height: size * 0.35,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(size),
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFFFD54F), Color(0xFFF9A825)],
          ),
          border: Border.all(color: const Color(0xFFE65100), width: 1.2),
        ),
      ),
    );
  }
}
