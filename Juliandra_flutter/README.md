# Juliandra 5G - Agenda App

A Flutter mobile application for managing agendas with the Juliandra 5G API.

## Features

- View all agendas in a list
- Create new agenda
- View agenda details
- Update agenda
- Delete agenda
- Pull-to-refresh functionality
- Error handling with retry

## Project Structure

```
juliandra_flutter/
├── pubspec.yaml
├── lib/
│   ├── main.dart
│   ├── models/
│   │   └── agenda.dart
│   ├── services/
│   │   └── api_service.dart
│   ├── providers/
│   │   └── agenda_provider.dart
│   └── screens/
│       ├── home_screen.dart
│       ├── agenda_form_screen.dart
│       └── agenda_detail_screen.dart
```

## Setup Instructions

### 1. Install Dependencies

```bash
flutter pub get
```

### 2. Configure API Base URL

Edit `lib/services/api_service.dart` and change the `baseUrl` if needed:

```dart
static const String baseUrl = 'http://localhost:8000/api';
```

### 3. Run the App

```bash
flutter run
```

## API Configuration

The app connects to a Laravel backend API. Make sure the API server is running:

```bash
# In your Laravel project directory
php artisan serve
```

The API should be available at `http://localhost:8000/api`

## API Endpoints

- `GET /api/agenda` - Get all agendas
- `POST /api/agenda` - Create new agenda
- `GET /api/agenda/{id}` - Get single agenda
- `PUT /api/agenda/{id}` - Update agenda
- `DELETE /api/agenda/{id}` - Delete agenda

## Dependencies

- `provider: ^6.1.1` - State management
- `http: ^1.2.0` - HTTP client
- `intl: ^0.19.0` - Date formatting

## Notes

- The app uses Material Design 3
- State management is handled with Provider
- All API errors are displayed to the user with retry options

