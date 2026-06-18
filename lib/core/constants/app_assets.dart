/// Central registry for bundled images and icons under [Assets/].
class AppAssets {
  AppAssets._();

  static const _root = 'Assets';
  static const _icons = '$_root/icons';
  static const _images = '$_root/images';

  // Icons
  static const brush = '$_icons/brush.png';
  static const camera = '$_icons/camera.png';
  static const dollar = '$_icons/dollar.png';
  static const facebook = '$_icons/fb.png';
  static const google = '$_icons/google.png';
  static const hand = '$_icons/hand.png';
  static const instagram = '$_icons/instagram.jpeg';
  static const ranks = '$_icons/ranks.png';
  static const sun = '$_icons/sun.png';
  static const trophy = '$_icons/trophy.png';

  // Root-level images
  static const avatar = '$_root/avtar.png';
  static const share = '$_root/share.png';
  static const textpad = '$_root/textpad.png';
  static const menu = '$_root/menu.png';
  static const mainTop = '$_root/main_top.png';
  static const mainBottom = '$_root/main_bottom.png';
  static const party = '$_root/party.png';
  static const profileCard = '$_root/profileCard.png';
  static const roomBubble = '$_root/RoomBubble.png';

  // Feature images
  static const background = '$_images/background.jpg';
  static const bgLantern = '$_images/bg.png';
  static const liveRoom = '$_images/liveroom.jpg';
  static const audio = '$_images/audio.jpg';
  static const stage = '$_images/a.png';
  static const avatarPlaceholder = '$_images/vector.png';
  static const storyS1 = '$_images/s1.jpeg';
  static const storyS2 = '$_images/s2.jpg';
  static const storyS3 = '$_images/s3.jpg';
  static const storyS4 = '$_images/s4.jpeg';
  static const storyS = '$_images/s.webp';
  static const seat1 = '$_images/seat1.png';
  static const seat2 = '$_images/seat2.png';

  static const storyAvatars = [
    storyS1,
    storyS2,
    storyS3,
    storyS4,
    storyS,
    storyS2,
    storyS3,
    storyS1,
    storyS4,
    storyS,
    storyS2,
  ];

  static const liveRoomCovers = [
    liveRoom,
    audio,
    stage,
    liveRoom,
  ];
}
