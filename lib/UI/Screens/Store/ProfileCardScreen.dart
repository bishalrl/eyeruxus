import 'package:flutter/material.dart';

class ProfileCardItem {
  final String id;
  final String name;
  final int price;
  final String imageUrl;
  final bool isObtained;
  final String currency; // 'coins' or 'gems'

  ProfileCardItem({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.isObtained,
    this.currency = 'coins',
  });
}

class ProfileCardPage extends StatefulWidget {
  @override
  _ProfileCardPageState createState() => _ProfileCardPageState();
}

class _ProfileCardPageState extends State<ProfileCardPage> {
  String? selectedItemId;

  final List<ProfileCardItem> profileCardItems = [
    ProfileCardItem(
      id: '1',
      name: 'Crystal Flower Spirit Pattern',
      price: 12,
      imageUrl: 'Assets/profileCard.png',
      isObtained: false,
      currency: 'coins',
    ),
    ProfileCardItem(
      id: '2',
      name: 'Crystal Feather Wing',
      price: 12,
      imageUrl: 'Assets/profileCard.png',
      isObtained: false,
      currency: 'coins',
    ),
    ProfileCardItem(
      id: '3',
      name: 'Golden-Orange Phoenix',
      price: 12,
      imageUrl: 'Assets/profileCard.png',
      isObtained: false,
      currency: 'coins',
    ),
    ProfileCardItem(
      id: '4',
      name: 'Golden-Winged Phoenix',
      price: 12,
      imageUrl: 'Assets/profileCard.png',
      isObtained: false,
      currency: 'coins',
    ),
    ProfileCardItem(
      id: '5',
      name: 'Wing Shadow Golden',
      price: 12,
      imageUrl: 'Assets/profileCard.png',
      isObtained: false,
      currency: 'coins',
    ),
    ProfileCardItem(
      id: '6',
      name: 'Plume-Light Golden',
      price: 12,
      imageUrl: 'Assets/profileCard.png',
      isObtained: false,
      currency: 'coins',
    ),
    ProfileCardItem(
      id: '7',
      name: 'Purple Crystal Wings',
      price: 12,
      imageUrl: 'Assets/profileCard.png',
      isObtained: false,
      currency: 'coins',
    ),
    ProfileCardItem(
      id: '8',
      name: 'Royal Golden Frame',
      price: 12,
      imageUrl: 'Assets/profileCard.png',
      isObtained: false,
      currency: 'coins',
    ),
    ProfileCardItem(
      id: '9',
      name: 'Celestial Wings',
      price: 12,
      imageUrl: 'Assets/profileCard.png',
      isObtained: false,
      currency: 'coins',
    ),
  ];

  ProfileCardItem? get selectedItem {
    if (selectedItemId == null) return null;
    return profileCardItems.firstWhere((item) => item.id == selectedItemId);
  }

  @override
  void initState() {
    super.initState();
    // Select first item by default
    selectedItemId = profileCardItems.first.id;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF1a1a2e),
              Color(0xFF16213e),
              Color(0xFF0f3460),
            ],
          ),
        ),
        child: Column(
          children: [
            // Header with dark gradient background
            Container(
              height: 400,
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment.center,
                  radius: 1.0,
                  colors: [
                    Color(0xFF2d1b69).withOpacity(0.8),
                    Color(0xFF1a1a2e).withOpacity(0.9),
                    Colors.black,
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
                              icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              padding: EdgeInsets.zero,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'Profile card',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(width: 40), // Balance the back button
                        ],
                      ),
                    ),

                    // Main Profile Card Display
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 300,
                            height: 200,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                // Profile Card Frame
                                if (selectedItem != null)
                                  Image.asset(
                                    selectedItem!.imageUrl,
                                    width: 300,
                                    height: 200,
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
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Content Area
            Expanded(
              child: Container(
                color: Color(0xFF0f0f23),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Grid of Profile Card Items
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
                          itemCount: profileCardItems.length,
                          itemBuilder: (context, index) {
                            final item = profileCardItems[index];
                            final isSelected = selectedItemId == item.id;

                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedItemId = item.id;
                                });
                              },
                              child: Column(
                                children: [
                                  // Profile Card Container
                                  Container(
                                    width: 110,
                                    height: 110,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color: isSelected
                                            ? Colors.purple
                                            : Colors.grey.shade600,
                                        width: isSelected ? 3 : 1,
                                      ),
                                      gradient: isSelected
                                          ? LinearGradient(
                                        colors: [
                                          Colors.purple.shade400,
                                          Colors.pink.shade400,
                                          Colors.blue.shade400
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      )
                                          : null,
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(isSelected ? 3 : 1),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(9),
                                          color: Color(0xFF1a1a2e),
                                        ),
                                        child: Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            // Profile Card Frame
                                            Image.asset(
                                              item.imageUrl,
                                              width: 90,
                                              height: 90,
                                              fit: BoxFit.contain,
                                            ),

                                            // Avatar (Letter P)
                                            Container(
                                              width: 40,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                color: Colors.green,
                                                shape: BoxShape.circle,
                                              ),
                                              child: Center(
                                                child: Text(
                                                  'P',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),

                                            // Not Obtained Tag
                                            if (!item.isObtained)
                                              Positioned(
                                                bottom: 5,
                                                left: 0,
                                                right: 0,
                                                child: Center(
                                                  child: Container(
                                                    width: 80,
                                                    height: 20,
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(10),
                                                      color: Colors.black.withOpacity(0.7),
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
                                        color: Colors.white70,
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
            ),
          ],
        ),
      ),

      // Bottom Navigation
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Color(0xFF0f0f23),
          border: Border(top: BorderSide(color: Colors.grey.shade700)),
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
                        color: Colors.white,
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
                          size: 18,
                        ),
                        SizedBox(width: 4),
                        Text(
                          selectedItem!.price >= 1000
                              ? '${(selectedItem!.price / 1000).toStringAsFixed(0)}K'
                              : selectedItem!.price.toString(),
                          style: TextStyle(
                            fontSize: 16,
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
                    backgroundColor: Colors.cyan[400],
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    minimumSize: Size(60, 36),
                    elevation: 0,
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
                    backgroundColor: Colors.cyan[400],
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