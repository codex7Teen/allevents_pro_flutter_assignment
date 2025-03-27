# AllEvents Pro

AllEvents Pro is a cross-platform event listing mobile application developed as an assignment for AllEvents. This app enables users to explore event categories, browse event listings in multiple views, and open event details within an in-app WebView.

## Features
- **Google Authentication**: Users can log in using Google, powered by Firebase Authentication.
- **Event Categories**: Displays event categories fetched from a remote API.
- **Event Listing**: Fetches and displays events dynamically based on the selected category.
  - Supports both **List View** and **Grid View** with a toggle button.
- **In-App WebView**: Opens event URLs inside the app instead of redirecting to an external browser.
- **Responsive UI**: Ensures a seamless experience across different screen sizes.
- **Shimmer Effect**: Improves user experience with loading animations.
- **Smooth Animations**: Enhances UI interactions.

## Tech Stack
- **Flutter**: Cross-platform mobile development.
- **Provider**: State management.
- **GoRouter**: Route management.
- **Dio**: Efficient API handling and network requests.
- **Firebase Authentication**: Secure Google login.

## Installation
1. Clone the repository:
   ```sh
   git clone https://github.com/codex7Teen/allevents_pro_flutter_assignment
   ```
2. Navigate to the project directory:
   ```sh
   cd allevents-pro
   ```
3. Install dependencies:
   ```sh
   flutter pub get
   ```
4. Run the app:
   ```sh
   flutter run
   ```

## API Endpoints
- **Categories API**: Fetches event categories.
- **Events API**: Fetches events based on the selected category.

## Task Requirements Implemented
✔ Design a cross-platform Event Listing mobile app
✔ Implement Google login (mandatory)
✔ Display event categories from API
✔ Fetch and display events based on selected category
✔ Toggle between List View and Grid View
✔ Open event URLs in an in-app WebView
✔ Ensure responsiveness and mobile-friendliness

## License
This project is for assignment purposes only and is not meant for commercial use.

---

Developed by **Dennis**.

