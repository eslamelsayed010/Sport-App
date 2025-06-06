# 🏅 Sports App

A native iOS application that offers comprehensive coverage across **Football, Tennis, Basketball**, and **Cricket**, designed with a smooth and intuitive user experience in mind.

---

## 📲 Features

- 🏆 Displays **leagues**, **teams**, **match results**, and **upcoming fixtures**
- 📁 Grouped **favorite leagues** by sport
- 📄 Detailed **team profiles**
- 📶 Seamless **offline access** with smart connectivity handling
- 🧭 Clean navigation with UIKit components and custom Nib files
- ✅ Smooth and responsive UI built with performance in mind

---

## 🧱 Architecture

The app follows the **MVP (Model-View-Presenter)** architecture to ensure clean separation of concerns and ease of testing and maintenance.

- **Model**: Data entities and API layer
- **View**: UIKit-based reusable components using XIBs/Nib files
- **Presenter**: Handles UI logic and data transformation

---

## 🛠️ Technologies Used

| Technology     | Purpose                          |
|----------------|----------------------------------|
| Swift          | Core programming language        |
| UIKit          | UI development                   |
| Alamofire      | Networking and RESTful API calls |
| Core Data      | Local data persistence           |
| Reachability   | Network status monitoring        |
| Nib Files      | Modular and reusable UI views    |
| XCTest         | Unit testing                     |

---

## 📂 Project Structure (Simplified)
SportApp/
│
├── Models/ # Data models for leagues, teams, matches
├── Views/ # XIBs/Nibs and UI components
├── Presenters/ # Presenter classes for each screen
├── Services/ # API service layer using Alamofire
├── Persistence/ # Core Data setup and management
├── Utils/ # Reachability, constants, helpers
└── AppDelegate.swift # Application entry point

---

## 🎥 Demo

📽️ Watch the full demo on [LinkedIn](https://www.linkedin.com/posts/eslam-elsayed-a3b183264_excited-to-share-a-major-milestone-in-my-activity-7332695726839222272-lIde/?utm_source=share&utm_medium=member_desktop&rcm=ACoAAEDPLg8BBULkCm0f5lZEYq8VEACSXorKZeI)

---

## 👥 Team Members

- [Nada Ali](https://github.com/nada263204)
- [Eslam El-Sayed](https://github.com/eslamelsayed010)

## 📋 Project Board
Track our progress on [Trello](https://trello.com/b/QlvLYev5/sports-ios-project)

## 🚀 Getting Started

### Prerequisites

- Xcode 14+
- iOS 13.0+
- Swift 5+

### Installation

1. Clone the repo:
    ```bash
    git clone https://github.com/eslamelsayed010/Sport-App.git
    cd ios-sport-app
    ```
2. Open `SportApp.xcodeproj` in Xcode
3. Run on a simulator or physical device

---

## ✅ Testing

- Unit tests are implemented using **XCTest**
- Run tests via Xcode → Product → Test or `⌘ + U`

---



