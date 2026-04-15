# flutter_todo_app

Flutter app for a Bakberdi's assignment. Shows a todo list fetched from an API, lets you add and delete items, and has a dark/light theme switch that saves between sessions.

## Architecture

Split into 3 layers:

```
lib/
├── main.dart
├── models/
│   └── item.dart
├── services/        ← handles API and local storage
│   ├── api_service.dart
│   └── shared_preferences_service.dart
├── blocs/           ← business logic only, no UI code
│   ├── items/
│   └── theme/
└── screens/         ← UI only, no logic
    ├── home_screen.dart
    └── settings_screen.dart
```

The rule I followed:
- **screens** just display what the bloc says, nothing else
- **blocs** call services and update state, no Flutter/Material imports
- **services** do all the actual network/storage work

## How to run

```bash
git clone <your-repo-url>
cd flutter_clean_app
flutter pub get
flutter run
```

Tested on Android Emulator.

## API

Using [JSONPlaceholder](https://jsonplaceholder.typicode.com) as a free fake REST API.

- `GET /todos?_limit=20` – load list
- `POST /todos` – add item
- `DELETE /todos/:id` – delete item


## Packages

- [dio](https://pub.dev/packages/dio) – HTTP requests
- [flutter_bloc](https://pub.dev/packages/flutter_bloc) – state management
- [shared_preferences](https://pub.dev/packages/shared_preferences) – saving the theme choice
- [equatable](https://pub.dev/packages/equatable) – makes comparing bloc states easier
