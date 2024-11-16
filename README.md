📝 Scribble - Flutter Notes App
A modern, beautiful notes application built with Flutter and Firebase. Scribble helps you capture and organize your thoughts with a clean, intuitive interface.
✨ Features

🔐 Secure Authentication - Email/password authentication using Firebase Auth
💾 Cloud Storage - All notes are automatically synced with Firebase Cloud Firestore
🎨 Beautiful UI - Clean, modern interface with Material Design 3
📱 Responsive Design - Works seamlessly on both mobile and tablet devices
✏️ Rich Text Editing - Full-featured note editor with title and content support
🔍 Quick Access - Easy to create, edit, and delete notes
🌈 Custom Theme - Beautiful purple theme with consistent styling

📱 Screenshots
<div style="display: flex; justify-content: space-between;">
  <img src="assets/Screenshot_20241116_052250.jpg" width="200" alt="Auth Screen"/>
  <img src="assets/Screenshot_20241116_052304.jpg" width="200" alt="Empty State"/>
  <img src="assets/Screenshot_20241116_052401.jpg" width="200" alt="Add Note"/>
  <img src="assets/Screenshot_20241116_052417.jpg" width="200" alt="Add Note"/>
</div>
🚀 Getting Started
Prerequisites

Flutter (2.0 or higher)
Firebase account
Firebase CLI

Installation

Clone the repository

bashCopygit clone https://github.com/apillay1992/Scribble.git

Install dependencies

bashCopyflutter pub get

Configure Firebase

Create a new Firebase project
Enable Authentication and Cloud Firestore
Download and add your google-services.json (Android) and GoogleService-Info.plist (iOS)
Update Firebase configuration in lib/firebase_options.dart


Run the app

bashCopyflutter run
🏗️ Architecture
The app follows a clean architecture pattern with:

Models: Data classes (NoteModel)
Repositories: Data handling layer (NoteRepository)
ViewModels: Business logic (NoteViewModel)
UI: Presentation layer (screens, widgets)

🛠️ Built With

Flutter - UI framework
Firebase - Backend and Authentication
Provider - State Management
Cloud Firestore - Database

📄 License
This project is licensed under the MIT License - see the LICENSE file for details.
🤝 Contributing
Contributions are welcome! Please feel free to submit a Pull Request.

Fork the Project
Create your Feature Branch (git checkout -b feature/AmazingFeature)
Commit your Changes (git commit -m 'Add some AmazingFeature')
Push to the Branch (git push origin feature/AmazingFeature)
Open a Pull Request

📞 Contact
Ashley Pillay - @apillay1992
Project Link: https://github.com/apillay1992/Scribble