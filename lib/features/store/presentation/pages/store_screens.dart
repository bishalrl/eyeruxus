import 'package:eye_rex_us/UI/Screens/Store/AvatarScreen.dart';
import 'package:eye_rex_us/UI/Screens/Store/HonorMall.dart';
import 'package:eye_rex_us/UI/Screens/Store/PartyThemeScreen.dart';
import 'package:eye_rex_us/UI/Screens/Store/ProfileCardScreen.dart';
import 'package:eye_rex_us/UI/Screens/Store/RareId.dart';
import 'package:eye_rex_us/UI/Screens/Store/Rides.dart';
import 'package:eye_rex_us/UI/Screens/Store/RoomBubble.dart';
import 'package:eye_rex_us/shared/widgets/feature_bound_pages.dart';
import 'package:flutter/material.dart';

class StoreHonorMallPage extends StatelessWidget {
  const StoreHonorMallPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreBoundPage(category: 'honor', child: HonorMallPage());
  }
}

class StoreRareIdPage extends StatelessWidget {
  const StoreRareIdPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const StoreBoundPage(category: 'rare_id', child: RareIdScreen());
  }
}

class StoreRidesPage extends StatelessWidget {
  const StoreRidesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreBoundPage(category: 'rides', child: RidesScreen());
  }
}

class StoreProfileCardPage extends StatelessWidget {
  const StoreProfileCardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreBoundPage(category: 'profile', child: ProfileCardPage());
  }
}

class StoreAvatarFramePage extends StatelessWidget {
  const StoreAvatarFramePage({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreBoundPage(category: 'avatar', child: AvatarFramePage());
  }
}

class StorePartyThemePage extends StatelessWidget {
  const StorePartyThemePage({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreBoundPage(category: 'theme', child: PartyThemePage());
  }
}

class StoreRoomBubblePage extends StatelessWidget {
  const StoreRoomBubblePage({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreBoundPage(category: 'bubble', child: RoomBubblePage());
  }
}
