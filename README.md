# Learn Europe
<br>

## Table of Contents
- [About](#about)
- [Contributors](#contributors)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Running the App](#running-the-app)
<br>

## About

**Learn Europe - Explore Europe in various categories**<br>
A mobile app for Android and iOS developed with Flutter
<br>
<br>

**Main Screens**<br>
<img src="https://github.com/user-attachments/assets/c3e24c4e-7f5b-4076-a71f-b4988a3dab90" alt="home_screen" width="200">
<img src="https://github.com/user-attachments/assets/41f04206-5177-4158-b4d2-3b5320bc0511" alt="categories_screen" width="200">
<img src="https://github.com/user-attachments/assets/7d51240b-ebb4-4270-9d8e-1f8f9d13c041" alt="leaderboard_screen" width="200">
<img src="https://github.com/user-attachments/assets/729a744d-9171-436a-b4fd-f47c1d6ee10f" alt="profile_screen" width="200">

**Quiz and Avatar Selection**<br>
<img src="https://github.com/user-attachments/assets/1104c1ec-b2b5-4c69-aa4d-82f96d5e5ea8" alt="quiz_selection" width="200">
<img src="https://github.com/user-attachments/assets/dab890a1-2d0b-49ed-a4e9-0a63b198e28b" alt="avatar_selection" width="200">

**Quiz Screens**<br>
<img src="https://github.com/user-attachments/assets/630124f5-9ed0-4661-a6bf-20949d0e043f" alt="europe101_quiz" width="200">
<img src="https://github.com/user-attachments/assets/72cf7f61-87b3-4bdf-b35f-b68dd94fb27f" alt="languages_quiz" width="200">
<img src="https://github.com/user-attachments/assets/80b55802-2871-48ab-a84e-e1581cf9d5a9" alt="country_borders_quiz" width="200">
<img src="https://github.com/user-attachments/assets/d7b3b74f-efda-46bd-ad26-9f8673707f67" alt="geo_position_quiz" width="200">
<img src="https://github.com/user-attachments/assets/cdbf997e-296f-4cb8-9544-d285b43c786a" alt="gapped_text_quiz" width="200">
<img src="https://github.com/user-attachments/assets/8a7df8a4-4775-4b73-a08a-165410f0e4f2" alt="hint_dialog" width="200">

<br>

**Item Types**
- Drag and Drop (Europe101)
- Multiple Choice (Languages, Country Borders)
- Geo-Spatial (Geo Position)
- Gapped Text (Coming Soon Category)
<br>

## Contributors

- [Elena Herzog](https://github.com/Ele1234), Asset Design and Content Creation
- [Amiin Najjar](https://github.com/najjar77), Firebase Integration and Management
- [Lukas Plenk](https://github.com/LukPle), App Design and Development
<br>

## Prerequisites

Before you can start with Flutter, ensure you have the following installed:

1. **Flutter SDK 3.19.6**: Download and install Flutter from the official [Flutter website](https://flutter.dev/docs/get-started/install),
[Download MacOS ARM](https://storage.googleapis.com/flutter_infra_release/releases/stable/macos/flutter_macos_arm64_3.19.6-stable.zip), [Download Windows x64](https://storage.googleapis.com/flutter_infra_release/releases/stable/windows/flutter_windows_3.19.6-stable.zip)
2. **Dart SDK**: This comes bundled with the Flutter SDK.
3. **Android Studio** or **Visual Studio Code**: These are the recommended IDEs for Flutter development.
4. **Android SDK**: Necessary for building and running Android apps.
5. **Xcode**: Required for building and running iOS apps (macOS only).
<br>

## Installation

Follow these steps to set up your development environment:

1. **Clone the Repository**:
    ```sh
    git clone https://github.com/LukPle/LearnEurope.git
    cd learn_europe
    ```

2. **Install Dependencies**:
    Run the following command to fetch the dependencies listed in your `pubspec.yaml` file.
    ```sh
    flutter pub get
    ```

3. **Set Up Your Editor**:
    - **Visual Studio Code**: Install the Flutter and Dart plugins from the extensions marketplace.
    - **Android Studio**: Install the Flutter and Dart plugins from the plugins section.
  
4. **Set Up Firebase Integration**:
    - **Firebase CLI**: Get the Firebase CLI from [Google Firebase](https://firebase.google.com/docs/cli).
    - **Set Up Firebase App-Integration**: Follow the instructions on [Firebase for Flutter Instructions](https://firebase.google.com/docs/flutter/setup?platform=ios).
<br>

## Running the App

To run the app on an emulator or physical device:

1. **Start an Emulator** (if you don't have a physical device connected):
    - **Android**: Start the Android emulator from Android Studio or use a command line tool.
    - **iOS**: Start the iOS simulator from Xcode (macOS only).

2. **Run the App**:
    ```sh
    flutter run
    ```
<br>
