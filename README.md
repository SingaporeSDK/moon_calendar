# Moon Calendar App

A beautiful, multi-language Flutter mobile app that displays lunar phases for any date. Track moon phases, see illumination percentages, explore detailed astronomical information, and discover cultural lunar festivals from around the world.

## 🌍 Supported Languages & Markets

The app is fully localized for:
- **English** (en_US) - Global
- **日本語** (ja_JP) - Japan
- **한국어** (ko_KR) - Korea
- **中文** (zh_CN) - China
- **हिंदी** (hi_IN) - India

Each language includes culturally-specific lunar festivals and celebrations!

## ✨ Key Features

### 🌙 Moon Phase Tracking
- View current moon phase with beautiful emoji visualization
- Illumination percentage display with progress bar
- Real-time calculations based on astronomical algorithms
- Support for any date in history and future

### 📅 Interactive Calendar
- Browse any month and year
- See moon phases for each day
- Navigate smoothly between months
- Tap any date to see detailed information
- Highlights today's date with special styling

### 📊 Detailed Moon Information
- Moon phase name and classification
- Precise illumination percentage
- Days since new moon
- Lunar cycle timeline with all 8 phases
- Julian day number
- Complete lunar cycle information

### 🗓️ Cultural Lunar Festivals
Each market shows local lunar festivals:

**Japan (日本)**
- お月見 (Otsukimi) - Autumn moon viewing on 8th lunar month, 15th day
- 十三夜 (13th Moon) - Second autumn celebration
- お正月 (New Year) - 1st lunar month, 1st day

**Korea (한국)**
- 추석 (Chuseok) - Harvest festival on 8th lunar month, 15th day
- 설날 (Lunar New Year) - 1st lunar month, 1st day
- 단오 (Dano) - Spring renewal on 5th lunar month, 5th day

**China (中国)**
- 中秋节 (Mid-Autumn) - Family reunion on 8th lunar month, 15th day
- 春节 (Lunar New Year) - 1st lunar month, 1st day
- 端午节 (Dragon Boat Festival) - 5th lunar month, 5th day
- 清明节 (Qingming) - Ancestor honoring on 3rd lunar month, 3rd day

**India (भारत)**
- होली (Holi) - Festival of colors on 3rd lunar month
- दिवाली (Diwali) - Festival of lights on 10th lunar month, 15th day
- पूर्णिमा (Purnima) - Auspicious full moon days
- नवरात्रि (Navratri) - 9-night Goddess celebration on 7th lunar month

### 📍 Location-Based Features
- Requests location permission on first launch
- Displays current location at top of app
- Enables location-specific lunar event calculations
- Perfect for Singapore and all Asian markets

### 🌐 Multi-Language Support
- Click the language icon (🌐) in the top right
- Instantly switch between 5 languages
- All text, festivals, and descriptions translate dynamically
- Localized app names for each market:
  - Moon Calendar (English)
  - ムーンカレンダー (Japanese)
  - 달 달력 (Korean)
  - 月亮日历 (Chinese)
  - चंद्र कैलेंडर (Hindi)

## 📱 Installation

### Prerequisites
- Flutter SDK 3.10.7 or higher
- Dart SDK
- Android Studio with Android SDK or physical device
- iOS requires Xcode installation (for iOS)

### Setup

1. Navigate to the project directory:
```bash
cd moon_calendar
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the app:
```bash
flutter run
```

## 📁 Project Structure

```
lib/
├── main.dart                      # App entry point with localization support
├── screens/
│   ├── home_screen.dart           # Main screen with current moon phase
│   ├── calendar_screen.dart       # Calendar view with festival markers
│   └── details_screen.dart        # Detailed lunar information
├── utils/
│   ├── moon_calculator.dart       # Astronomical moon phase calculations
│   ├── location_service.dart      # Location permission & detection
│   ├── app_strings.dart           # Translation strings (5 languages)
│   ├── app_localization.dart      # Localization service
│   └── lunar_festivals.dart       # Cultural festival data
└── widgets/
    └── language_switcher.dart     # Language selection dialog
