import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/responsive_layout.dart';
import '../../../../shared/providers/auth_state_provider.dart';
import '../widgets/channel_list_pane.dart';
import '../widgets/member_list_pane.dart';
import '../widgets/server_rail.dart';

/// Responsive Home Shell for ChaiChu (nexcord).
///
/// Implements:
/// - Desktop / Tablet (>=700px): Permanent 3-Pane (Server rail | Channel list | Content | Member list).
/// - Mobile (<700px): Bottom navigation bar & sliding drawer.
class HomeShellScreen extends ConsumerStatefulWidget {
  const HomeShellScreen({super.key});

  @override
  ConsumerState<HomeShellScreen> createState() => _HomeShellScreenState();
}

class _HomeShellScreenState extends ConsumerState<HomeShellScreen> {
  int _selectedServerIndex = 1;
  String _selectedChannelId = 'general';
  int _mobileNavIndex = 0;
  bool _showMemberList = true;

  final List<String> _serverNames = [
    'Direct Messages',
    'Chai Enthusiasts',
    'Flutter Builders',
    'Tech & Gaming',
  ];

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile: _buildMobileLayout(context),
      desktop: _buildDesktopLayout(context),
    );
  }

  // Desktop / Tablet Multi-Pane Layout
  Widget _buildDesktopLayout(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // 1. Server Navigation Rail
          ServerRail(
            selectedServerIndex: _selectedServerIndex,
            onServerSelected: (index) {
              setState(() {
                _selectedServerIndex = index;
              });
            },
          ),
          const VerticalDivider(
              width: 1, thickness: 1, color: AppColors.darkBorder),

          // 2. Channel List Pane
          ChannelListPane(
            serverName: _serverNames[_selectedServerIndex],
            selectedChannelId: _selectedChannelId,
            onChannelSelected: (channelId) {
              setState(() {
                _selectedChannelId = channelId;
              });
            },
          ),
          const VerticalDivider(
              width: 1, thickness: 1, color: AppColors.darkBorder),

          // 3. Central Content Pane (Chat Timeline / Voice View)
          Expanded(
            child: Column(
              children: [
                _buildChannelHeader(),
                Expanded(
                  child: _buildChatTimeline(),
                ),
                _buildMessageInputArea(),
              ],
            ),
          ),

          // 4. Member List Pane (Collapsible)
          if (_showMemberList) ...[
            const VerticalDivider(
                width: 1, thickness: 1, color: AppColors.darkBorder),
            const MemberListPane(),
          ],
        ],
      ),
    );
  }

  // Mobile Bottom-Nav & Drawer Layout
  Widget _buildMobileLayout(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '#$_selectedChannelId',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.people_outline),
            onPressed: () {
              Scaffold.of(context).openEndDrawer();
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Sign Out',
            onPressed: () {
              ref.read(authStateProvider.notifier).signOut();
            },
          ),
        ],
      ),
      drawer: Drawer(
        backgroundColor: AppColors.darkSurface,
        child: SafeArea(
          child: Row(
            children: [
              ServerRail(
                selectedServerIndex: _selectedServerIndex,
                onServerSelected: (index) {
                  setState(() {
                    _selectedServerIndex = index;
                  });
                },
              ),
              Expanded(
                child: ChannelListPane(
                  serverName: _serverNames[_selectedServerIndex],
                  selectedChannelId: _selectedChannelId,
                  onChannelSelected: (channelId) {
                    setState(() {
                      _selectedChannelId = channelId;
                    });
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      endDrawer: const Drawer(
        backgroundColor: AppColors.darkSurface,
        child: SafeArea(
          child: MemberListPane(),
        ),
      ),
      body: Column(
        children: [
          Expanded(child: _buildChatTimeline()),
          _buildMessageInputArea(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _mobileNavIndex,
        onTap: (index) {
          setState(() {
            _mobileNavIndex = index;
          });
        },
        backgroundColor: AppColors.darkSurface,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.darkTextSecondary,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.forum_outlined),
            activeIcon: Icon(Icons.forum),
            label: 'Servers',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.mark_unread_chat_alt_outlined),
            activeIcon: Icon(Icons.mark_unread_chat_alt),
            label: 'Messages',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_none),
            activeIcon: Icon(Icons.notifications),
            label: 'Alerts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'You',
          ),
        ],
      ),
    );
  }

  Widget _buildChannelHeader() {
    return Container(
      height: 52,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: const BoxDecoration(
        color: AppColors.darkSurface,
        border: Border(
          bottom: BorderSide(color: AppColors.darkBorder),
        ),
      ),
      child: Row(
        children: [
          const Icon(Icons.tag, size: 20, color: AppColors.darkTextSecondary),
          const SizedBox(width: 8),
          Text(
            _selectedChannelId,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          const SizedBox(width: 12),
          const Text(
            '|  Welcome to ChaiChu community hub',
            style: TextStyle(
              color: AppColors.darkTextMuted,
              fontSize: 13,
            ),
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.search, size: 20),
            tooltip: 'Search Messages',
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(
              _showMemberList ? Icons.people : Icons.people_outline,
              size: 20,
              color: _showMemberList ? AppColors.primary : null,
            ),
            tooltip: 'Toggle Member List',
            onPressed: () {
              setState(() {
                _showMemberList = !_showMemberList;
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout, size: 20),
            tooltip: 'Sign Out',
            onPressed: () {
              ref.read(authStateProvider.notifier).signOut();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildChatTimeline() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      children: [
        // Welcome Banner
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.darkElevated,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.darkBorder),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.tag, color: Colors.white, size: 28),
              ),
              const SizedBox(height: 12),
              Text(
                'Welcome to #$_selectedChannelId!',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'This is the start of the channel. Send a message, launch a voice room, or invite friends to begin.',
                style: TextStyle(
                  color: AppColors.darkTextSecondary,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        // Sample Messages
        _buildMessageItem(
          author: 'Aditya (Lead)',
          time: 'Today at 2:00 PM',
          content:
              'Welcome to ChaiChu! The architecture enforces feature-first cleanliness and pure permission bitfields.',
          color: AppColors.accentChai,
        ),
        _buildMessageItem(
          author: 'Priya Patel',
          time: 'Today at 2:05 PM',
          content:
              'Great to see the responsive layout adapting between mobile and desktop three-pane views!',
          color: AppColors.primary,
        ),
      ],
    );
  }

  Widget _buildMessageItem({
    required String author,
    required String time,
    required String content,
    required Color color,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: color,
            child: Text(
              author.characters.first,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      author,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: color,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      time,
                      style: const TextStyle(
                        fontSize: 11,
                        color: AppColors.darkTextMuted,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  content,
                  style: const TextStyle(
                    fontSize: 14,
                    height: 1.4,
                    color: AppColors.darkTextPrimary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageInputArea() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(
        color: AppColors.darkSurface,
        border: Border(
          top: BorderSide(color: AppColors.darkBorder),
        ),
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.add_circle,
                color: AppColors.darkTextSecondary),
            tooltip: 'Attach Media',
            onPressed: () {},
          ),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Message #$_selectedChannelId',
                isDense: true,
                filled: true,
                fillColor: AppColors.darkElevated,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            icon: const Icon(Icons.mic, color: AppColors.darkTextSecondary),
            tooltip: 'Voice Message',
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.send_rounded, color: AppColors.primary),
            tooltip: 'Send',
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
