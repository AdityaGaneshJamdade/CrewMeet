import 'package:flutter_test/flutter_test.dart';
import 'package:nexcord/core/constants/permissions.dart';

void main() {
  group('AppPermissions bitfield tests', () {
    test('Default permissions should include basic communication', () {
      expect(
        AppPermissions.has(
          AppPermissions.defaultEveryone,
          AppPermissions.viewChannels,
        ),
        isTrue,
      );
      expect(
        AppPermissions.has(
          AppPermissions.defaultEveryone,
          AppPermissions.sendMessages,
        ),
        isTrue,
      );
      expect(
        AppPermissions.has(
          AppPermissions.defaultEveryone,
          AppPermissions.manageChannels,
        ),
        isFalse,
      );
    });

    test('Administrator bit must bypass all permission checks', () {
      const adminPerms = AppPermissions.administrator;

      expect(
        AppPermissions.has(adminPerms, AppPermissions.banMembers),
        isTrue,
      );
      expect(
        AppPermissions.has(adminPerms, AppPermissions.manageServer),
        isTrue,
      );
      expect(
        AppPermissions.has(adminPerms, AppPermissions.stageModerator),
        isTrue,
      );
    });

    test('hasAll checks all required permissions', () {
      const perms = AppPermissions.viewChannels | AppPermissions.sendMessages;

      expect(
        AppPermissions.hasAll(perms, [
          AppPermissions.viewChannels,
          AppPermissions.sendMessages,
        ]),
        isTrue,
      );

      expect(
        AppPermissions.hasAll(perms, [
          AppPermissions.viewChannels,
          AppPermissions.manageChannels,
        ]),
        isFalse,
      );
    });

    test('hasAny checks if at least one permission matches', () {
      const perms = AppPermissions.speak;

      expect(
        AppPermissions.hasAny(perms, [
          AppPermissions.muteMembers,
          AppPermissions.speak,
        ]),
        isTrue,
      );

      expect(
        AppPermissions.hasAny(perms, [
          AppPermissions.muteMembers,
          AppPermissions.deafenMembers,
        ]),
        isFalse,
      );
    });

    test('add and remove modify bits correctly', () {
      var perms = AppPermissions.none;
      expect(perms, equals(0));

      perms = AppPermissions.add(perms, AppPermissions.viewChannels);
      expect(
        AppPermissions.has(perms, AppPermissions.viewChannels),
        isTrue,
      );

      perms = AppPermissions.remove(perms, AppPermissions.viewChannels);
      expect(
        AppPermissions.has(perms, AppPermissions.viewChannels),
        isFalse,
      );
    });

    test('combine aggregates multiple permissions', () {
      final combined = AppPermissions.combine([
        AppPermissions.viewChannels,
        AppPermissions.sendMessages,
        AppPermissions.embedLinks,
      ]);

      expect(
        AppPermissions.has(combined, AppPermissions.viewChannels),
        isTrue,
      );
      expect(
        AppPermissions.has(combined, AppPermissions.sendMessages),
        isTrue,
      );
      expect(
        AppPermissions.has(combined, AppPermissions.embedLinks),
        isTrue,
      );
      expect(
        AppPermissions.has(combined, AppPermissions.connect),
        isFalse,
      );
    });

    test('computeWithOverwrites applies channel denies then allows', () {
      const base = AppPermissions.viewChannels | AppPermissions.sendMessages;
      const denies = AppPermissions.sendMessages; // Deny send messages
      const allows = AppPermissions.attachFiles; // Allow attach files

      final effective = AppPermissions.computeWithOverwrites(
        basePermissions: base,
        channelDenies: denies,
        channelAllows: allows,
      );

      expect(
        AppPermissions.has(effective, AppPermissions.viewChannels),
        isTrue,
      );
      expect(
        AppPermissions.has(effective, AppPermissions.sendMessages),
        isFalse,
      );
      expect(
        AppPermissions.has(effective, AppPermissions.attachFiles),
        isTrue,
      );
    });
  });
}
