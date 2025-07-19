# Football Info App

A sleek and informative **Football Info App** built with Flutter. This app provides fixtures, team and player details with a clean UI, modern architecture, and efficient state management using GetX. It supports dynamic search, responsive UI elements, and is ready to scale for future features like match stats or leagues.

---

## Features

- View list of all teams
- View player squad by team
- View detailed profile for each player
- View fixtures
- Search players with **debounced** input
- Load more players with **infinite scroll**
- Pull-to-refresh supported on player list
- Cached images via `cached_network_image`
- Responsive UI with adaptive theming
- Clean architecture (controllers, bindings, routes, models)

---

## Screens Overview

### 1. Home Screen
- Displays a simple dashboard with:
  - Sections (Teams, All Players, Top Scorers, Top Assists and Fixtures)
  - Quick navigation to teams or all player views

### 2. Teams List
- Displays all teams
- Each team navigates to their squad

### 3. Player Squad Screen
- Lists players by selected team
- Each tile shows:
  - Player image (cached)
  - Name, position, jersey number, and age

### 4. All Players Screen
- Lists all available players
- Features:
  - Debounced search bar
  - Infinite scroll with loading indicator
  - Pull-to-refresh
  - Player cards with name, number, position, age

### 5. Player Profile Screen
- Displays detailed player info:
  - Name
  - Position
  - Number
  - Age
  - Team
  - Nationality
  - Biography or additional metadata (if available)

### 6. Fixtures Screen
- Displays upcoming and past match fixtures
- Each fixture includes:
  - Competing teams with logos
  - Match date and time
  - Match status (Scheduled, Live, Finished)

---

## Tech Stack

- **Flutter** – UI framework
- **GetX** – State management & navigation
- **get_storage** – Local storage
- **Dio** – Network, API Calling
- **cached_network_image** – Efficient image loading
- **intl** – Date formatting, internationalization
- **Modular Architecture** – Organized in:
  - `bindings`
  - `controllers`
  - `models`
  - `views`
  - `routes`
  - `widgets`

---

## Architecture Notes

- **State Management:** All screens use `GetX` for reactive state and controller bindings.
- **Routing:** Routes are defined centrally with named route navigation (`Get.toNamed()`).
- **Data Layer:** Using API Football.
- **Debounce:** Search operations use debounced input to reduce unnecessary calls and improve UX.
- **Image Handling:** All player photos are cached with error fallbacks for broken URLs.