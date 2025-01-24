# QuizZeit
---
## Overview

**QuizZeit** is an iOS application designed to enhance language learning through interactive and level-based vocabulary quizzes. 
With a clean user interface and simple navigation, QuizZeit makes learning new words engaging and effective. The app is currently 
under development and includes features for individual learning, with plans for multiplayer and grammar-based quizzes in future updates.

## Features

* **Level-Based Vocabulary Quizzes:** Test your vocabulary knowledge with level-based quizzes (A1, A2, B1).

* **Results Summary:** At the end of the quiz, users can review their scores and detailed question breakdowns.

* **Firebase Integration:**
  * User Authentication with Google Sign-In and Apple Sign-In integration to allow personalized user accounts.
  * Firestore for storing basic user data.


## In Development
* **Multiplayer Mode:** Real-time quiz battles with other players (currently under development, shows a placeholder alert).
* **Grammar Quizzes:** Fill-in-the-blank style quizzes covering topics like grammatical cases.
* **Firebase Integration:**
  * Real-time multiplayer data management and synchronization for quiz sessions.

## Architecture
The app follows a **Model-View-Controller (MVC)** architecture for simplicity and maintainability.
### Key Components 
* **Controllers:**
Manage the app's logic and user interactions, such as authentication, quiz flow, and tab bar navigation. Key controllers include:
  * **Auth:** Handles user authentication (SignIn, SignUp, Profile).
  * **Quiz:** Manages the quiz flow, category selection, and results display.
  * **Words:** Displays and manages the word list.
* **Models:**
  * **AuthModel:** Manages user authentication data.
  * **QuizDataManager:** Handles JSON parsing for question data, tracks correct/incorrect answers, and stores progress locally using UserDefaults.
* **Views:**
  * Designed using Storyboards (Main.storyboard, LaunchScreen.storyboard) for intuitive navigation and UI prototyping.
## Technologies Used 
* **Swift:** Primary programming language for the app.
* **UIKit:** Framework for building the user interface.
* **JSON Parsing:** Loads questions dynamically based on the selected level.
* **UserDefaults:** Stores user progress locally (e.g., correct and incorrect answers).
* **Firebase:** For user auth and multiplayer functionality, real-time database integration.
* **MVC Architecture:** Organizes the app into Models, Views, and Controllers for easy management.

## Screenshots

<img src="https://github.com/user-attachments/assets/4c73cccc-daae-4ebe-ad3f-2f2fc5c59b04" alt="IMG_0278" width="300">
<img src="https://github.com/user-attachments/assets/0f53c999-320a-489e-9ceb-bacb729b63a4" alt="IMG_0280" width="300">
<img src="https://github.com/user-attachments/assets/327df077-ee7a-4c8d-b9e0-3fd00223ec6c" alt="IMG_0279" width="300">
<img src="https://github.com/user-attachments/assets/016f5b4d-92d6-417d-bda1-01ff037e2c4d" alt="IMG_0271" width="300">
<img src="https://github.com/user-attachments/assets/610e3651-ce56-4cb3-90f9-a4d1b78f6202" alt="IMG_0272" width="300">
<img src="https://github.com/user-attachments/assets/b0eb744c-56c3-4606-a958-5acbfb5d0cbb" alt="IMG_0275" width="300">
<img src="https://github.com/user-attachments/assets/e586ea79-6518-42e3-8991-ccce89b1d94d" alt="IMG_0273" width="300">
<img src="https://github.com/user-attachments/assets/54a0783c-574c-4b6b-9046-0875f9a20838" alt="IMG_0276" width="300">
<img src="https://github.com/user-attachments/assets/ed4aa47c-5b05-4a90-b521-c9653aed734a" alt="IMG_0277" width="300">
