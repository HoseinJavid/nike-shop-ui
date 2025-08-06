# Copilot Instructions for Nike Ecommerce Practice Flutter Project

## Project Overview
- This is a Flutter-based e-commerce app, structured for maintainability and scalability.
- Main app code is in `lib/`, organized by feature: `core/`, `data/`, `domain/`, `gen/`, `l10n/`, `presentation/`.
- Uses BLoC for state management (`flutter_bloc`), Hive for local storage, Dio for networking, and custom theming.

## Architecture & Patterns
- **Feature-based structure:**
  - `core/`: Shared constants, error handling, network, theme, and utilities.
  - `data/`: Data sources, models, repositories.
  - `domain/`: Entities and repository interfaces.
  - `presentation/`: UI pages and widgets.
- **State management:** BLoC pattern is used for business logic separation. Look for BLoC classes in `lib/data/` and `lib/presentation/`.
- **Assets:** Managed via `flutter_gen` and referenced using generated code (e.g., `Assets.img.nikeLogoWite.path`).
- **Localization:** `l10n/` directory for internationalization.
- **Custom widgets:** Common UI components are in `presentation/widgets/`.

## Developer Workflows
- **Build:**
  - Run `flutter pub get` to fetch dependencies.
  - Use `flutter pub run build_runner build` for code generation (e.g., assets, localization).
- **Test:**
  - Tests are in `lib/` and can be run with `flutter test`.
- **Debug:**
  - Use standard Flutter debugging tools. The app uses custom themes and asset management, so check `core/theme/` and `gen/` for related issues.

## Conventions & Integration
- **Naming:**
  - Classes, files, and folders follow lower_snake_case and PascalCase as per Dart/Flutter conventions.
- **Assets:**
  - All images and fonts are declared in `pubspec.yaml` and referenced via generated code.
- **External dependencies:**
  - Key packages: `flutter_bloc`, `dio`, `hive_flutter`, `flutter_gen`, `intl`, `shared_preferences`, `webview_flutter`.
- **Material Design:**
  - Uses Material widgets and custom theming from `core/theme/theme.dart`.
- **RTL Support:**
  - UI supports right-to-left text direction (see `Directionality` in pages like `auth_page.dart`).

## Example Patterns
- **Asset usage:**
  ```dart
  Image.asset(Assets.img.nikeLogoWite.path)
  ```
- **Custom widget:**
  ```dart
  CustomTextFild(hintText: 'پست الکترونیکی')
  ```
- **Theme usage:**
  ```dart
  backgroundColor: LightThemeColor.secondryColor
  ```

## Key Files & Directories
- `lib/core/theme/theme.dart`: Theming and color definitions.
- `lib/gen/assets.gen.dart`: Generated asset references.
- `lib/presentation/pages/auth_page.dart`: Example of page structure and RTL support.
- `pubspec.yaml`: Declares dependencies, assets, and fonts.

---
For new features, follow the feature-based directory structure and use BLoC for state management. Use generated asset references and custom widgets for UI consistency.
