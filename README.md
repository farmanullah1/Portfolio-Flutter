# Farmanullah Ansari - Flutter Portfolio App

This is a Flutter-based Android application that replicates the original React portfolio with full feature parity.

## Features Replicated
- **Hero Section**: Includes a profile image with glow effects and a dynamic typing animation for roles.
- **About Section**: Professional summary with key highlights.
- **Skills Section**: Categorized technical skills using glassmorphism cards.
- **Projects Section**: List of featured projects with tech stacks and external links.
- **Experience & Education**: Timeline-style view of work history and academics.
- **Certifications**: List of licenses and certifications with issuer logos.
- **Why Work With Me?**: Key value propositions for clients/employers.
- **Insights & Blog**: Shared articles and professional insights.
- **Contact Form**: Responsive form for inquiries.
- **Theme Support**: Seamless Dark/Light mode toggling via Provider.
- **Navigation**: Scrolling-aware AppBar with progress indicator and a mobile-friendly Drawer.
- **Back to Top**: Convenient floating button for long-page navigation.

## Requirements
- Flutter SDK
- Android Emulator or physical device

## Dependencies
- `url_launcher`: Opening project links and CV.
- `font_awesome_flutter`: Brand and technical icons.
- `google_fonts`: Using the 'Inter' typography.
- `flutter_animate`: Fluid animations and transitions.
- `provider`: Reactive theme state management.

## How to Run

1.  **Get dependencies**:
    ```bash
    flutter pub get
    ```
2.  **Run on Device**:
    ```bash
    flutter run
    ```
3.  **Build APK**:
    ```bash
    flutter build apk --release
    ```

## Development
The code follows best practices with widget composition and clear separation of concerns.
- `lib/theme.dart`: Centralized design tokens.
- `lib/models.dart`: Single source of truth for portfolio content.
- `lib/sections.dart`: Individual UI components for each portfolio section.
