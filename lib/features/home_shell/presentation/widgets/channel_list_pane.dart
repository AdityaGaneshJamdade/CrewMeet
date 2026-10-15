import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

/// Second pane: Channel tree navigation and user audio dock.
class ChannelListPane extends StatelessWidget {
  const ChannelListPane({
    super.key,
    required this.serverName,
    required this.selectedChannelId,
    required this.onChannelSelected,
  });

  final String serverName;
  final String selectedChannelId;
  final ValueChanged<String> onChannelSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      color: AppColors.darkSurface,
      child: Column(
        children: [
          // Server Header
          Container(
            height: 52,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: AppColors.darkBorder),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    serverName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
                const Icon(Icons.keyboard_arrow_down, size: 20),
              ],
            ),
          ),

          // Channel List
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              children: [
                const _CategoryHeader(title: 'TEXT CHANNELS'),
                _ChannelTile(
                  title: 'general-chat',
                  icon: Icons.tag,
                  isSelected: selectedChannelId == 'general',
                  onTap: () => onChannelSelected('general'),
                ),
                _ChannelTile(
                  title: 'announcements',
                  icon: Icons.campaign_outlined,
                  isSelected: selectedChannelId == 'announcements',
                  onTap: () => onChannelSelected('announcements'),
                ),
                _ChannelTile(
                  title: 'resources',
                  icon: Icons.bookmark_border,
                  isSelected: selectedChannelId == 'resources',
                  onTap: () => onChannelSelected('resources'),
                ),
                const SizedBox(height: 12),
                const _CategoryHeader(title: 'VOICE CHANNELS'),
                _ChannelTile(
                  title: 'Lounge Voice',
                  icon: Icons.volume_up_outlined,
                  isSelected: selectedChannelId == 'voice_lounge',
                  onTap: () => onChannelSelected('voice_lounge'),
                ),
                _ChannelTile(
                  title: 'Study Room',
                  icon: Icons.headset_mic_outlined,
                  isSelected: selectedChannelId == 'voice_study',
                  onTap: () => onChannelSelected('voice_study'),
                ),
              ],
            ),
          ),

          // Bottom User Profile & Status Bar
          Container(
            height: 56,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            color: AppColors.darkElevated,
            child: Row(
              children: [
                Stack(
                  children: [
                    const CircleAvatar(
                      radius: 17,
                      backgroundColor: AppColors.primary,
                      child: Text(
                        'A',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          color: AppColors.statusOnline,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.darkElevated,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 8),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Aditya',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'Online',
                        style: TextStyle(
                          fontSize: 11,
                          color: AppColors.darkTextSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.mic, size: 18),
                  tooltip: 'Mute',
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.settings, size: 18),
                  tooltip: 'Settings',
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryHeader extends StatelessWidget {
  const _CategoryHeader({required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
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

class _ChannelTile extends StatelessWidget {
  const _ChannelTile({
    required this.title,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  final String title;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1),
      child: ListTile(
        dense: true,
        visualDensity: const VisualDensity(horizontal: 0, vertical: -2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        selected: isSelected,
        selectedTileColor: AppColors.darkElevated,
        leading: Icon(
          icon,
          size: 18,
          color: isSelected ? Colors.white : AppColors.darkTextSecondary,
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            color: isSelected ? Colors.white : AppColors.darkTextSecondary,
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
