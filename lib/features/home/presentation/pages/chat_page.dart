import 'package:eye_rex_us/core/extensions/context_extensions.dart';
import 'package:eye_rex_us/features/home/presentation/theme/home_colors.dart';
import 'package:eye_rex_us/features/home/presentation/widgets/home_sub_page_scaffold.dart';
import 'package:flutter/material.dart';

/// Chat tab — conversations and direct messages.
class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    final chats = [
      ('John', 'Hey, are you going live tonight?', '2m'),
      ('Jane', 'Joined your party room 🎉', '15m'),
      ('Kabir', 'Sent you a gift', '1h'),
      ('Priya', 'Thanks for the follow!', '3h'),
    ];

    return HomeSubPageScaffold(
      title: l10n.homeChatTitle,
      subtitle: l10n.homeChatSubtitle,
      child: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: chats.length,
        separatorBuilder: (_, __) => const SizedBox(height: 10),
        itemBuilder: (context, index) {
          final chat = chats[index];
          return Material(
            color: HomeColors.profileCard,
            borderRadius: BorderRadius.circular(14),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: HomeColors.transparentTabBackground,
                child: Text(
                  chat.$1[0],
                  style: const TextStyle(
                    color: HomeColors.textWhite,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              title: Text(
                chat.$1,
                style: const TextStyle(
                  color: HomeColors.textWhite,
                  fontWeight: FontWeight.w600,
                ),
              ),
              subtitle: Text(
                chat.$2,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: HomeColors.textGrey, fontSize: 13),
              ),
              trailing: Text(
                chat.$3,
                style: const TextStyle(color: HomeColors.textGrey, fontSize: 12),
              ),
              onTap: () {},
            ),
          );
        },
      ),
    );
  }
}
