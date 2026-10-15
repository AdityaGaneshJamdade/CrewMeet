import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

/// Fourth pane: Server member list with roles and presence dots.
class MemberListPane extends StatelessWidget {
  const MemberListPane({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      color: AppColors.darkSurface,
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        children: const [
          _RoleHeader(title: 'COMMUNITY LEADS — 1'),
          _MemberTile(
            name: 'Aditya (Lead)',
            status: 'Online',
            statusColor: AppColors.statusOnline,
            badgeColor: AppColors.accentChai,
          ),
          SizedBox(height: 16),
          _RoleHeader(title: 'MEMBERS — 3'),
          _MemberTile(
            name: 'Priya Patel',
            status: 'Listening to Lo-Fi',
            statusColor: AppColors.statusStreaming,
            badgeColor: AppColors.primary,
          ),
          _MemberTile(
            name: 'Alex Johnson',
            status: 'Away',
            statusColor: AppColors.statusIdle,
            badgeColor: null,
          ),
          _MemberTile(
            name: 'DevBot',
            status: 'Playing /status',
            statusColor: AppColors.statusOnline,
            badgeColor: AppColors.accentMatcha,
            isBot: true,
          ),
        ],
      ),
    );
  }
}

class _RoleHeader extends StatelessWidget {
  const _RoleHeader({required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.8,
          color: AppColors.darkTextMuted,
        ),
      ),
    );
  }
}

class _MemberTile extends StatelessWidget {
  const _MemberTile({
    required this.name,
    required this.status,
    required this.statusColor,
    this.badgeColor,
    this.isBot = false,
  });

  final String name;
  final String status;
  final Color statusColor;
  final Color? badgeColor;
  final bool isBot;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 16,
                backgroundColor: badgeColor ?? AppColors.darkElevated,
                child: Text(
                  name.characters.first,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  width: 9,
                  height: 9,
                  decoration: BoxDecoration(
                    color: statusColor,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.darkSurface,
                      width: 1.5,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        name,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: badgeColor ?? AppColors.darkTextPrimary,
                        ),
                      ),
                    ),
                    if (isBot) ...[
                      const SizedBox(width: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 4,
                          vertical: 1,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text(
                          'BOT',
                          style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                Text(
                  status,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppColors.darkTextMuted,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
