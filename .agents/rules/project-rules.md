# ChaiChu Project Rules

Follow these rules in every task:

1. **Feature-First Architecture**:
   - Folders structured as `lib/features/<name>/{data,domain,presentation}`.
   - UI never calls Supabase directly. Flow is strictly: `UI -> provider -> use case -> repository -> datasource`.

2. **Permissions**:
   - Permissions are represented as a bitfield in `lib/core/constants/permissions.dart`.
   - Final authority is Postgres Row-Level Security (RLS) and Edge Functions; client checks are UX only.

3. **Responsive Design**:
   - Mobile (`< 700px`) uses bottom navigation and drawers.
   - Desktop and tablet use three panes (`server rail | channel list | content | member list`).

4. **Honesty & Completeness**:
   - Never stub a feature and call it done.
   - If something cannot be built, mark it `NOT_IMPLEMENTED` with the rationale in `docs/FEATURE_STATUS.md`.

5. **Package Integrity**:
   - Never invent package names or APIs.
   - Always verify on pub.dev and official documentation.

6. **Security & Secrets**:
   - No hardcoded secrets anywhere.
   - Use `.env` (via flutter_dotenv / envied) and Supabase secrets / environment variables.

7. **Quality Gates for Every Task**:
   - `flutter analyze` must report zero issues.
   - `dart format` must be applied cleanly.
   - Unit tests for use cases and permission logic.
   - RLS enabled on every new table with a policy test.
   - Update `docs/FEATURE_STATUS.md` on every feature change.
   - Provide a 5-line manual test script with every completed task.

8. **Process Discipline**:
   - Work one step at a time.
   - Produce a plan artifact first and wait for user approval before coding.
