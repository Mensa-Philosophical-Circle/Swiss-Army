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

- No word the user reads is typed into a widget. Use a key: `'sign_in_title'.tr`. Keys live in
  `utils/localization/app_translations.dart`; a new language has the same keys as English.
- No value is typed twice: names, paths and numbers shared by two places are constants in `utils/constants/`.
- Asset paths are constants, never strings inside a widget.

## Look

- The look is set once, in `utils/theme/app_theme.dart`. A screen reads colours from `Theme.of(context)`,
  not from a fixed colour, so changing the theme changes everything.
- Sizes use `flutter_screenutil` (`16.w`, `16.h`, `16.sp`) so a screen works on every phone and tablet.
- The bottom bar is native on each platform: liquid glass on iOS, Material 3 on Android.

## Loading, errors and forms

- Every screen that loads shows a loading state, an error with a way to retry, and an empty state.
- A form checks its fields as the person types and only enables sending when it is valid.
- A button that sends something is disabled (or shows `isLoading`) until the answer comes back.

## Commits

- Conventional Commits: `type(scope): subject`, subject 100 characters at most, enforced by the hook.
- Run the checks first. Never skip a hook.
