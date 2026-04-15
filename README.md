# Flutter Clean App

A Flutter application demonstrating clean architecture with Dio, BLoC pattern, and SharedPreferences.

---

## Architecture

The project follows a strict 3-layer separation of concerns:

```
lib/
├── main.dart
├── models/
│   └── item.dart               # Data model
├── services/                   # Data layer
│   ├── api_service.dart        # Dio HTTP client
│   └── shared_preferences_service.dart  # Local storage
├── blocs/                      # Business logic layer
│   ├── items/
│   │   ├── items_bloc.dart
│   │   ├── items_event.dart
│   │   └── items_state.dart
│   └── theme/
│       ├── theme_bloc.dart
│       ├── theme_event.dart
│       └── theme_state.dart
└── screens/                    # UI layer
    ├── home_screen.dart
    └── settings_screen.dart
```

### Layer rules

| Layer        | Responsibility                                   | Forbidden                            |
|-------------|--------------------------------------------------|--------------------------------------|
| **screens** | Display UI, call BLoC events, react to states    | Business logic, direct API/DB calls  |
| **blocs**   | Handle events, manage states, call services      | Flutter UI imports (Material/Widgets)|
| **services**| HTTP requests, local storage read/write          | UI, BLoC dependencies                |

---

## Packages used

| Package              | Purpose                      |
|---------------------|------------------------------|
| `dio`               | HTTP client for API calls    |
| `shared_preferences`| Persist theme setting locally|
| `flutter_bloc`      | BLoC state management        |
| `equatable`         | Value equality for states    |

---

## API

The app uses [JSONPlaceholder](https://jsonplaceholder.typicode.com) as a demo REST API.

| Method | Endpoint           | Description        |
|--------|--------------------|--------------------|
| GET    | `/todos?_limit=20` | Fetch item list    |
| POST   | `/todos`           | Create a new item  |
| DELETE | `/todos/:id`       | Delete an item     |

> **Note:** JSONPlaceholder is a read-only mock API — POST and DELETE calls return success responses but do not actually persist changes. To use a real persistent backend, replace `_baseUrl` in `lib/services/api_service.dart` with your own [MockAPI.io](https://mockapi.io) endpoint.

### Switching to MockAPI.io

1. Go to [https://mockapi.io](https://mockapi.io) and create a free account.
2. Create a new project and add a resource (e.g. `items`) with fields: `id` (auto), `title` (String), `createdAt` (DateTime).
3. Copy the base URL (e.g. `https://64abc123.mockapi.io/api/v1`).
4. In `lib/services/api_service.dart`, replace:
   ```dart
   static const String _baseUrl = 'https://jsonplaceholder.typicode.com';
   ```
   with your MockAPI base URL and update the endpoint paths to `/items`.

---

## How to run

### Prerequisites

- Flutter SDK ≥ 3.0.0

### Steps

```bash
git clone <your-repo-url>
cd flutter_clean_app
flutter pub get
flutter run
```

---

## Features

- **Home screen** — list of items from API, loading/error states, retry button, add item dialog
- **Settings screen** — light/dark theme toggle persisted via SharedPreferences

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Learn Flutter](https://docs.flutter.dev/get-started/learn-flutter)
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
