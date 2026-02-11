# Ovula - Production-Ready Ovulation Calculator

Ovula is a premium, production-ready Flutter application designed to track and predict menstrual cycles, ovulation, and fertile windows with high precision. Built with Clean Architecture and modularity in mind, it provides a seamless and elegant user experience.

## 🚀 Key Features

- **Home Screen**: Personalized greeting, weather preview, horizontal date selector, and daily health insights.
- **Estimate Screen**: Advanced cycle visualization using a custom circular painter, phase breakdowns (Period, Fertile, PMS), and a dynamic body temperature graph.
- **Analysis Screen**: Detailed comparative statistics between current and previous cycles, phase duration indicators, and bar chart comparisons.
- **Advanced Calculation Engine**: Uses average cycle length and variance to provide prediction confidence percentages.
- **Global Theme System**: Easily reskin the entire app via a centralized `AppTheme` and `CycleThemeExtension`. Supports Light and Dark modes.
- **Local Storage**: Securely stores periods, symptoms, temperatures, and notes using Hive.
- **Premium Animations**: Smooth fade-in, scale, and progress animations for a high-end feel.

## 🛠 Tech Stack

- **Flutter 3.x**: Latest stable version.
- **Riverpod**: Robust state management.
- **GoRouter**: Declarative navigation.
- **Freezed**: Type-safe data models and unions.
- **Hive**: Blazing fast local database.
- **fl_chart**: Beautiful and interactive graphs.
- **Google Fonts**: Premium typography (Poppins).
- **Intl**: Internationalized date and number formatting.

## 📁 Project Structure

```text
lib/
├── core/         # Theme, constants, utils, and extensions
├── data/         # Models (Freezed), Repositories (Hive), and Datasources
├── domain/       # Entities and Calculation Services (Usecases)
├── presentation/ # Screens, Widgets, and Riverpod Providers
├── router/       # Navigation configuration (GoRouter)
└── main.dart     # App entry point
```

## ⚙️ Setup Instructions

### Prerequisites
- Flutter SDK (Latest Stable)
- Dart SDK

### Installation
1. **Clone the repository**:
   ```bash
   git clone <repository-url>
   ```
2. **Install dependencies**:
   ```bash
   flutter pub get
   ```
3. **Generate code**:
   Generate Freezed and Hive models:
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```
4. **Run the app**:
   ```bash
   flutter run
   ```

## 🧪 Testing
Run unit tests to verify calculation logic:
```bash
flutter test
```

## 🛡 Medical Disclaimer
This app provides estimates and is not a medical diagnostic tool. It should not be used for birth control or as a substitute for professional medical advice.
