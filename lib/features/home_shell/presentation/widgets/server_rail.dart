import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

/// Leftmost server navigation rail for desktop/tablet layout.
class ServerRail extends StatelessWidget {
  const ServerRail({
    super.key,
    required this.selectedServerIndex,
    required this.onServerSelected,
  });

  final int selectedServerIndex;
  final ValueChanged<int> onServerSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 72,
      color: AppColors.darkRail,
      child: Column(
        children: [
          const SizedBox(height: 12),
          // Home / DM Direct Navigation Icon
          _RailIconButton(
            icon: Icons.forum_rounded,
            isSelected: selectedServerIndex == 0,
            color: AppColors.primary,
            tooltip: 'Direct Messages & Home',
            onTap: () => onServerSelected(0),
          ),
          const SizedBox(height: 8),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Divider(color: AppColors.darkBorder, thickness: 1.5),
          ),
          const SizedBox(height: 8),
          // Sample Server Badges
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _RailServerButton(
                  name: 'Chai Enthusiasts',
                  shortCode: 'CE',
                  color: AppColors.accentChai,
                  isSelected: selectedServerIndex == 1,
                  onTap: () => onServerSelected(1),
                ),
                const SizedBox(height: 10),
                _RailServerButton(
                  name: 'Flutter Builders',
                  shortCode: 'FB',
                  color: const Color(0xFF0284C7),
                  isSelected: selectedServerIndex == 2,
                  onTap: () => onServerSelected(2),
                ),
                const SizedBox(height: 10),
                _RailServerButton(
                  name: 'Tech & Gaming',
                  shortCode: 'TG',
                  color: const Color(0xFF10B981),
                  isSelected: selectedServerIndex == 3,
                  onTap: () => onServerSelected(3),
                ),
              ],
            ),
          ),
          // Add Server Button
          IconButton(
            icon: const Icon(Icons.add_circle_outline,
                color: AppColors.accentMatcha),
            tooltip: 'Add Server',
            onPressed: () {},
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

class _RailIconButton extends StatelessWidget {
  const _RailIconButton({
    required this.icon,
    required this.isSelected,
    required this.color,
    required this.tooltip,
    required this.onTap,
  });

  final IconData icon;
  final bool isSelected;
  final Color color;
  final String tooltip;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: isSelected ? color : AppColors.darkElevated,
            borderRadius: BorderRadius.circular(isSelected ? 16 : 24),
          ),
          child: Icon(icon, color: Colors.white, size: 24),
        ),
      ),
    );
  }
}

class _RailServerButton extends StatelessWidget {
  const _RailServerButton({
    required this.name,
    required this.shortCode,
    required this.color,
    required this.isSelected,
    required this.onTap,
  });

  final String name;
  final String shortCode;
  final Color color;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: name,
      child: Center(
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: isSelected ? color : AppColors.darkElevated,
              borderRadius: BorderRadius.circular(isSelected ? 16 : 24),
              border: isSelected
                  ? Border.all(
                      color: Colors.white.withValues(alpha: 0.8),
                      width: 1.5,
                    )
                  : null,
            ),
            child: Center(
              child: Text(
                shortCode,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
