import 'package:flutter/material.dart';

/* ==================== COLORS & STYLES ==================== */

class MallColors {
  // Background sky gradients (top → bottom)
  static const skyTop = Color(0xFF7CC1FF);   // light sky blue
  static const skyMid = Color(0xFF9A8BFF);   // periwinkle
  static const skyBottom = Color(0xFFF2E7FF); // pale lavender

  // Header cards
  static const headerCardStart = Color(0xFFB79AFF); // soft purple
  static const headerCardEnd   = Color(0xFFA782FF); // little deeper purple

  // Item card gradient (very light)
  static const cardStart = Color(0xFFF0E9FF);
  static const cardEnd   = Color(0xFFE6DAFF);

  // Accent chips
  static const chipBg = Color(0xFFEEE4FF);
  static const chipText = Color(0xFF7E45FF);

  // Text
  static const txtMain = Color(0xFF5C2EFF);  // saturated purple
  static const txtDark = Color(0xFF3E1D98);  // deep purple for titles
  static const txtBody = Color(0xFF6F65A8);  // muted purple/grey
}

const kCardRadius = 18.0;
const kSectionHPad = 20.0;

/* ==================== PAGE ==================== */

class HonorMallPage extends StatelessWidget {
  const HonorMallPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // soft vertical background gradient like the screenshot
        Container(
          decoration: const BoxDecoration(
             color: Colors.white
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            centerTitle: true,

            leading: GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Icon(Icons.arrow_back_ios,color: Colors.black,)),
            title: Text(
              'Honor Mall',
              style: TextStyle(
                color: Colors.black,
                fontSize: 22,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.2,
              ),
            ),
          ),
          body: SafeArea(
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: kSectionHPad, vertical: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            gradient: LinearGradient(
                              colors: [Color(0xFF8263ff), Color(0xFF9B7BF5)], // top gradient
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          child: Column(
                            children: [
                              // Top Container (My Honor Coupons)
                              Container(
                                padding: EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                                  color: Colors.transparent,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "My Honor Coupons:",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            SizedBox(width: 6),
                                            Icon(Icons.help_outline, color: Colors.white70, size: 18),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Icon(Icons.local_activity, color: Colors.orange, size: 20),
                                            SizedBox(width: 4),
                                            Text(
                                              "0",
                                              style: TextStyle(
                                                color: Colors.orange,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    Text(
                                      "Details",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Icon(Icons.chevron_right, color: Colors.white, size: 20),
                                  ],
                                ),
                              ),

                              // Bottom Container (Honor level)
                              Container(
                                padding: EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.vertical(bottom: Radius.circular(12)),
                                  color: Color(0xFFb191fe), // darker purple bottom
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          width: 22,
                                          height: 22,
                                          decoration: BoxDecoration(
                                            color: Colors.green,
                                            shape: BoxShape.circle,
                                          ),
                                          child: Center(
                                            child: Text(
                                              "P",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 8),
                                        Text(
                                          "Honor level: V0",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    Text(
                                      "Detail",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Icon(Icons.chevron_right, color: Colors.white, size: 20),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
,
                        const SizedBox(height: 30),
                        _SectionTitle('Privileges - Functions', MallColors.txtDark),
                        const SizedBox(height: 12),
                        MallItemCard(
                          tagText: 'level 6 or above can be purchased',
                          title: 'Moments Pin Card',
                          subtitle: 'honor voucher:400',
                          leading: _circleIcon(Icons.upload_rounded),
                        ),
                        const SizedBox(height: 18),
                        _SectionTitle('Decoration',MallColors.txtMain),
                        const SizedBox(height: 12),
                        MallItemCard(
                          tagText: 'level 7 or above can be purchased',
                          title: 'Honor Information Card-\n2months',
                          subtitle: 'honor voucher:1,200',
                          leading: _squareBadgeIcon(),
                        ),
                        const SizedBox(height: 18),
                        _SectionTitle('Gift',MallColors.txtBody),
                        const SizedBox(height: 12),
                        MallItemCard(
                          tagText: 'level 7 or above can be purchased',
                          title: 'Customized Gift-2\nmonths',
                          subtitle: 'honor voucher:3,000',
                          leading: _giftIcon(),
                        ),
                        const SizedBox(height: 18),
                        _SectionTitle('Privileges Unblocking',MallColors.txtBody),
                        const SizedBox(height: 12),
                        MallItemCard(
                          tagText: 'level 6 or above can be purchased',
                          title: 'Account Unblocking',
                          subtitle: 'honor voucher:400',
                          leading: _avatarCheckIcon(),
                        ),
                        const SizedBox(height: 14),
                        MallItemCard(
                          tagText: 'level 6 or above can be purchased',
                          title: 'Feature Unblocking',
                          subtitle: 'honor voucher:200',
                          leading: _cogIcon(),
                        ),
                        const SizedBox(height: 32),

                        _SectionTitle( 'Banner',Color(0xFFFF6B35)),

                        SizedBox(height: 10),

                        // Banner 72h
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                Color(0xFFFFE4D6),
                                Color(0xFFFFF0E6),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      Color(0xFFFF8A50),
                                      Color(0xFFFF6B35),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Icon(
                                  Icons.card_giftcard,
                                  color: Colors.white,
                                  size: 25,
                                ),
                              ),
                              SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Banner-72h',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFFFF6B35),
                                      ),
                                    ),

                                    Text(
                                      'honor voucher:1,200',
                                      style: TextStyle(
                                        fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        color: Color(0xFFFF8A50),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: Color(0xFFFF6B35),
                                size: 20,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 16),

                        // Banner 24h
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                Color(0xFFFFE4D6),
                                Color(0xFFFFF0E6),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      Color(0xFFFF8A50),
                                      Color(0xFFFF6B35),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Icon(
                                  Icons.card_giftcard,
                                  color: Colors.white,
                                  size: 25,
                                ),
                              ),
                              SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Banner-24h',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFFFF6B35),
                                      ),
                                    ),

                                    Text(
                                      'honor voucher:500',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFFFF8A50),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: Color(0xFFFF6B35),
                                size: 20,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 40),
                        _SectionTitle( 'App open screen',Color(0xFF4A90E2)),
                        SizedBox(height: 10),

                        // Open screen 72h
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(18),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                Color(0xFFE3F2FD),
                                Color(0xFFF0F8FF),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      Color(0xFF64B5F6),
                                      Color(0xFF4A90E2),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Icon(
                                  Icons.phone_android,
                                  color: Colors.white,
                                  size: 25,
                                ),
                              ),
                              SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Open screen - 72h',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF4A90E2),
                                      ),
                                    ),

