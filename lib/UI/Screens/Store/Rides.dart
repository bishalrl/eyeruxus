import 'package:flutter/material.dart';

class RidesScreen extends StatefulWidget {
  const RidesScreen({super.key});

  @override
  State<RidesScreen> createState() => _RidesScreenState();
}

class _RidesScreenState extends State<RidesScreen> {
  final List<Map<String, dynamic>> _rides = [
    {
      'name': 'Flame and Thunder',
      'img': 'https://picsum.photos/seed/car1/800/500',
      'ticket': 1000,
      'coin': null,
    },
    {
      'name': 'Supernova Divine',
      'img': 'https://picsum.photos/seed/car2/800/500',
      'ticket': 700,
      'coin': null,
    },
    {
      'name': 'Audi ABTA4',
      'img': 'https://picsum.photos/seed/car3/800/500',
      'ticket': 70,
      'coin': 69900,
    },
    {
      'name': 'BMW X5',
      'img': 'https://picsum.photos/seed/car4/800/500',
      'ticket': 100,
      'coin': 99900,
    },
    {
      'name': 'Land Rover Range',
      'img': 'https://picsum.photos/seed/car5/800/500',
      'ticket': 200,
      'coin': 199900,
    },
    {
      'name': 'Mercedes-AMG',
      'img': 'https://picsum.photos/seed/car6/800/500',
      'ticket': 400,
      'coin': 399900,
    },
    {
      'name': 'Flame and Thunder',
      'img': 'https://picsum.photos/seed/car1/800/500',
      'ticket': 1000,
      'coin': null,
    },
    {
      'name': 'Supernova Divine',
      'img': 'https://picsum.photos/seed/car2/800/500',
      'ticket': 700,
      'coin': null,
    },
    {
      'name': 'Audi ABTA4',
      'img': 'https://picsum.photos/seed/car3/800/500',
      'ticket': 70,
      'coin': 69900,
    },
    {
      'name': 'BMW X5',
      'img': 'https://picsum.photos/seed/car4/800/500',
      'ticket': 100,
      'coin': 99900,
    },
    {
      'name': 'Land Rover Range',
      'img': 'https://picsum.photos/seed/car5/800/500',
      'ticket': 200,
      'coin': 199900,
    },
    {
      'name': 'Mercedes-AMG',
      'img': 'https://picsum.photos/seed/car6/800/500',
      'ticket': 400,
      'coin': 399900,
    },
    {
      'name': 'Flame and Thunder',
      'img': 'https://picsum.photos/seed/car1/800/500',
      'ticket': 1000,
      'coin': null,
    },
    {
      'name': 'Supernova Divine',
      'img': 'https://picsum.photos/seed/car2/800/500',
      'ticket': 700,
      'coin': null,
    },
    {
      'name': 'Audi ABTA4',
      'img': 'https://picsum.photos/seed/car3/800/500',
      'ticket': 70,
      'coin': 69900,
    },
    {
      'name': 'BMW X5',
      'img': 'https://picsum.photos/seed/car4/800/500',
      'ticket': 100,
      'coin': 99900,
    },
    {
      'name': 'Land Rover Range',
      'img': 'https://picsum.photos/seed/car5/800/500',
      'ticket': 200,
      'coin': 199900,
    },
    {
      'name': 'Mercedes-AMG',
      'img': 'https://picsum.photos/seed/car6/800/500',
      'ticket': 400,
      'coin': 399900,
    },

  ];

  int _selected = 0;


  @override
  Widget build(BuildContext context) {
    final cardBg = const Color(0xFFF0F2FF); // same lavender background

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: InkResponse(
                      onTap: () => Navigator.of(context).pop(),
                      child: const Icon(Icons.arrow_back_ios, size: 24),
                    ),
                  ),
                  const Text(
                    'Rides',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),

            // Big preview
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 100),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Preview area
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          height: 220,
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Color(0xFFDFF1FF), Color(0xFFEFE4FF)],
                            ),
                          ),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Positioned.fill(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 28),
                                  child: Image.network(
                                    _rides[_selected]['img'],
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 14,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Row(
                                    children: const [
                                      Icon(Icons.remove_red_eye_outlined, size: 18),
                                      SizedBox(width: 6),
                                      Text('Preview', style: TextStyle(fontWeight: FontWeight.w600)),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    const Padding(
                      padding: EdgeInsets.fromLTRB(16, 14, 16, 8),
                      child: Text(
                        'Rides',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                      ),
                    ),

                    // Grid of rides
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _rides.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          childAspectRatio: 0.6,
                        ),
                        itemBuilder: (context, i) {
                          final r = _rides[i];
                          final selected = i == _selected;

                          return GestureDetector(
                            onTap: () => setState(() => _selected = i),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: cardBg,
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                      color: selected ? const Color(0xFF3C66FF) : Colors.transparent,
                                      width: 2,
                                    ),
                                  ),
                                  height: 120,
                                  child: Stack(
                                    children: [
                                      Positioned.fill(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Image.network(r['img'], fit: BoxFit.contain),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 3,
                                        left: 12,
                                        right: 12,
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 5, vertical:3),
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade400,
                                            borderRadius: BorderRadius.circular(20),
                                          ),
                                          child: const Text(
                                            'Not Obtained',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 10,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  r['name'],
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 13.5,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black87,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text('🎟', style: TextStyle(fontSize: 14)),
                                    const SizedBox(width: 2),
                                    Text(
                                      '${r['ticket']}',
                                      style: const TextStyle(
                                        fontSize: 12.5,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.orange,
                                      ),
                                    ),
                                    if (r['coin'] != null) ...[
                                      const Text(' / ', style: TextStyle(color: Colors.black54)),
                                      const Text('🪙', style: TextStyle(fontSize: 14)),
                                      const SizedBox(width: 2),
                                      Text(
                                        _formatCoins(r['coin']),
                                        style: const TextStyle(
                                          fontSize: 12.5,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black54,
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      // Bottom sheet
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: .08), blurRadius: 12, offset: const Offset(0, -2))],
          borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
        ),
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 20),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _rides[_selected]['name'],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Text('🎟', style: TextStyle(fontSize: 16)),
                      const SizedBox(width: 6),
                      Text(
                        '${_rides[_selected]['ticket']}',
                        style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            _pillButton('Send', background: const Color(0xFFE9ECFF), fg: const Color(0xFF4959F5)),
            const SizedBox(width: 10),
            _pillButton('Purchase', background: const Color(0xFF4A64FF), fg: Colors.white),
          ],
        ),
      ),
    );
  }

  String _formatCoins(int value) {
    final text = value.toString();
    final buffer = StringBuffer();
    for (var i = 0; i < text.length; i++) {
      if (i > 0 && (text.length - i) % 3 == 0) {
        buffer.write(',');
      }
      buffer.write(text[i]);
    }
    return buffer.toString();
  }

  Widget _pillButton(
    String label, {
    required Color background,
    required Color fg,
  }) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: background,
        foregroundColor: fg,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      ),
      child: Text(
        label,
        style: TextStyle(fontWeight: FontWeight.w600, color: fg),
      ),
    );
  }
}
