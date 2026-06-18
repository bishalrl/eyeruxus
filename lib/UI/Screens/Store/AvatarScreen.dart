import 'package:flutter/material.dart';

class AvatarItem {
  final String id;
  final String name;
  final int price;
  final String imageUrl;
  final bool isObtained;
  final String currency; // 'coins' or 'gems'

  AvatarItem({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.isObtained,
    this.currency = 'coins',
  });
}

class AvatarFramePage extends StatefulWidget {
  @override
  _AvatarFramePageState createState() => _AvatarFramePageState();
}

class _AvatarFramePageState extends State<AvatarFramePage> {
  String? selectedItemId;

  final List<AvatarItem> avatarItems = [
    AvatarItem(
      id: '1',
      name: 'Butterfly - Fox Fantasy',
      price: 50,
      imageUrl: 'Assets/avtar.png',
      isObtained: false,
      currency: 'coins',
    ),
    AvatarItem(
      id: '2',
      name: 'Blue Whale & Jellyfish',
      price: 50,
      imageUrl: 'Assets/avtar.png',
      isObtained: false,
      currency: 'coins',
    ),
    AvatarItem(
      id: '3',
      name: 'Crown of Ethereal',
      price: 30000,
      imageUrl: 'Assets/avtar.png',
      isObtained: false,
      currency: 'gems',
    ),
    AvatarItem(
      id: '4',
      name: 'Golden Lion Holy',
      price: 30000,
      imageUrl: 'Assets/avtar.png',
      isObtained: false,
      currency: 'gems',
    ),
    AvatarItem(
      id: '5',
      name: 'Crimson Blaze',
      price: 50000,
      imageUrl: 'Assets/avtar.png',
      isObtained: false,
      currency: 'gems',
    ),
    AvatarItem(
      id: '6',
      name: 'Ocean Bloom',
      price: 50000,
      imageUrl: 'Assets/avtar.png',
      isObtained: false,
      currency: 'gems',
    ),
    AvatarItem(
      id: '7',
      name: 'Rainbow Ring',
      price: 75,
      imageUrl: 'Assets/avtar.png',
      isObtained: false,
      currency: 'coins',
    ),
    AvatarItem(
      id: '8',
      name: 'Nature Crown',
      price: 100,
      imageUrl: 'Assets/avtar.png',
      isObtained: false,
      currency: 'coins',
    ),
    AvatarItem(
      id: '9',
      name: 'Purple Galaxy',
      price: 125,
      imageUrl: 'Assets/avtar.png',
      isObtained: false,
      currency: 'coins',
    ),
  ];

  AvatarItem? get selectedItem {
    if (selectedItemId == null) return null;
    return avatarItems.firstWhere((item) => item.id == selectedItemId);
  }

