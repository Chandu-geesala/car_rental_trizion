#  Car Rental App - Trizion Task

A modern and elegant Flutter car rental application with complete booking flow, built with Material Design and Provider state management.

---

## 📱 Features

- **Welcome Screen** - Login with email validation and guest access
- **Home Screen** - Browse available cars with search functionality
- **Car Details** - View detailed specifications, ratings, and pricing
- **Booking Form** - Fill personal details with validation and date selection
- **Confirmation** - Review complete booking summary

---

## 🛠️ Tech Stack

- **Framework**: Flutter 3.x
- **Language**: Dart
- **State Management**: Provider
- **UI Design**: Material Design with custom Trizion colors
- **Platform**: Android (iOS ready)

---

## 📋 Prerequisites

Before running this application, ensure you have:

- Flutter SDK installed (3.0 or higher)
- Dart SDK (comes with Flutter)
- Android Studio or VS Code with Flutter plugins
- Android emulator or physical device
- Internet connection (for loading car images)

---

## 🚀 Getting Started

### 1. Clone the Repository

```bash
git clone https://github.com/Chandu-geesala/car_rental_trizion/tree/master
cd trizon_task
```

### 2. Install Dependencies

```bash
flutter pub get
```

### 3. Run the Application

**For Android Emulator:**
```bash
flutter run
```

**For Physical Device:**
- Enable USB debugging on your Android device
- Connect via USB
```bash
flutter run
```

**For iOS Simulator (macOS only):**
```bash
flutter run -d ios
```

---

## 📂 Project Structure

```
trizon_task/
├── lib/
│   ├── main.dart                          # App entry point
│   ├── models/
│   │   ├── car.dart                       # Car model
│   │   └── booking.dart                   # Booking model
│   ├── providers/
│   │   └── booking_provider.dart          # Booking state management
│   ├── screens/
│   │   ├── welcome_screen.dart            # Login/Guest screen
│   │   ├── home_screen.dart               # Car listing screen
│   │   ├── car_detail_screen.dart         # Car details screen
│   │   ├── booking_form_screen.dart       # Booking form screen
│   │   └── confirmation_screen.dart       # Booking confirmation
│   └── data/
│       └── mock_data.dart                 # Mock car data
├── assets/
│   └── logo.png                           # App logo
├── android/
│   └── app/src/main/AndroidManifest.xml   # Android configuration
└── pubspec.yaml                           # Dependencies
```

---

## 🎨 Color Scheme

The app uses **Trizion's brand colors**:

- **Primary**: `#15a89c` (Teal)
- **Secondary**: `#e8f4f3` (Light Teal)
- **Text Dark**: `#1a1a1a`
- **Text Medium**: `#666666`
- **Background**: `#f5f5f5`

---

## ✅ Key Validations

### Welcome Screen
- Email format validation (username@domain.com)
- Password minimum 6 characters
- Guest access option

### Booking Form
- Name validation (required)
- Email format validation
- Phone number: Exactly 10 digits, numbers only
- Pickup location validation
- Date selection for rental period

---

## 📦 Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  provider: ^6.0.0
  cupertino_icons: ^1.0.6
```

---

## 🔧 Configuration

### Android Internet Permission

The app requires internet permission to load car images. This is already configured in:

**File**: `android/app/src/main/AndroidManifest.xml`

```xml
<uses-permission android:name="android.permission.INTERNET"/>
```

### Assets Configuration

**File**: `pubspec.yaml`

```yaml
flutter:
  assets:
    - assets/logo.png
```

---

## 📱 App Flow

1. **Welcome Screen** → Enter email/password or continue as guest
2. **Home Screen** → Browse cars, search by name/brand/type
3. **Car Details** → View specifications and click "Book Now"
4. **Booking Form** → Fill personal details and select dates
5. **Confirmation** → Review booking summary and return home

---

## 🏗️ Build Commands

### Debug Build
```bash
flutter run
```

### Release Build (APK)
```bash
flutter build apk --release
```

### Release Build (App Bundle)
```bash
flutter build appbundle --release
```

---

## 🧪 Testing

Run the app on an emulator or device:

```bash
# List available devices
flutter devices

# Run on specific device
flutter run -d <device-id>
```

---

## 👨‍💻 Development

### Code Organization
- **Models**: Data structures for Car and Booking
- **Providers**: State management using Provider package
- **Screens**: UI screens with Material Design
- **Data**: Mock data for car listings

### Design Patterns
- Provider pattern for state management
- Separation of concerns (Model-View-Provider)
- Reusable widget components

---

## 📄 License

This project is created for Trizion Technologies task submission.

---

## 🤝 Contributing

For any issues or questions, please reach out to:
- **Developer**: Chandu Geesala

---