                                    Text(
                                      'honor voucher:1,400',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFF64B5F6),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: Color(0xFF4A90E2),
                                size: 20,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 16),

                        // Open screen 24h
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(18),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                Color(0xFFE3F2FD),
                                Color(0xFFF0F8FF),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      Color(0xFF64B5F6),
                                      Color(0xFF4A90E2),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Icon(
                                  Icons.phone_android,
                                  color: Colors.white,
                                  size: 25,
                                ),
                              ),
                              SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Open screen - 24h',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF4A90E2),
                                      ),
                                    ),

                                    Text(
                                      'honor voucher:600',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFF64B5F6),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: Color(0xFF4A90E2),
                                size: 20,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 40),

                        Center(
                          child: Text(
                            'More benefits are coming!',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[600],
                            ),
                          ),
                        ),
                        SizedBox(height: 20),

                        Center(
                          child: Container(
                            width: 150,
                            height: 4,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  final Color color;

  const _SectionTitle(this.title, this.color);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        color: color,
        fontSize: 18,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}

class MallItemCard extends StatelessWidget {
  final String tagText;
  final String title;
  final String subtitle;
  final Widget leading;

  const MallItemCard({
    super.key,
    required this.tagText,
    required this.title,
    required this.subtitle,
    required this.leading,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [MallColors.cardStart, MallColors.cardEnd],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(kCardRadius),
      ),
      child: Row(
        children: [
          leading,
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: MallColors.chipBg,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    tagText,
                    style: const TextStyle(
                      color: MallColors.chipText,
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  title,
                  style: const TextStyle(
                    color: MallColors.txtDark,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: MallColors.txtBody,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: MallColors.txtBody),
        ],
      ),
    );
  }
}

Widget _circleIcon(IconData icon) {
  return Container(
    width: 48,
    height: 48,
    decoration: BoxDecoration(
      color: MallColors.chipBg,
      shape: BoxShape.circle,
    ),
    child: Icon(icon, color: MallColors.txtMain, size: 24),
  );
}

Widget _squareBadgeIcon() {
  return Container(
    width: 48,
    height: 48,
    decoration: BoxDecoration(
      color: MallColors.chipBg,
      borderRadius: BorderRadius.circular(12),
    ),
    child: const Icon(Icons.badge_outlined, color: MallColors.txtMain, size: 24),
  );
}

Widget _giftIcon() {
  return Container(
    width: 48,
    height: 48,
    decoration: BoxDecoration(
      color: MallColors.chipBg,
      borderRadius: BorderRadius.circular(12),
    ),
    child: const Icon(Icons.card_giftcard, color: MallColors.txtMain, size: 24),
  );
}

Widget _avatarCheckIcon() {
  return Container(
    width: 48,
    height: 48,
    decoration: BoxDecoration(
      color: MallColors.chipBg,
      shape: BoxShape.circle,
    ),
    child: const Icon(Icons.verified_user, color: MallColors.txtMain, size: 24),
  );
}

Widget _cogIcon() {
  return Container(
    width: 48,
    height: 48,
    decoration: BoxDecoration(
      color: MallColors.chipBg,
      borderRadius: BorderRadius.circular(12),
    ),
    child: const Icon(Icons.settings, color: MallColors.txtMain, size: 24),
  );
}

