# Permissions System Specification

## Overview
Permissions in ChaiChu are represented as an immutable **64-bit BigInt Bitfield** in client code (`lib/core/constants/permissions.dart`) and stored as `BIGINT` in Postgres.

Final authority on all operations rests solely with **Postgres Row Level Security (RLS)** and **Supabase Edge Functions**. Client-side permission checks are purely for UI responsiveness and user experience (e.g. disabling buttons or hiding moderation menus).

## Bitfield Allocation Matrix

| Permission Constant | Bit Position | Hex Value | Description |
| :--- | :--- | :--- | :--- |
| `ADMINISTRATOR` | `1 << 0` | `0x00000001` | Grants all permissions, bypasses channel overrides |
| `VIEW_CHANNELS` | `1 << 1` | `0x00000002` | View channels and server overview |
| `MANAGE_CHANNELS` | `1 << 2` | `0x00000004` | Create, edit, and delete channels |
| `MANAGE_ROLES` | `1 << 3` | `0x00000008` | Create and edit roles lower than user's highest role |
| `MANAGE_SERVER` | `1 << 4` | `0x00000010` | Change server name, icon, and regional settings |
| `CREATE_INVITES` | `1 << 5` | `0x00000020` | Generate invite links to the server/channel |
| `CHANGE_NICKNAME` | `1 << 6` | `0x00000040` | Change own nickname in the server |
| `MANAGE_NICKNAMES` | `1 << 7` | `0x00000080` | Change other members' nicknames |
| `KICK_MEMBERS` | `1 << 8` | `0x00000100` | Kick members with lower hierarchy |
| `BAN_MEMBERS` | `1 << 9` | `0x00000200` | Ban members with lower hierarchy |
| `SEND_MESSAGES` | `1 << 10` | `0x00000400` | Send text messages in text channels |
| `SEND_MESSAGES_IN_THREADS` | `1 << 11` | `0x00000800` | Send messages within public/private threads |
| `CREATE_PUBLIC_THREADS` | `1 << 12` | `0x00001000` | Initiate public threads |
| `CREATE_PRIVATE_THREADS` | `1 << 13` | `0x00002000` | Initiate private threads |
| `EMBED_LINKS` | `1 << 14` | `0x00004000` | Generate rich link previews |
| `ATTACH_FILES` | `1 << 15` | `0x00008000` | Upload attachments and media |
| `ADD_REACTIONS` | `1 << 16` | `0x00010000` | Add new reactions to messages |
| `USE_EXTERNAL_EMOJIS` | `1 << 17` | `0x00020000` | Use emojis from other servers |
| `MENTION_EVERYONE` | `1 << 18` | `0x00040000` | Mention @everyone and @here |
| `MANAGE_MESSAGES` | `1 << 19` | `0x00080000` | Delete and pin messages sent by others |
| `MANAGE_THREADS` | `1 << 20` | `0x00100000` | Delete and archive threads |
| `READ_MESSAGE_HISTORY` | `1 << 21` | `0x00200000` | Read previous message history in channels |
| `CONNECT` | `1 << 22` | `0x00400000` | Connect to voice and stage channels |
| `SPEAK` | `1 << 23` | `0x00800000` | Transmit audio in voice channels |
| `STREAM` | `1 << 24` | `0x01000000` | Share camera video or screen share |
| `USE_VAD` | `1 << 25` | `0x02000000` | Use Voice Activity Detection instead of Push-to-Talk |
| `PRIORITY_SPEAKER` | `1 << 26` | `0x04000000` | Lower other speakers when transmitting |
| `MUTE_MEMBERS` | `1 << 27` | `0x08000000` | Server-mute other members in voice |
| `DEAFEN_MEMBERS` | `1 << 28` | `0x10000000` | Server-deafen other members in voice |
| `MOVE_MEMBERS` | `1 << 29` | `0x20000000` | Move members between voice channels |
| `STAGE_MODERATOR` | `1 << 30` | `0x40000000` | Manage speakers and audience on stage |

## Permission Computation Pipeline
1. Compute Base Permissions for `@everyone` role.
2. Bitwise OR with all specific Roles assigned to the member.
3. If `ADMINISTRATOR` bit (`1 << 0`) is set, return full permissions immediately.
4. Apply Channel-Specific Overwrite denies (`& ~channel_denies`).
5. Apply Channel-Specific Overwrite allows (`| channel_allows`).
