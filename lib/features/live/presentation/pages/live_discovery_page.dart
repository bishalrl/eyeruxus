import 'package:eye_rex_us/features/chat_room/presentation/navigation/chat_room_routes.dart';
import 'package:eye_rex_us/features/live/domain/entities/live_session_entities.dart';
import 'package:eye_rex_us/features/live/presentation/bloc/live_discovery_cubit.dart';
import 'package:eye_rex_us/features/live/presentation/pages/live_rooms_page.dart';
import 'package:eye_rex_us/features/live/presentation/theme/live_room_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LiveDiscoveryPage extends StatefulWidget {
  const LiveDiscoveryPage({super.key});

  @override
  State<LiveDiscoveryPage> createState() => _LiveDiscoveryPageState();
}

class _LiveDiscoveryPageState extends State<LiveDiscoveryPage> {
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<LiveDiscoveryCubit>().load();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0F),
      body: SafeArea(
        child: BlocBuilder<LiveDiscoveryCubit, LiveDiscoveryState>(
          builder: (context, state) {
            return RefreshIndicator(
              color: LiveRoomTheme.accent,
              onRefresh: context.read<LiveDiscoveryCubit>().refresh,
              child: CustomScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                slivers: [
                  SliverToBoxAdapter(child: _buildHeader(context, state)),
                  if (state.status == LiveDiscoveryStatus.loading && state.rooms.isEmpty)
                    const SliverFillRemaining(
                      child: Center(child: CircularProgressIndicator(color: LiveRoomTheme.accent)),
                    )
                  else if (state.status == LiveDiscoveryStatus.error)
                    SliverFillRemaining(
                      child: Center(
                        child: Text(
                          state.errorMessage ?? 'Failed to load',
                          style: const TextStyle(color: Colors.white70),
                        ),
                      ),
                    )
                  else ...[
                    _section('Trending Lives', state.trending),
                    _section('Popular Lives', state.popular),
                    _section('Recommended', state.recommended),
                    _section('Following', state.following),
                    _section('Nearby', state.nearby),
                    _section('New Creators', state.newCreators),
                    const SliverToBoxAdapter(child: SizedBox(height: 24)),
                  ],
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, LiveDiscoveryState state) {
    final cubit = context.read<LiveDiscoveryCubit>();

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Discover Live',
            style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _searchController,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: 'Search rooms, hosts, categories…',
              hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.45)),
              prefixIcon: const Icon(Icons.search, color: Colors.white54),
              filled: true,
              fillColor: Colors.white.withValues(alpha: 0.08),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
            ),
            onSubmitted: cubit.search,
          ),
          const SizedBox(height: 10),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for (final cat in LiveRoomCategory.values.take(5))
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: FilterChip(
                      label: Text(cat.name),
                      selected: state.selectedCategory == cat,
                      onSelected: (_) => cubit.selectCategory(
                            state.selectedCategory == cat ? null : cat,
                          ),
                      selectedColor: LiveRoomTheme.accent,
                    ),
                  ),
                _filterChip(
                  'English',
                  state.languageFilter,
                  cubit.selectLanguageFilter,
                ),
                _filterChip(
                  'USA',
                  state.countryFilter,
                  cubit.selectCountryFilter,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _filterChip(
    String label,
    String current,
    Future<void> Function(String) onSelect,
  ) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(label),
        selected: current == label,
        onSelected: (_) => onSelect(label),
        selectedColor: LiveRoomTheme.accent.withValues(alpha: 0.6),
      ),
    );
  }

  Widget _section(String title, List<LiveRoomListing> rooms) {
    if (rooms.isEmpty) return const SliverToBoxAdapter(child: SizedBox.shrink());
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 10),
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          SizedBox(
            height: 200,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: rooms.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, index) => _DiscoveryCard(room: rooms[index]),
            ),
          ),
        ],
      ),
    );
  }
}

class _DiscoveryCard extends StatelessWidget {
  const _DiscoveryCard({required this.room});

  final LiveRoomListing room;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 140,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => ChatRoomRoutes.openRoom(context, room.roomId),
          borderRadius: BorderRadius.circular(16),
          child: Ink(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              image: DecorationImage(
                image: NetworkImage(room.coverImageUrl),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black.withValues(alpha: 0.25),
                  BlendMode.darken,
                ),
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 8,
                  left: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                    decoration: BoxDecoration(
                      color: LiveRoomTheme.accent,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text('LIVE', style: TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.w800)),
                  ),
                ),
                Positioned(
                  left: 10,
                  right: 10,
                  bottom: 10,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        room.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 12),
                      ),
                      Text(
                        room.hostName,
                        style: const TextStyle(color: Colors.white70, fontSize: 10),
                      ),
                      Text(
                        '${LiveRoomTheme.formatCount(room.viewerCount)} · ${room.seatCount} seats',
                        style: const TextStyle(color: Colors.white54, fontSize: 9),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LiveDiscoveryRoute extends StatelessWidget {
  const LiveDiscoveryRoute({super.key});

  @override
  Widget build(BuildContext context) => const LiveRoomsRoute();
}
