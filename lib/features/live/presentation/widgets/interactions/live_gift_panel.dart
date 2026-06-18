import 'package:eye_rex_us/app/router/app_router.dart';
import 'package:eye_rex_us/core/extensions/context_extensions.dart';
import 'package:eye_rex_us/features/live/data/datasources/live_gift_local_datasource.dart';
import 'package:eye_rex_us/features/live/domain/entities/live_gift.dart';
import 'package:eye_rex_us/features/live/presentation/bloc/live_room_interaction_cubit.dart';
import 'package:eye_rex_us/features/live/presentation/bloc/live_room_interaction_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LiveGiftPanel extends StatefulWidget {
  const LiveGiftPanel({super.key});

  @override
  State<LiveGiftPanel> createState() => _LiveGiftPanelState();
}

class _LiveGiftPanelState extends State<LiveGiftPanel>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: LiveGiftLocalDataSource.categories.length,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final gifts = LiveGiftLocalDataSource.allGifts();
    final categories = LiveGiftLocalDataSource.categories;
    final cubit = context.read<LiveRoomInteractionCubit>();

    return DraggableScrollableSheet(
      initialChildSize: 0.55,
      minChildSize: 0.4,
      maxChildSize: 0.85,
      expand: false,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Color(0xFF1A1A1A),
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: Column(
            children: [
              const SizedBox(height: 10),
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                child: Row(
                  children: [
                    Text(
                      l10n.liveRoomGiftsTitle,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    const Icon(Icons.monetization_on, color: Color(0xFFFFD54F), size: 18),
                    const SizedBox(width: 4),
                    Text(
                      l10n.liveRoomCoinsBalance('12,450'),
                      style: const TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                  ],
                ),
              ),
              TabBar(
                controller: _tabController,
                isScrollable: true,
                indicatorColor: Colors.pinkAccent,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.white54,
                tabs: [for (final c in categories) Tab(text: c)],
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    for (final category in categories)
                      _GiftGrid(
                        gifts: gifts.where((g) => g.category == category).toList(),
                        onSend: cubit.sendGift,
                      ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _GiftGrid extends StatelessWidget {
  const _GiftGrid({
    required this.gifts,
    required this.onSend,
  });

  final List<LiveGift> gifts;
  final ValueChanged<String> onSend;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 0.78,
      ),
      itemCount: gifts.length,
      itemBuilder: (context, index) {
        final gift = gifts[index];
        return GestureDetector(
          onTap: () => onSend(gift.id),
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFF2A2A2A),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(gift.emoji, style: const TextStyle(fontSize: 28)),
                const SizedBox(height: 4),
                Text(
                  gift.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.white, fontSize: 10),
                ),
                Text(
                  '${gift.coinCost}',
                  style: const TextStyle(color: Color(0xFFFFD54F), fontSize: 10),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class LiveCommentSheet extends StatefulWidget {
  const LiveCommentSheet({super.key, required this.roomId});

  final String roomId;

  @override
  State<LiveCommentSheet> createState() => _LiveCommentSheetState();
}

class _LiveCommentSheetState extends State<LiveCommentSheet> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit() {
    context.read<LiveRoomInteractionCubit>().sendComment(_controller.text);
    _controller.clear();
    AppRouter.maybePop(context);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;

    return Padding(
      padding: EdgeInsets.only(bottom: bottomInset),
      child: DraggableScrollableSheet(
        initialChildSize: 0.45,
        minChildSize: 0.35,
        maxChildSize: 0.7,
        expand: false,
        builder: (context, scrollController) {
          return Container(
            decoration: const BoxDecoration(
              color: Color(0xFF1A1A1A),
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: Column(
              children: [
                const SizedBox(height: 10),
                Text(
                  l10n.liveRoomCommentsTitle,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Divider(color: Colors.white12),
                Expanded(
                  child: BlocBuilder<LiveRoomInteractionCubit, LiveRoomInteractionState>(
                    builder: (context, state) {
                      return ListView.builder(
                        controller: scrollController,
                        padding: const EdgeInsets.all(16),
                        itemCount: state.comments.length,
                        itemBuilder: (context, index) {
                          final c = state.comments[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Text(
                              '${c.authorName}: ${c.text}',
                              style: const TextStyle(color: Colors.white70),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _controller,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: l10n.liveRoomCommentHint,
                            hintStyle: const TextStyle(color: Colors.white38),
                            filled: true,
                            fillColor: const Color(0xFF2A2A2A),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(24),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          onSubmitted: (_) => _submit(),
                        ),
                      ),
                      IconButton(
                        onPressed: _submit,
                        icon: const Icon(Icons.send, color: Colors.pinkAccent),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
