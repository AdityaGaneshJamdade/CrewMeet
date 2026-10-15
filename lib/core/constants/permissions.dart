/// Bitfield permissions system for ChaiChu (nexcord).
///
/// NOTE: The final authority on permissions is Postgres Row Level Security (RLS)
/// and Supabase Edge Functions. Client checks are UX only (disabling buttons,
/// filtering views, etc.).
class AppPermissions {
  AppPermissions._();

  // 64-bit permission bitflags
  static const int none = 0;
  static const int administrator = 1 << 0; // Grants all permissions
  static const int viewChannels = 1 << 1;
  static const int manageChannels = 1 << 2;
  static const int manageRoles = 1 << 3;
  static const int manageServer = 1 << 4;
  static const int createInvites = 1 << 5;
  static const int changeNickname = 1 << 6;
  static const int manageNicknames = 1 << 7;
  static const int kickMembers = 1 << 8;
  static const int banMembers = 1 << 9;
  static const int sendMessages = 1 << 10;
  static const int sendMessagesInThreads = 1 << 11;
  static const int createPublicThreads = 1 << 12;
  static const int createPrivateThreads = 1 << 13;
  static const int embedLinks = 1 << 14;
  static const int attachFiles = 1 << 15;
  static const int addReactions = 1 << 16;
  static const int useExternalEmojis = 1 << 17;
  static const int mentionEveryone = 1 << 18;
  static const int manageMessages = 1 << 19;
  static const int manageThreads = 1 << 20;
  static const int readMessageHistory = 1 << 21;
  static const int connect = 1 << 22;
  static const int speak = 1 << 23;
  static const int stream = 1 << 24;
  static const int useVAD = 1 << 25;
  static const int prioritySpeaker = 1 << 26;
  static const int muteMembers = 1 << 27;
  static const int deafenMembers = 1 << 28;
  static const int moveMembers = 1 << 29;
  static const int stageModerator = 1 << 30;

  /// Default permissions granted to standard @everyone role
  static const int defaultEveryone = viewChannels |
      sendMessages |
      sendMessagesInThreads |
      readMessageHistory |
      addReactions |
      connect |
      speak |
      useVAD;

  /// Checks if [userPermissions] has [permission].
  ///
  /// If [userPermissions] includes [administrator], this always returns `true`.
  static bool has(int userPermissions, int permission) {
    if ((userPermissions & administrator) == administrator) {
      return true;
    }
    return (userPermissions & permission) == permission;
  }

  /// Checks if [userPermissions] has all permissions in [requiredPermissions].
  static bool hasAll(int userPermissions, Iterable<int> requiredPermissions) {
    if ((userPermissions & administrator) == administrator) {
      return true;
    }
    for (final p in requiredPermissions) {
      if ((userPermissions & p) != p) {
        return false;
      }
    }
    return true;
  }

  /// Checks if [userPermissions] has any permission in [checkPermissions].
  static bool hasAny(int userPermissions, Iterable<int> checkPermissions) {
    if ((userPermissions & administrator) == administrator) {
      return true;
    }
    for (final p in checkPermissions) {
      if ((userPermissions & p) == p) {
        return true;
      }
    }
    return false;
  }

  /// Adds [permission] to [currentPermissions].
  static int add(int currentPermissions, int permission) {
    return currentPermissions | permission;
  }

  /// Removes [permission] from [currentPermissions].
  static int remove(int currentPermissions, int permission) {
    return currentPermissions & ~permission;
  }

  /// Combines multiple permissions into a single bitmask.
  static int combine(Iterable<int> permissions) {
    var result = none;
    for (final p in permissions) {
      result |= p;
    }
    return result;
  }

  /// Computes effective permissions for a channel by applying denies then allows.
  static int computeWithOverwrites({
    required int basePermissions,
    required int channelDenies,
    required int channelAllows,
  }) {
    if ((basePermissions & administrator) == administrator) {
      return administrator;
    }
    var permissions = basePermissions;
    permissions &= ~channelDenies;
    permissions |= channelAllows;
    return permissions;
  }
}
