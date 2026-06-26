# GPS Tracking System App 🚗📍

A real-time GPS tracking application built with Flutter and Firebase, featuring dual-interface simulation for both Users and Drivers with OpenStreetMap integration.

---

## 📋 Table of Contents
1. [Platform Type](#platform-type)
2. [Tools, Technologies & Libraries](#tools-technologies--libraries)
3. [Project Setup & Running Instructions](#project-setup--running-instructions)
4. [User Interface (UI) Explanation](#user-interface-ui-explanation)
5. [Driver Interface Explanation](#driver-interface-explanation)
6. [Vehicle-Driver Connection Logic](#vehicle-driver-connection-logic)
7. [Live / Simulated Tracking Mechanics](#live--simulated-tracking-mechanics)
8. [Prototype Limitations](#prototype-limitations)

---

## 📱 Platform Type
- **Platform:** Mobile Application (App-based)
- **Supported OS:** Android & iOS
- **Design Standard:** Responsive UI via `flutter_screenutil`

---

## 🛠️ Tools, Technologies & Libraries Used

### Backend & Core
- **Flutter SDK:** Cross-platform framework.
- **Firebase Auth:** Driver/User secure authentication.
- **Cloud Firestore:** Real-time NoSQL database for tracking streams.

### Packages & Libraries
- `get` (GetX): State management and routing.
- `flutter_map` & `latlong2`: OpenStreetMap (OSM) rendering without costly API keys.
- `flutter_screenutil`: UI responsiveness for multiple device screen sizes.

---

## 🚀 Project Setup & Running Instructions

### Prerequisites
- Flutter SDK installed on your system.
- Android Studio / Xcode configured.
- A physical device or emulator.

### Setup Steps
1. **Clone the repository:**
   ```bash
   git clone [https://github.com/byteAnik/demo_project.git)
   cd your-repo-name
