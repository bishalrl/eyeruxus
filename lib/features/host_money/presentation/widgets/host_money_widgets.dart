import 'package:eye_rex_us/features/host_money/domain/entities/host_money_entities.dart';
import 'package:eye_rex_us/features/host_money/presentation/theme/host_money_theme.dart';
import 'package:flutter/material.dart';

class HostMoneyToolGrid extends StatelessWidget {
  const HostMoneyToolGrid({
    super.key,
    required this.tools,
    required this.onToolTap,
    this.title,
  });

  final String? title;
  final List<HostMoneyTool> tools;
  final ValueChanged<HostMoneyTool> onToolTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null) ...[
            Text(
              title!,
              style: HostMoneyTheme.sectionTitle,
            ),
            const SizedBox(height: 8),
          ],
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: 6,
              crossAxisSpacing: 6,
              childAspectRatio: 0.85,
            ),
            itemCount: tools.length,
            itemBuilder: (context, index) {
              final tool = tools[index];
              return _ToolTile(tool: tool, onTap: () => onToolTap(tool));
            },
          ),
        ],
      ),
    );
  }
}

class _ToolTile extends StatelessWidget {
  const _ToolTile({required this.tool, required this.onTap});

  final HostMoneyTool tool;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: tool.color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Icon(tool.icon, color: tool.color, size: 24),
              ),
              if (tool.badge != null)
                Positioned(
                  bottom: -2,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFFE91E63), Color(0xFF9C27B0)],
                      ),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      tool.badge!,
                      style: const TextStyle(
                        fontSize: 7,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            tool.label,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 9, color: Colors.black87, height: 1.2),
          ),
        ],
      ),
    );
  }
}

class HostMoneyTabBar extends StatelessWidget {
  const HostMoneyTabBar({
    super.key,
    required this.selected,
    required this.onSelected,
  });

  final MakeMoneyTab selected;
  final ValueChanged<MakeMoneyTab> onSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          _TabLabel(
            label: 'Make money',
            selected: selected == MakeMoneyTab.makeMoney,
            onTap: () => onSelected(MakeMoneyTab.makeMoney),
          ),
          const SizedBox(width: 20),
          _TabLabel(
            label: 'Manage',
            selected: selected == MakeMoneyTab.manage,
            onTap: () => onSelected(MakeMoneyTab.manage),
          ),
          const SizedBox(width: 20),
          _TabLabel(
            label: 'Data',
            selected: selected == MakeMoneyTab.data,
            onTap: () => onSelected(MakeMoneyTab.data),
          ),
        ],
      ),
    );
  }
}

class _TabLabel extends StatelessWidget {
  const _TabLabel({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
              color: selected ? Colors.black : Colors.black38,
            ),
          ),
          const SizedBox(height: 2),
          if (selected)
            Container(width: 60, height: 2, color: Colors.black),
        ],
      ),
    );
  }
}
