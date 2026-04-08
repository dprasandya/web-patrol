# Web Patrol - Flutter Web Application

A modern Flutter web application for patrol management with secure authentication.

## Features

- 🔐 **Secure Authentication**: Login/logout functionality with token-based authentication
- 📱 **Responsive Design**: Works seamlessly on desktop and mobile browsers
- 💾 **Persistent Sessions**: Auto-login using local storage
- 🎨 **Modern UI**: Material Design 3 with beautiful gradients and animations
- 📊 **Dashboard**: Patrol statistics and quick actions
- ⚡ **State Management**: Provider pattern for efficient state management

## Project Structure

```
web_patrol/
├── lib/
│   ├── main.dart              # App entry point and routing
│   ├── models/
│   │   └── user.dart          # User data model
│   ├── services/
│   │   ├── auth_service.dart  # Authentication API service
│   │   └── auth_provider.dart # Auth state management
│   ├── screens/
│   │   ├── login_screen.dart  # Login UI
│   │   └── home_screen.dart   # Dashboard UI
│   └── widgets/               # Reusable widgets
├── web/
│   ├── index.html             # Web entry point
│   └── manifest.json          # PWA manifest
└── pubspec.yaml               # Dependencies
```

## Getting Started

### Prerequisites

- Flutter SDK (3.0.0 or higher)
- Dart SDK
- A code editor (VS Code, Android Studio, etc.)

### Installation

1. Clone the repository:
```bash
cd web_patrol
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the web application:
```bash
flutter run -d chrome
```

Or build for production:
```bash
flutter build web --release
```

## Usage

### Demo Login

For demonstration purposes, you can login with any email and password (minimum 6 characters):
- Email: `patrol@example.com`
- Password: `password123`

### Features

1. **Login Screen**
   - Enter your credentials
   - Toggle password visibility
   - Form validation
   - Loading state during authentication

2. **Dashboard**
   - View patrol statistics
   - Quick action buttons
   - User profile display
   - Logout functionality

## Customization

### Backend Integration

To connect to your actual backend API:

1. Update `lib/services/auth_service.dart`:
```dart
static const String _baseUrl = 'https://your-api.com';
```

2. Modify the `login()` method to match your API endpoint
3. Update the `User` model fields to match your response structure

### Theming

Customize colors in `lib/main.dart`:
```dart
theme: ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
  // Change to your brand color
),
```

## Dependencies

- `provider`: State management
- `shared_preferences`: Local storage for persistent sessions
- `http`: HTTP client for API calls

## Security Notes

⚠️ **Important**: This is a demo application. For production use:

1. Implement proper JWT token validation
2. Use HTTPS for all API calls
3. Add password encryption
4. Implement refresh token mechanism
5. Add rate limiting and brute force protection
6. Store sensitive data securely

## Browser Support

- Chrome (recommended)
- Firefox
- Safari
- Edge

## License

This project is open source and available under the MIT License.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## Support

For issues and questions, please create an issue in the repository.
