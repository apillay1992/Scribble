# Option 1: Direct command
echo '# 📝 Scribble - Flutter Notes App

A beautiful, modern notes application built with Flutter and Firebase. Create, store, and manage your notes with a clean and intuitive interface.

## ✨ Features

- 🔐 **Secure Authentication**
    - Email/password authentication using Firebase Auth
    - Persistent login state
    - Secure user data isolation

- 💾 **Cloud Storage**
    - Automatic cloud syncing with Firestore
    - Real-time updates
    - Secure data storage

- 📱 **Clean UI/UX**
    - Material Design 3
    - Purple theme with consistent styling
    - Responsive layout
    - Smooth animations

- ✏️ **Note Management**
    - Create and edit notes
    - Delete notes with confirmation
    - View note history
    - Rich text support

## 📱 Screenshots

<div style="display: flex; justify-content: space-between;">
  <img src="assets/Screenshot_20241116_052250.jpg" width="200" alt="Login Screen"/>
  <img src="assets/Screenshot_20241116_052304.jpg" width="200" alt="Empty Home"/>
  <img src="assets/Screenshot_20241116_052401.jpg" width="200" alt="Notes List"/>
  <img src="assets/Screenshot_20241116_052417.jpg" width="200" alt="Add Note"/>
</div>

## 🚀 Getting Started

### Prerequisites

- Flutter (latest version)
- Firebase account
- Android Studio / VS Code

### Installation

1. Clone the repository
```bash
git clone https://github.com/apillay1992/Scribble.git

Install dependencies

bashCopyflutter pub get

Configure Firebase:

Create a new Firebase project
Enable Authentication and Cloud Firestore
Add your Firebase configuration files:

google-services.json for Android
GoogleService-Info.plist for iOS




Run the app

bashCopyflutter run
🏗️ Architecture
The app follows a clean architecture pattern:

Models: Data structure definitions
Repositories: Data handling layer
ViewModels: Business logic
UI: Presentation layer

🛠️ Built With

Flutter - UI framework
Firebase - Backend services
Provider - State management
Firebase UI Auth - Authentication UI

📄 License
This project is licensed under the MIT License - see the LICENSE file for details.' > README.md