  @override
  void initState() {
    super.initState();
    // Select first item by default
    selectedItemId = avatarItems.first.id;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Header with gradient background
          Container(
            height: 340, // Increased height to accommodate the selected item name
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.purple.shade200,
                  Colors.blue.shade200,
                  Colors.pink.shade200,
                ],
              ),
            ),
            child: SafeArea(
              child: Column(
                children: [
                  // App Bar
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                    child: Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          child: IconButton(
                            icon: Icon(Icons.arrow_back_ios, color: Colors.black),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            padding: EdgeInsets.zero,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'Avatar Frame',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(width: 40), // Balance the back button
                      ],
                    ),
                  ),

                  // Main Avatar Display
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 150,
                          height: 150,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              // Avatar Frame
                              if (selectedItem != null)
                                Image.asset(
                                  selectedItem!.imageUrl,
                                  width: 150,
                                  height: 150,
                                  fit: BoxFit.contain,
                                ),
                              // Avatar (Letter P)
                              Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Text(
                                    'P',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 36,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Selected Item Name below avatar
                        if (selectedItem != null)
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              selectedItem!.name,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Content Area
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  child: Text(
                    'Avatar Frame',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),

                // Grid of Avatar Frames
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4),
                    child: GridView.builder(
                      padding: EdgeInsets.zero,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 0.85,
                        crossAxisSpacing: 4,
                        mainAxisSpacing: 8,
                      ),
                      itemCount: avatarItems.length,
                      itemBuilder: (context, index) {
                        final item = avatarItems[index];
                        final isSelected = selectedItemId == item.id;

                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedItemId = item.id;
                            });
                          },
                          child: Column(
                            children: [
                              // Frame Container
                              Container(
                                width: 110,
                                height: 110,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: isSelected
                                        ? Colors.blue
                                        : Colors.transparent,
                                    width: 3,
                                  ),
                                  gradient: isSelected
                                      ? LinearGradient(
                                    colors: [Colors.blue, Colors.purple, Colors.pink],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  )
                                      : null,
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(isSelected ? 3 : 0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(9),
                                      color: Colors.grey.shade100,
                                    ),
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        // Frame Image
                                        Image.asset(
                                          item.imageUrl,
                                          width: 90,
                                          height: 90,
                                          fit: BoxFit.contain,
                                        ),

                                        // Not Obtained Tag
                                        if (!item.isObtained)
                                          Positioned(
                                            bottom: 5,
                                            left: 0,
                                            right: 0,
                                            child: Center(
                                              child: Container(
                                                width: 60,
                                                height: 20,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10),
                                                  color: Colors.black.withOpacity(0.2),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    'Not Obtained',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 8,
                                                      fontWeight: FontWeight.w600,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              // Item Name
                              Container(
                                width: 110,
                                child: Text(
                                  item.name.length > 12
                                      ? '${item.name.substring(0, 12)}...'
                                      : item.name,
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black87,
                                  ),
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),

                              // Price
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    item.currency == 'gems'
                                        ? Icons.diamond
                                        : Icons.monetization_on,
                                    color: item.currency == 'gems'
                                        ? Colors.orange
                                        : Colors.orange,
                                    size: 14,
                                  ),
                                  SizedBox(width: 2),
                                  Text(
                                    item.price >= 1000
                                        ? '${(item.price / 1000).toStringAsFixed(0)}K'
                                        : item.price.toString(),
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.orange,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),

      // Bottom Navigation
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Colors.grey.shade300)),
        ),
        child: SafeArea(
          child: Row(
            children: [
              // Selected Item Info
              Expanded(
                child: selectedItem != null
                    ? Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      selectedItem!.name,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 2),
                    Row(
                      children: [
                        Icon(
                          selectedItem!.currency == 'gems'
                              ? Icons.diamond
                              : Icons.monetization_on,
                          color: Colors.orange,
                          size: 18, // Increased from 14 to 18
                        ),
                        SizedBox(width: 4),
                        Text(
                          selectedItem!.price >= 1000
                              ? '${(selectedItem!.price / 1000).toStringAsFixed(0)}K'
                              : selectedItem!.price.toString(),
                          style: TextStyle(
                            fontSize: 16, // Increased from 13 to 16
                            fontWeight: FontWeight.w600,
                            color: Colors.orange,
                          ),
                        ),
                      ],
                    ),
                  ],
                )
                    : SizedBox(),
              ),

              SizedBox(width: 8),

              // Send Button
              Container(
                height: 36,
                child: ElevatedButton(
                  onPressed: () {
                    // Send action
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[50], // Changed to light blue
                    foregroundColor: Colors.blue, // Changed text color to blue
                    side: BorderSide(color: Colors.blue, width: 1), // Added blue border
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    minimumSize: Size(60, 36),
                    elevation: 0, // Remove shadow for cleaner look
                  ),
                  child: Text(
                    'Send',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              SizedBox(width: 8),

              // Purchase Button
              Container(
                height: 36,
                child: ElevatedButton(
                  onPressed: selectedItem != null && !selectedItem!.isObtained
                      ? () {
                    // Purchase action
                    print('Purchasing ${selectedItem!.name} for ${selectedItem!.price}');
                  }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    minimumSize: Size(80, 36),
                  ),
                  child: Text(
                    'Purchase',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}