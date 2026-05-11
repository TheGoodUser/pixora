# Pixora

A Flutter mobile application for efficient image upload and processing with seamless backend integration.

## What is Pixora?

Pixora is a cross-platform mobile application built with Flutter that allows users to capture, select, and upload images for server-side processing. It provides a clean, intuitive interface for image management with features including image preview, upload history, and real-time status tracking.

## Key Features

- **Image Capture & Selection**: Pick images from your device camera or gallery with permission handling
- **Image Preview**: View and review images before upload with a dedicated preview screen
- **Upload Management**: Seamless upload to backend server with progress tracking
- **History Tracking**: View all previously uploaded images and their processing status
- **Cross-Platform**: Runs on Android and iOS devices
- **Provider State Management**: Efficient state management using the Provider package

## Getting Started

### Prerequisites

- Flutter SDK (3.1.0 or higher)
- Dart SDK (3.1.0 or higher)
- Android SDK and Android Studio (for Android development)
- Xcode (for iOS development on macOS)
- Backend server running ([Pixora Backend](https://github.com/TheGoodUser/pixora-backend))

### Backend Setup

Pixora requires a backend server for image processing. Set up the backend repository first:

1. Clone the backend repository:
   ```bash
   git clone https://github.com/TheGoodUser/pixora-backend
   cd pixora-backend
   ```

2. Initialize and start the backend:
   ```bash
   chmod +x ./init.sh
   sudo ./init.sh
   ```

3. For more backend setup details, visit [Pixora Backend Repository](https://github.com/TheGoodUser/pixora-backend)

### Frontend Installation

1. Clone this repository:
   ```bash
   git clone https://github.com/TheGoodUser/pixora
   cd pixora
   ```

2. Install Flutter dependencies:
   ```bash
   flutter pub get
   ```

3. For Android development, verify the Android SDK is properly installed:
   ```bash
   flutter doctor
   ```

### Running the Application

#### Android

```bash
flutter run
```

For device debugging with network access to backend, set up port forwarding:

```bash
adb reverse tcp:8000 tcp:8000
```

This command forwards port 8000 from your development machine to the Android device, allowing the app to communicate with the backend server running on `http://localhost:8000`.

#### iOS

```bash
flutter run -d ios
```

### Development Workflow

1. Start the backend server on your development machine
2. Connect an Android device or iOS simulator
3. Set up port forwarding (Android): `adb reverse tcp:8000 tcp:8000`
4. Run: `flutter run`
5. The app will connect to the backend at `http://localhost:8000`

## Project Structure

```
lib/
├── main.dart                 # Application entry point
├── controllers/             # State management using Provider
│   ├── image_pick_controller.dart
│   ├── image_preview_controller.dart
│   ├── image_upload_controller.dart
│   ├── screen_controller.dart
│   └── history_controller.dart
├── views/                   # UI screens and widgets
│   ├── screens/
│   │   ├── home_screen.dart
│   │   ├── image_screen.dart
│   │   └── history_screen.dart
│   └── widgets/
├── services/               # Business logic and API integration
│   ├── api_services.dart
│   └── image_services.dart
└── models/                # Data models
    └── request_model.dart
```

## Key Technologies

- **Flutter**: Cross-platform UI framework
- **Dart**: Programming language
- **Provider**: State management
- **Image Picker**: For selecting images from device
- **HTTP Client**: For API communication
- **Permission Handler**: For managing device permissions
- **Video Player**: For media handling
- **Internationalization (intl)**: For localization support

## Application Permissions

Pixora requires the following permissions to function properly:

- **Camera**: To capture images directly from the device camera
- **Storage**: To read and access images from device storage (Android 12 and below)
- **Media Images**: To access images on Android 13+
- **Internet**: To communicate with the backend server

## API Integration

Pixora communicates with a backend server at `http://localhost:8000` with the following endpoints:

### Upload Image

**Endpoint**: `POST /upload`

Upload a selected or captured image to the server for processing.

```dart
// Example usage from ImageUploadController
await APIService.uploadImage(imageFile);
```

### Retrieve History

**Endpoint**: `GET /history`

Fetch all previously uploaded images and their status.

```dart
// Example usage from HistoryController
final history = await APIService.getHistory();
```

For complete API documentation, refer to the [Pixora Backend Repository](https://github.com/TheGoodUser/pixora-backend).

## Configuration

### Backend URL

The backend URL is currently hardcoded to `http://localhost:8000` in [lib/services/api_services.dart](lib/services/api_services.dart).

To change the backend URL for production:

```dart
static const String _baseUrl = "http://your-backend-url:8000";
```

## Support and Documentation

- **Flutter Documentation**: [https://docs.flutter.dev/](https://docs.flutter.dev/)
- **Dart Documentation**: [https://dart.dev/](https://dart.dev/)
- **Backend Repository**: [https://github.com/TheGoodUser/pixora-backend](https://github.com/TheGoodUser/pixora-backend)
- **Provider Package**: [https://pub.dev/packages/provider](https://pub.dev/packages/provider)

## Troubleshooting

### Common Issues

**Port already in use for backend**

If port 8000 is already in use:

```bash
# On Linux/macOS
lsof -i :8000

# On Windows
netstat -ano | findstr :8000
```

**Permission denied errors on Android**

Ensure that in [android/app/src/main/AndroidManifest.xml](android/app/src/main/AndroidManifest.xml), all required permissions are declared and requested at runtime.

**Device not connecting to backend**

Verify the port forwarding is active:

```bash
adb reverse tcp:8000 tcp:8000
adb reverse --list
```

For comprehensive troubleshooting, see the [Flutter documentation](https://docs.flutter.dev/).

## Contributing

We welcome contributions from the community! Please refer to [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines on how to contribute to this project.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Authors and Maintainers

Pixora is developed and maintained by the Pixora team. For questions or suggestions, please open an issue on this repository.

---

**Note**: This is an open-source project. For production deployment, ensure proper security configurations, HTTPS setup, and environment-specific backend URLs.
