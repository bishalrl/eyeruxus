import 'package:flutter/material.dart';

class GuardianTier {
  final String title;
  final int coins;
  final List<Color> bgGradient;     // full-screen background
  final List<Color> headerArc;      // top arc glow
  final Color accent;               // buttons & primary accents
  final Color chipBg;
  final Color chipSelectedBg;
  final Color chipText;
  final Color chipSelectedText;

  const GuardianTier({
    required this.title,
    required this.coins,
    required this.bgGradient,
    required this.headerArc,
    required this.accent,
    required this.chipBg,
    required this.chipSelectedBg,
    required this.chipText,
    required this.chipSelectedText,
  });
}

// --- Themes (colors only) ---
const _tiers = <GuardianTier>[
  // Guardian of Silver
  GuardianTier(
    title: 'Guardian of Silver',
    coins: 150000,
    bgGradient: [Color(0xFF0E1B3C), Color(0xFF0B1530)],
    headerArc: [Color(0x332A6BFF), Color(0x00000000)],
    accent: Color(0xFF3DA1FF),
    chipBg: Color(0xFF1D2A52),
    chipSelectedBg: Color(0xFF223B77),
    chipText: Color(0xFF9FB6FF),
    chipSelectedText: Colors.white,
  ),
  // Guardian of Gold
  GuardianTier(
    title: 'Guardian of Gold',
    coins: 300000,
    bgGradient: [Color(0xFF2D1C02), Color(0xFF1E1405)],
    headerArc: [Color(0x33F6C247), Color(0x00000000)],
    accent: Color(0xFFF6B042),
    chipBg: Color(0xFF4A3714),
    chipSelectedBg: Color(0xFF6E4C16),
    chipText: Color(0xFFFFE2A9),
    chipSelectedText: Colors.white,
  ),
  // Guardian of the King
  GuardianTier(
    title: 'Guardian of the King',
    coins: 1500000,
    bgGradient: [Color(0xFF2B0B07), Color(0xFF1D0908)],
    headerArc: [Color(0x33FF6A3D), Color(0x00000000)],
    accent: Color(0xFFFF6A3D),
    chipBg: Color(0xFF4E231D),
    chipSelectedBg: Color(0xFF7B2D21),
    chipText: Color(0xFFFFC3B3),
    chipSelectedText: Colors.white,
  ),
];

class BuyGuardianScreen extends StatefulWidget {
  const BuyGuardianScreen({super.key});
  @override
  State<BuyGuardianScreen> createState() => _BuyGuardianScreenState();
}

class _BuyGuardianScreenState extends State<BuyGuardianScreen> {
  int tierIndex = 0;
  int monthIndex = 0; // 0=1m, 1=3m, 2=6m, 3=12m

  GuardianTier get tier => _tiers[tierIndex];

