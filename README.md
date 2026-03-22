# 📊 Flutter Watchlist App (BLoC Architecture)

A Flutter application that allows users to manage and reorder stock watchlists.
Built with a focus on **clean architecture, scalability, and proper state management using BLoC**.

---

##  Overview

* BLoC for state management
* Clean and modular folder structure
* Theme handling (Light & Dark mode)
* Reorderable lists with smooth UX

---

##  Approach

The main goal was to build a **maintainable and scalable architecture**, rather than just a working UI.

### Key decisions:

* **BLoC Pattern**
  Used to separate business logic from UI, making the app easier to test and extend.

* **Feature-based structure**
  Code is organized by feature (`watchlist`) instead of type, improving readability and scalability.

* **Centralized Theme Management**
  Light and dark themes are defined in a single place and consumed via `ThemeData`.

* **Reusable Widgets**
  Components like buttons and cards are reusable and theme-aware.

---

##  Architecture

The app follows a simplified **BLoC architecture**:

```
UI (Screens / Widgets)
        ↓
     Events
        ↓
      Bloc
        ↓
     States
        ↓
UI Rebuild
```

### Flow:

1. UI triggers an event (e.g., `WatchlistLoadEvent`)
2. Bloc processes logic
3. Emits a new state (`WatchlistLoadedState`)
4. UI rebuilds based on state

---

## 📂 Project Structure

```
lib/
│
├── core/
│   ├── theme.dart                 # App theming (light/dark)
│   └── route.dart                 # Navigation (GoRouter)
│
├── features/
│   └── watchlist/
│       ├── bloc/
│       │   ├── watchlist_bloc.dart
│       │   ├── watchlist_event.dart
│       │   └── watchlist_state.dart
│       │
│       ├── data/
│       │   ├── models/
│       │   │   └── stocks_model.dart
│       │   └── stocks_data.dart
│       │
│       ├── screens/
│       │   ├── watchlist_screen.dart
│       │   └── reorder_screen.dart
│       │
│       └── widgets/
│           ├── list_card_widget.dart
│           └── buttons/
│               ├── primary_button.dart
│               └── secondary_button.dart
```

---

##  Theming Strategy

* Uses `ThemeData` with `ColorScheme`
* Avoids hardcoded colors in widgets
* Supports **system-based theme switching**

### Key Principle:

> UI components rely on `Theme.of(context)` instead of fixed colors

---

##  Features Implemented

*  Display stock watchlist
*  Drag & drop reordering
*  State-driven UI updates (BLoC)
*  Light & Dark mode support
*  Reusable UI components

---

##  Getting Started

### 1. Clone the repository

```
git clone https://github.com/Fahadbinfayaz96/Flutter_WatchList_Bloc.git
cd Flutter_WatchList_Bloc
```

### 2. Install dependencies

```
flutter pub get
```

### 3. Run the app

```
flutter run
```

---

##  Author

**Fahad Bin Fayaz**
Flutter Developer

GitHub: https://github.com/Fahadbinfayaz96

---

##  Conclusion

This project focuses on **code quality, scalability, and real-world practices**, making it a strong foundation for production-level Flutter applications.
