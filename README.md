# 🏅 Sports App (iOS - Swift)

This is a sports-focused iOS application built using Swift and UIKit. The app utilizes [TheSportsDB API](https://allsportsapi.com/) to fetch and display information about various sports,
leagues, events, and teams. It also features Core Data for managing user favorites and follows modern iOS development practices including MVC design patterns, unit testing, and an elegant, responsive UI.

## 📱 Features

### 🏠 Main Interface
- **Tab 1: All Sports**
  - Displays all available sports in a `UICollectionView` (2 items per row).
  - Each item includes:
    - Sport thumbnail (`strSportThumb`)
    - Sport name (`strSport`)
  - Navigation to **Leagues ViewController** on sport selection.

- **Tab 2: Favorite Leagues**
  - Uses **Core Data** to persist user's favorite leagues.
  - UI similar to Leagues screen.
  - If user is offline and clicks an item, shows a “No Internet” alert.
  - If online, navigates to **LeagueDetails ViewController**.

### 🏆 Leagues ViewController
- A `UITableViewController` titled **Leagues**.
- Each cell includes:
  - Circular league badge (`strBadge`)
  - League name (`strLeague`)
- Tap to navigate to **LeagueDetails ViewController**.

### 📋 LeagueDetails ViewController
- Add/remove league from favorites via top-right button.
- Divided into three sections:
  1. **Upcoming Events**:
     - Horizontal `UICollectionView`
     - Displays event name, date, time, and team images.
  2. **Latest Events**:
     - Vertical `UICollectionView`
     - Displays team names, scores, date, time, and images.
  3. **Teams**:
     - Horizontal `UICollectionView`
     - Circular team logos
     - Tap navigates to **TeamDetails ViewController**

### 👥 TeamDetails ViewController
- Shows essential team details in an elegant layout.
- UI design is flexible but should be visually appealing.

## ⚙️ Technologies Used

- **Language:** Swift
- **Architecture:** MVC
- **UI Framework:** UIKit
- **Networking:** [Alamofire](https://github.com/Alamofire/Alamofire)
- **Local Storage:** Core Data
- **API:** [TheSportsDB](https://allsportsapi.com/)
- **Testing:** Unit Tests included
- **Design Patterns:** Applied as per feature needs

##👥 Team Members

- [Nada Ali](https://github.com/nada263204)
- [Eslam El-Sayed](https://github.com/eslamelsayed010)

##📋 Project Board
Track our progress on [Trello](https://trello.com/b/QlvLYev5/sports-ios-project)

## 🚀 Getting Started

1. Clone this repo:
   ```bash
   git clone https://github.com/eslamelsayed010/Sport-App.git