  void _next() => setState(() => tierIndex = (tierIndex + 1) % _tiers.length);
  void _prev() => setState(() => tierIndex = (tierIndex - 1 + _tiers.length) % _tiers.length);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Handle activation
        },
        backgroundColor: tier.accent,
        foregroundColor: Colors.white,
        elevation: 8,
        label: Text(
          'Activated ${tier.title}',
          style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
        ),
        icon: const Icon(Icons.shield_rounded),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: tier.bgGradient,
          ),
        ),
        child: SingleChildScrollView(
          child: SafeArea(
            bottom: false,
            child: Stack(
              children: [
                // top arc glow
                Positioned(
                  top: -size.width * 0.6,
                  left: -size.width * 0.2,
                  right: -size.width * 0.2,
                  child: IgnorePointer(
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 350),
                      height: size.width * 1.6,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: tier.headerArc,
                          stops: const [0.3, 1.0],
                        ),
                      ),
                    ),
                  ),
                ),
          
                // Content
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Header row
                    Padding(
                      padding: const EdgeInsets.fromLTRB(12, 0, 12, 4),
                      child: Row(
                        children: [
                          // Show back button only if not first tier
                          if (tierIndex > 0)
                            IconButton(
                              icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
                              onPressed: _prev,
                            )
                          else
                            const SizedBox(width: 48),
                          Spacer(),// placeholder for alignment
                          Center(
                            child: AnimatedScale(
                              duration: const Duration(milliseconds: 250),
                              scale: 1 + (tierIndex * 0.0001), // noop but forces animation
                              child: Container(
                                width: size.width * 0.55,
                                height: size.width * 0.55,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: RadialGradient(
                                    colors: [
                                      Colors.white.withOpacity(0.08),
                                      Colors.white.withOpacity(0.0),
                                    ],
                                    radius: 0.85,
                                  ),
                                ),
                                // TODO: Replace this with your emblem asset for each tier
                                child: Icon(Icons.shield, size: size.width * 0.28, color: tier.accent),
                              ),
                            ),
                          ),
                           Spacer(),
          
                          // Show forward button only if not last tier
                          if (tierIndex < _tiers.length - 1)
                            IconButton(
                              icon: const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white),
                              onPressed: _next,
                            )
                          else
                            const SizedBox(width: 48), // placeholder for alignment
                        ],
                      ),
                    ),
          
                    const SizedBox(height: 8),
          
                    // Emblem
          
          
                    const SizedBox(height: 6),
          
                    // Title
                    AnimatedDefaultTextStyle(
                      duration: const Duration(milliseconds: 250),
                      style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700),
                      child: Center(child: Text(tier.title)),
                    ),
          
                    const SizedBox(height: 14),
          
                    // Duration selector + price
                    _DurationAndPrice(
                      tier: tier,
                      monthIndex: monthIndex,
                      onSelect: (i) => setState(() => monthIndex = i),
                    ),
          
                    const SizedBox(height: 18),
          
                    // "I want to guard him/her" row
          
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 22),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('I want to guard him/her',
                              style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              // Bed icon
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Icon(
                                  Icons.weekend_rounded,
                                  color: Colors.white70,
                                  size: 20,
                                ),
                              ),
                              const SizedBox(width: 12),
                              const Spacer(),
                              _SelectButton(color: tier.accent),
                            ],
                          ),
                        ],
                      ),
                    ),
          
                    const SizedBox(height: 20),
          
                    // Privileges header
                    const Center(
                      child: Text(
                        'Guardian privileges',
                        style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                    ),
          
                    const SizedBox(height: 12),
          
                    // Privileges grid
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: _PrivilegesGrid(accent: tier.accent),
                    ),
          
                    const SizedBox(height: 100), // Space for floating button
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Duration selector + price
class _DurationAndPrice extends StatelessWidget {
  final GuardianTier tier;
  final int monthIndex;
  final ValueChanged<int> onSelect;
  const _DurationAndPrice({
    required this.tier,
    required this.monthIndex,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    final items = const ['1 Month', '3 Months', '6 Months', '12 Months'];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: Colors.white12, width: 1),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Duration chips in a single row
            Row(
              children: List.generate(items.length, (i) {
                final selected = monthIndex == i;
                return Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(right: i < items.length - 1 ? 8 : 0),
                    child: GestureDetector(
                      onTap: () => onSelect(i),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                        decoration: BoxDecoration(
                          color: selected ? tier.chipSelectedBg : tier.chipBg,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: selected ? tier.accent : Colors.white10,
                            width: selected ? 1.2 : 0.6,
                          ),
                        ),
                        child: Text(
                          items[i],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: selected ? tier.chipSelectedText : tier.chipText,
                            fontWeight: FontWeight.w700,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                const Spacer(),
                const Text('Coins needed:  ',
                    style: TextStyle(color: Colors.white70, fontWeight: FontWeight.w600)),
                _CoinTag(amount: tier.coins, accent: tier.accent),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _CoinTag extends StatelessWidget {
  final int amount;
  final Color accent;
  const _CoinTag({required this.amount, required this.accent});

  @override
  Widget build(BuildContext context) {
    String fmt(int n) {
      final s = n.toString();
      final buf = StringBuffer();
      for (int i = 0; i < s.length; i++) {
        final idx = s.length - i;
        buf.write(s[i]);
        if (idx > 1 && idx % 3 == 1) buf.write(',');
      }
      return buf.toString();
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.06),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.white12, width: 0.8),
      ),
      child: Row(
        children: [
          // Gold coin icon
          Container(
            width: 16,
            height: 16,
            decoration: BoxDecoration(
              color: const Color(0xFFFFD700), // Gold color
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFFFD700).withOpacity(0.3),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: const Icon(
              Icons.monetization_on,
              size: 10,
              color: Color(0xFFB8860B), // Darker gold for contrast
            ),
          ),
          const SizedBox(width: 6),
          Text(fmt(amount),
              style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w800)),
        ],
      ),
    );
  }
}

class _SelectButton extends StatelessWidget {
  final Color color;
  const _SelectButton({required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 5),
      decoration: BoxDecoration(
        color: color.withOpacity(0.16),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: color.withOpacity(0.6), width: 1),
      ),
      child: const Text(
        'Select',
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
      ),
    );
  }
}

class _PrivilegesGrid extends StatelessWidget {
  final Color accent;
  const _PrivilegesGrid({required this.accent});

  @override
  Widget build(BuildContext context) {
    const labels = [
      'Higher Rank',
      'Distinguished logo',
      'Special entry effect',
      'Exclusive bubbles',
      'Privileged Gifts',
    ];
    const icons = [
      Icons.trending_up_rounded,
      Icons.verified_rounded,
      Icons.local_fire_department_rounded,
      Icons.chat_bubble_outline_rounded,
      Icons.card_giftcard_rounded,
    ];

    return Column(
      children: [
        // First row - 3 items
        Row(
          children: List.generate(3, (i) => Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: i < 2 ? 8 : 0),
              child: _PrivilegeCard(
                label: labels[i],
                icon: icons[i],
                accent: accent,
              ),
            ),
          )),
        ),
        const SizedBox(height: 8),
        // Second row - 2 items centered
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.28,
              child: _PrivilegeCard(
                label: labels[3],
                icon: icons[3],
                accent: accent,
              ),
            ),
            const SizedBox(width: 8),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.28,
              child: _PrivilegeCard(
                label: labels[4],
                icon: icons[4],
                accent: accent,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _PrivilegeCard extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color accent;

  const _PrivilegeCard({
    required this.label,
    required this.icon,
    required this.accent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white12, width: 0.8),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: accent, size: 24),
          const SizedBox(height: 6),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 11,
                fontWeight: FontWeight.w600
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}