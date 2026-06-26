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

---

## 🎨 Interface & Feature Explanations

### 1. User Interface (UI)
- **Live Tracking View:** Users can see the registered vehicle moving smoothly on a full-screen map interface.
- **Status Panel:** Displays active speeds, signal accuracy, and whether the driver is online.

### 2. Driver Interface
- **Driver Dashboard (`DriverHomeScreen`):** Shows driver profile info, current active vehicle card, and rapid actions.
- **Vehicle Profile (`DriverMyVehicleScreen`):** Fetches registered vehicle details (Type, Number Plate, Sync date) in real-time.
- **Vehicle Controller (`DriverAddVehicleScreen`):** A smooth form with grid/dropdown selection to register new vehicle metrics directly to Firestore.

### 3. How Vehicles are Connected with Drivers
- Vehicles are mapped using a **1:1 relationship via the Driver's Unique User ID (`uid`)** from Firebase Authentication.
- When a driver registers a vehicle, it writes a document inside the `active_vehicles` collection where the **Document ID == Driver UID**. 
- This guarantees efficient querying and absolute unique binding.

### 4. How Live or Simulated Tracking Works
- **State Management:** When the Driver clicks **Start Tracking**, a background simulation timer triggers inside the `DriverHomeController`.
- **Realtime Broadcast:** The controller continuously updates the driver's mock/live latitude, longitude, and speed parameters into Cloud Firestore.
- **Stream Consuming:** On the `LiveTrackingScreen` (both user and driver ends), a `StreamBuilder` listens to that exact document snapshot. As coordinates change, `MapController.move()` smoothly translates the marker across OpenStreetMap.

---

## ⚠️ Prototype Limitations
- **Mock Simulation:** Currently uses simulated lat/lng offsets instead of a continuous background native device GPS sensor stream.
- **No Polyline Routing:** Shows real-time spot markers but does not render underlying routing paths/directions between historical checkpoints yet.
- **Local Authentication Persistence:** Basic implementation; production tokens require structured rotation logic.
