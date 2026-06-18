import 'package:eye_rex_us/features/home/domain/entities/room_entity.dart';

class RoomModel extends RoomEntity {
  const RoomModel({
    required super.id,
    required super.title,
    required super.tag,
    required super.views,
    required super.countryFlag,
    required super.isPk,
    super.coverUrl,
    super.stageMemberCount,
  });
}
