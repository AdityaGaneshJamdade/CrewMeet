# Architecture Guide - ChaiChu ("nexcord")

## Architectural Paradigm
ChaiChu follows a strict **Feature-First Clean Architecture**.

```
lib/
├── core/
│   ├── config/       # Environment parsing & runtime app configs
│   ├── constants/    # Permission bitfield, route paths, styling tokens
│   ├── errors/       # Typed Domain Failures & Exception mappings
│   ├── router/       # GoRouter configuration & auth state redirect guards
│   ├── services/     # Third-party platform bridges (Storage, FCM, WebRTC)
│   ├── theme/        # Dark-default & Light theme palettes, ThemeExtensions
│   ├── utils/        # Pure utilities, logger, responsive layout helpers
│   └── widgets/      # Cross-feature re-usable UI primitives
├── shared/
│   ├── models/       # Cross-feature shared domain entities
│   ├── providers/    # Global providers (SupabaseClient, Network, Auth)
│   └── repositories/ # Cross-cutting repositories
└── features/
    └── <feature_name>/
        ├── data/           # DTOs, Datasources (Supabase API), Repository Impls
        ├── domain/         # Entities, Repository Interfaces, Use Cases
        └── presentation/   # Riverpod Controllers, Screens, Components
```

## Strict Layer Boundary & Data Flow
```
[ Presentation Layer: Widget / Screen ]
         │
         ▼
[ Presentation Layer: StateNotifier / Notifier Provider ]
         │
         ▼
[ Domain Layer: Use Case ]
         │
         ▼
[ Domain Layer: Repository Interface ]
         │
         ▼
[ Data Layer: Repository Implementation ]
         │
         ▼
[ Data Layer: Datasource (Supabase Client, LiveKit, REST) ]
```

### Invariants:
1. **Never bypass use cases or repositories**: UI widgets must never talk directly to Supabase client or network datasources.
2. **Immutability**: All domain entities and state objects must be immutable (`freezed` or Dart 3 records).
3. **Reactive Routing**: `go_router` listens to authentication changes and performs atomic redirects without manual `Navigator.push` spaghetti.
4. **Responsive Panes**:
   - Mobile (`< 700px`): Bottom Navigation Bar, Sliding Drawer for Channel list, Slide-over for Member list.
   - Tablet / Desktop (`>= 700px`): Permanent 3-Pane / 4-Pane layout (Server rail | Channel tree | Chat content | Member sidebar).
