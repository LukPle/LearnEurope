# Learn Europe

Welcome to your Flutter project! This README will guide you through setting up and running your Flutter application. Follow the instructions below to get started.

## Table of Contents
- [Information about the app](#information-about-the-app)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Running the App](#running-the-app)

## Information about the App

**Learn Europe - Explore Europe in various categories**
A mobile app for Android and iOS developed with Flutter

## Prerequisites

Before you can start with Flutter, ensure you have the following installed:

1. **Flutter SDK 3.19.6**: Download and install Flutter from the official [Flutter website](https://flutter.dev/docs/get-started/install).
[Download MacOS ARM](https://storage.googleapis.com/flutter_infra_release/releases/stable/macos/flutter_macos_arm64_3.19.6-stable.zip), [Download Windows x64](https://storage.googleapis.com/flutter_infra_release/releases/stable/windows/flutter_windows_3.19.6-stable.zip)
2. **Dart SDK**: This comes bundled with the Flutter SDK.
3. **Android Studio** or **Visual Studio Code**: These are the recommended IDEs for Flutter development.
4. **Android SDK**: Necessary for building and running Android apps.
5. **Xcode**: Required for building and running iOS apps (macOS only).

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

## Running the App

To run the app on an emulator or physical device:

1. **Start an Emulator** (if you don't have a physical device connected):
    - **Android**: Start the Android emulator from Android Studio or use a command line tool.
    - **iOS**: Start the iOS simulator from Xcode (macOS only).

2. **Run the App**:
    ```sh
    flutter run
    ```