```

## 🛠 Technologies Used

- **Flutter**: UI framework for cross-platform development
- **Dart**: Programming language
- **Material Design 3**: Modern UI design system
- **geolocator**: Location services
- **geocoding**: Address/location reverse geocoding
- **intl**: Internationalization and localization
- **Astronomical Algorithms**: Based on Jean Meeus' calculations

## 🌙 How It Works

### Moon Phase Calculations
The app uses sophisticated astronomical algorithms to accurately calculate moon phases:

- **Julian Day Conversion**: Converts dates to Julian Day Numbers
- **Lunar Cycle**: Uses the average lunar month (29.53 days)
- **Reference Date**: Known new moon on January 6, 2000
- **Illumination**: Calculated using cosine function for accuracy

```
illumination = (1 - cos(2π × position_in_cycle)) / 2 × 100%
```

### Festival Mapping
Lunar festivals are mapped to lunar calendar dates (month/day) based on traditional calculations for each culture. The app automatically marks these days on the calendar with special emoji indicators.

## 📊 Moon Phase Information

The app displays 8 lunar phases:
- 🌑 New Moon (0% illumination)
- 🌒 Waxing Crescent (1-25%)
- 🌓 First Quarter (26-50%)
- 🌔 Waxing Gibbous (51-75%)
- 🌕 Full Moon (100% illumination)
- 🌖 Waning Gibbous (75-100%)
- 🌗 Last Quarter (50-75%)
- 🌘 Waning Crescent (25-50%)

## 🎯 Supported Platforms

- ✅ Android (5.0+)
- ✅ iOS (11.0+)

## 🚀 Build for Production

### Android APK
```bash
flutter build apk --release
```

### iOS
```bash
flutter build ios --release
```

## 📝 Localization Details

### Language Switching
Users can switch languages at any time using the language button (🌐) in the top right corner of the home screen.

### Festival Display
- Festivals appear as emoji indicators on the calendar
- Tap on any festival date to see full details
- Festival information is displayed in the selected language
- Each culture's important dates are clearly marked

## 🔒 Permissions

### Android
- `ACCESS_FINE_LOCATION` - For precise location detection
- `ACCESS_COARSE_LOCATION` - For approximate location

### iOS
- `NSLocationWhenInUseUsageDescription` - Required for location services
- `NSLocationAlwaysAndWhenInUseUsageDescription` - For continuous location access

## 🎨 UI/UX Features

- **Dark Theme**: Designed for nighttime viewing (perfect for moon watching)
- **Beautiful Gradients**: Cyan and blue color scheme
- **Responsive Layout**: Works on all screen sizes
- **Smooth Animations**: Intuitive transitions
- **Accessibility**: Clear text labels in all languages

## 📚 Future Enhancements

- 🌑 Lunar eclipse predictions
- 🌊 Tide information integration
- 🔔 Push notifications for full moons
- 📊 Historical moon phase data
- 🌍 Support for additional languages
- 🎵 Cultural music and stories for each festival
- 📸 Beautiful moon phase photography
- 🌙 Custom lunar event reminders

## 🤝 Market-Specific Features

### Singapore Support
Perfect for Singapore with:
- Location detection for Singapore coordinates
- Support for local lunar celebrations
- Chinese, Indian, and global lunar festivals
- Multi-language support matching Singapore's diversity

## 📖 Learn More

- [Flutter Documentation](https://flutter.dev)
- [Dart Documentation](https://dart.dev)
- [Material Design 3](https://material.io/design)
- [Astronomical Algorithms by Jean Meeus](https://en.wikipedia.org/wiki/Astronomical_algorithms)

## 📄 License

This project is open source and available under the MIT License.

## 👨‍💻 Contributing

Contributions are welcome! Feel free to submit issues or pull requests.

---

**Happy lunar tracking across the globe!** 🌙✨🌍

Made with ❤️ for lunar enthusiasts worldwide



## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
