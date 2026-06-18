import 'package:flutter/material.dart';

class RareIdScreen extends StatefulWidget {
  const RareIdScreen({Key? key}) : super(key: key);

  @override
  State<RareIdScreen> createState() => _RareIdScreenState();
}

class _RareIdScreenState extends State<RareIdScreen> {
  int selectedId = -1;

  final List<Map<String, dynamic>> rareIds = [
    {"id": 10001, "price": 7200000, "tag": "SSR"},
    {"id": 60006, "price": 7200000, "tag": "SSR"},
    {"id": 100001, "price": 7200000, "tag": "SSR"},
    {"id": 110011, "price": 7200000, "tag": "SSR"},
    {"id": 11000, "price": 7200000, "tag": "SSR"},
    {"id": 90000, "price": 7200000, "tag": "SSR"},
    {"id": 60000, "price": 7200000, "tag": "SSR"},
    {"id": 44000, "price": 7200000, "tag": "SSR"},
    {"id": 66600, "price": 7200000, "tag": "SSR"},
  ];

  String _formatPrice(int price) {
    return price.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade200,
                    offset: const Offset(0, 2),
                    blurRadius: 4,
                  ),
                ],
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios, color: Colors.black87),
                    onPressed: () => Navigator.pop(context),
                    padding: EdgeInsets.zero,
                  ),
                  const Expanded(
                    child: Text(
                      "Rare ID",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(width: 40), // Balance the back button
                ],
              ),
            ),
            SizedBox(height: 30,),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    // Selected ID Display
                    if (selectedId != -1) ...[
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.yellow,width: 2)
                        ),
                        child: Text(
                          "Selected ID: $selectedId",
                          style: const TextStyle(
                            color: Colors.black87,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                    ] else ...[
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: const Text(
                          "Select an ID",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                    ],
                    SizedBox(height: 100,),
                    // Grid of Rare IDs
                    Expanded(
                      child: GridView.builder(
                        itemCount: rareIds.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 0.85,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                        ),
                        itemBuilder: (context, index) {
                          final item = rareIds[index];
                          final isSelected = selectedId == item['id'];

                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedId = item['id'];
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color:  Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: isSelected ? Colors.yellow : Colors.grey.shade300,
                                  width: isSelected ? 2 : 1,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: isSelected
                                        ? Colors.yellow.withOpacity(0.2)
                                        : Colors.grey.withOpacity(0.1),
                                    offset: const Offset(0, 2),
                                    blurRadius: 6,
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  // SSR Tag
                                  Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.symmetric(vertical: 4),
                                    decoration: BoxDecoration(
                                      color: Colors.yellow,
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(11),
                                        topRight: Radius.circular(11),
                                      ),
                                    ),
                                    child: Text(
                                      item["tag"],
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ),

                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "${item["id"]}",
                                            style: TextStyle(
                                              color: isSelected ? Colors.black87 : Colors.black54,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            "Available",
                                            style: TextStyle(
                                              color: Colors.grey.shade600,
                                              fontSize: 10,
                                            ),
                                          ),
                                          const SizedBox(height: 6),
                                          Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                            decoration: BoxDecoration(
                                              color: Colors.yellow.shade100,
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                            child: Text(
                                              "₹${_formatPrice(item["price"])}",
                                              style: const TextStyle(
                                                color: Colors.black87,
                                                fontSize: 10,
                                                fontWeight: FontWeight.w600,
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
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Bottom Purchase Section
            if (selectedId != -1)
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade200,
                      offset: const Offset(0, -2),
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "ID: $selectedId",
                            style: const TextStyle(
                              color: Colors.black87,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            "₹${_formatPrice(7200000)}",
                            style: const TextStyle(
                              color: Colors.black54,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black87,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                            side: BorderSide(color: Colors.yellow,width: 2),
                            ),
                      ),
                      onPressed: () {
                        // Purchase logic here
                      },
                      child: const Text(
                        "Purchase",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}