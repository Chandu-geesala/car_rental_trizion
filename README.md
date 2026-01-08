
***

## Project overview

- **Tech stack**: Flutter, Dart.[5]
- **Platforms**: Android (and iOS if you have Xcode set up).[5]
- **Main features**:
    - Welcome/login screen with basic validation.[5]
    - Home screen with search, car list, and availability badges.[5]
    - Car detail screen with specs, price, and “Book Now”.[5]
    - Booking form with validation and date selection.[5]
    - Confirmation screen summarizing the booking.[5]

***

## Prerequisites

- **Flutter SDK** installed and added to PATH.[5]
- **Dart** bundled with Flutter (no separate install needed).[5]
- Android Studio / VS Code with Flutter & Dart plugins recommended.[5]
- An Android device or emulator; for iOS you need Xcode on macOS.[5]

***

## Setup instructions

1. **Clone or download the project**
    - Place the project folder (trizon_task) anywhere on your machine.[5]

2. **Install dependencies**
    - Open a terminal in the project root and run:[5]
      ```bash
      flutter pub get
      ```

***

## How to run the app

1. **Start an emulator or connect a device**
    - Enable USB debugging on Android and connect via USB, or start an Android emulator from Android Studio.[5]

2. **From terminal** (in project root):
   ```bash
   flutter run
   ```  
    - If you have multiple devices, select one from the list shown in the terminal.[5]

3. **From Android Studio / VS Code**:
    - Open the project folder.[5]
    - Select a target device in the device selector.[5]
    - Click **Run** (▶) to launch.[5]

The app will start on the **Welcome Screen**, then navigate to **Home**, **Car Details**, **Booking Form**, and **Confirmation** as you interact.[5]

***

## Project structure (key files)

- `lib/main.dart` – App entry point and MaterialApp setup.[5]
- `lib/screens/welcome_screen.dart` – Login / guest access screen.[5]
- `lib/screens/home_screen.dart` – Car listing, search, and app bar with logo/title/logout.[5]
- `lib/screens/car_detail_screen.dart` – Detailed car view and “Book Now” button.[5]
- `lib/screens/booking_form_screen.dart` – Booking form with validation and date pickers.[5]
- `lib/screens/confirmation_screen.dart` – Booking summary and “Back to Home”.[5]
- `lib/data/mock_data.dart` – Static mock list of cars.[5]
- `lib/models/car.dart` and `lib/models/booking.dart` – Data models.[5]
- `lib/providers/booking_provider.dart` – Manages current booking via Provider.[5]

***

## Common issues & tips

- **Images not loading**:
    - Check internet permission in AndroidManifest and that each `imageUrl` is a valid `https` URL.[5]

- **Logo not appearing**:
    - Confirm `assets/logo.png` path and `pubspec.yaml` asset entry, then run `flutter pub get` and restart the app.[5]
