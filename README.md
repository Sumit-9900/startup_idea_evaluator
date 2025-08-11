# 🚀 Startup Idea Evaluator

The **Startup Idea Evaluator** is a Flutter-based mobile application that helps users store, rate, sort, and share startup ideas.  
It’s designed for aspiring entrepreneurs, innovators, and product thinkers to quickly capture ideas, evaluate them, and get feedback.

---

## 📜 App Description
This app allows you to:
- Save your startup ideas with **title, tagline, description, rating, and votes**.
- Toggle between **Dark Mode** and **Light Mode**, with the preference stored locally.
- View a **Leaderboard** showcasing the top 5 ideas based on rating.
- Sort ideas based on **rating** or **votes**.
- Vote for ideas, with safeguards to ensure each user can only vote once per idea.
- Share ideas via social apps or copy them to the clipboard.
- Swipe to delete ideas easily.
- Persist theme choice and voting history locally using `SharedPreferences`.
- Use **MockAPI.io** as the backend for storing, fetching, updating votes, and deleting ideas remotely.

---

## 🛠 Tech Stack
- **Frontend:** [Flutter](https://flutter.dev/) (Dart)
- **State Management:** [Provider](https://pub.dev/packages/provider)
- **Local Storage:** [SharedPreferences](https://pub.dev/packages/shared_preferences) for theme preference and tracking voted ideas.
- **Backend API:** [MockAPI.io](https://mockapi.io/) for remote CRUD operations on ideas.
- **Dependency Injection:** [get_it](https://pub.dev/packages/get_it)
- **Sharing:** [share_plus](https://pub.dev/packages/share_plus)
- **Clipboard:** `flutter/services.dart`

---

## ✨ Features Implemented
- **Add & Delete Ideas** – Store and manage startup ideas locally and remotely.
- **Theme Toggle** – Switch between Light and Dark themes, with preference saved locally.
- **Leaderboard** – Displays the top 5 highest-rated ideas.
- **Sorting** – Sort the ideas list by rating or votes.
- **Voting System** – Upvote or remove upvote for ideas, with one vote per idea per user (tracked via local voter IDs).
- **Swipe Actions**  
  - Swipe right → Delete idea.
- **Clipboard Support** – Copy idea details with one tap.
- **Share Ideas** – Share idea details via installed social media or messaging apps.
- **Expandable Descriptions** – Expand/collapse long idea descriptions.
- **Remote Persistence** – Data synced with MockAPI.io for storage, retrieval, and updates.
- **Local Persistence** – Theme preferences and voted idea IDs stored using SharedPreferences.

---

## 🏃 How to Run Locally

### 1️⃣ Clone the repository

```bash
git clone https://github.com/Sumit-9900/startup_idea_evaluator.git
cd startup_idea_evaluator
```

### 2️⃣ Install dependencies

```bash
flutter pub get
```

### 3️⃣ Run the app

```bash
flutter run
```

---

## 👥 Contributing

Contributions are welcome! Feel free to open issues or submit pull requests.
