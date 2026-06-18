import 'package:eye_rex_us/core/extensions/context_extensions.dart';
import 'package:eye_rex_us/features/home/presentation/bloc/reels_bloc.dart';
import 'package:eye_rex_us/features/home/presentation/bloc/reels_event.dart';
import 'package:eye_rex_us/features/home/presentation/bloc/reels_state.dart';
import 'package:eye_rex_us/features/home/presentation/theme/home_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReelsCommentsSheet extends StatefulWidget {
  const ReelsCommentsSheet({super.key, required this.reelId});

  final String reelId;

  @override
  State<ReelsCommentsSheet> createState() => _ReelsCommentsSheetState();
}

class _ReelsCommentsSheetState extends State<ReelsCommentsSheet> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _submit() {
    context.read<ReelsBloc>().add(
          ReelsCommentSubmitted(reelId: widget.reelId, text: _controller.text),
        );
    _controller.clear();
    _focusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;

    return Padding(
      padding: EdgeInsets.only(bottom: bottomInset),
      child: DraggableScrollableSheet(
        initialChildSize: 0.55,
        minChildSize: 0.4,
        maxChildSize: 0.9,
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
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                  child: Text(
                    l10n.reelsCommentsTitle,
                    style: const TextStyle(
                      color: HomeColors.textWhite,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Divider(color: Colors.white12, height: 1),
                Expanded(
                  child: BlocBuilder<ReelsBloc, ReelsState>(
                    buildWhen: (prev, curr) =>
                        prev.commentsByReelId != curr.commentsByReelId,
                    builder: (context, state) {
                      final comments = state.commentsFor(widget.reelId);
                      if (comments.isEmpty) {
                        return Center(
                          child: Text(
                            l10n.reelsCommentsEmpty,
                            style: const TextStyle(color: Colors.white54),
                          ),
                        );
                      }
                      return ListView.separated(
                        controller: scrollController,
                        padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                        itemCount: comments.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 14),
                        itemBuilder: (context, index) {
                          final comment = comments[index];
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                radius: 18,
                                backgroundImage:
                                    AssetImage(comment.avatarAsset),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          comment.authorName,
                                          style: const TextStyle(
                                            color: HomeColors.textWhite,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 13,
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          comment.timeLabel,
                                          style: const TextStyle(
                                            color: Colors.white38,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      comment.text,
                                      style: const TextStyle(
                                        color: Colors.white70,
                                        fontSize: 14,
                                        height: 1.35,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ),
                const Divider(color: Colors.white12, height: 1),
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _controller,
                          focusNode: _focusNode,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: l10n.reelsCommentHint,
                            hintStyle: const TextStyle(color: Colors.white38),
                            filled: true,
                            fillColor: const Color(0xFF2A2A2A),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(24),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 10,
                            ),
                          ),
                          textInputAction: TextInputAction.send,
                          onSubmitted: (_) => _submit(),
                        ),
                      ),
                      const SizedBox(width: 8),
                      TextButton(
                        onPressed: _submit,
                        child: Text(
                          l10n.reelsCommentPost,
                          style: const TextStyle(
                            color: HomeColors.accentOrange,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
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
