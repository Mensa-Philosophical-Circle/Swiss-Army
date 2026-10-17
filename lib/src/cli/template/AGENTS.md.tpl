# Engineering rules

Every change, by a person or a tool, follows these. `bash scripts/quality_gate.sh` checks them, and
`bash scripts/setup_hooks.sh` runs that check before every commit.

## Structure (GetX)

- Code lives in `lib/app/`: `routes`, `bindings`, `modules`, `data`, `utils`, `widgets`.
- A screen is a module: `modules/<name>/{bindings,controllers,views,widgets}`. Add one with
  `get create page:<name>`, then bring it in line with the rules below (the command writes plain `Text`).
- Views show and controllers decide. A view holds no logic and no API calls; a controller holds no widgets.
- Calls to the server live in `data/` (api, repositories, services), never in a controller or view.
- A widget lives with the one screen that uses it, in that module's `widgets/`. Only a widget two modules
  use goes to `lib/app/widgets/`. A module never imports another module's widgets.

## Size

- A file in `lib/` is **200 lines at most**. Split it by responsibility, not by line count.

## Text and type

- Text goes through `swiss_army_component`: `BigAppText`, `MedAppText`, `SmallAppText`. No raw `Text(...)`,
  `Text.rich` or `TextStyle(...)` in screens or widgets.
- **`FontWeight.w600` is the heaviest weight.** Never `bold`, `w700`, `w800` or `w900`.
- Titles and buttons w600, sub-headings w500, body text w400.

## Words and values

- No word the user reads is typed into a widget. Use a key: `'sign_in_title'.tr`. The words live in
  `utils/localization/languages/`, one file per language (en, es, fr, de), **every file with the same keys**.
  A new key goes into all of them in the same change.
- No value is typed twice: names, paths and numbers shared by two places are constants in `utils/constants/`.
- Icons and line art are **SVG**, pictures are **WebP**. No PNG or JPEG in `assets/` (only the native launcher
  icons are PNG). Asset paths are constants, never strings inside a widget.
- Nothing is written twice: a widget two modules need is in `lib/app/widgets/`, formatters are in
  `utils/formatters/`, there is one network client (in `data/`), and colours come from the theme.

## Look

- The look is set once, in `utils/theme/app_theme.dart`. A screen reads colours from `Theme.of(context)`,
  not from a fixed colour, so changing the theme changes everything.
- Sizes use `flutter_screenutil` (`16.w`, `16.h`, `16.sp`) so a screen works on every phone and tablet.
- The bottom bar is native on each platform: liquid glass on iOS, Material 3 on Android.

## Loading, errors and forms

- Every screen that loads shows a loading state, an error with a way to retry, and an empty state.
- A form checks its fields as the person types and only enables sending when it is valid.
- A button that sends something is disabled (or shows `isLoading`) until the answer comes back.

## Security

- No secret, key or password in the code. Settings that differ per machine go in a `.env` that is not committed.
- Every address is `https://` (`localhost` and the emulator are the only exceptions).
- A sign-in token is kept in `flutter_secure_storage`, never in `SharedPreferences` or `GetStorage`.

## Commits

- Conventional Commits: `type(scope): subject`, subject 100 characters at most, enforced by the hook.
- Run the checks first. Never skip a hook.
