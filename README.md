# QuizZeit


<img src="https://github.com/user-attachments/assets/04617ca7-3d8e-4209-b1ed-a9eb66e01156" alt="IMG_0240" width="300">
<img src="https://github.com/user-attachments/assets/d803fd2d-014c-4b60-b8a9-87f2a22dfa1d" alt="IMG_0241" width="300">
<img src="https://github.com/user-attachments/assets/ac0ac000-a2e0-45d5-90f7-738b3d893a00" alt="IMG_0242" width="300">
<img src="https://github.com/user-attachments/assets/4a47f952-d910-457d-b5e8-474a9b052799" alt="IMG_0243" width="300">
<img src="https://github.com/user-attachments/assets/ae0f9440-6962-4170-a0b3-dbaf95187123" alt="IMG_0246" width="300">
<img src="https://github.com/user-attachments/assets/6e42ab5b-8612-40da-bff2-9101cc6b6f63" alt="IMG_0247" width="300">





## Overview

**QuizZeit** is an iOS application designed to enhance language learning through interactive and level-based vocabulary quizzes. 
With a clean user interface and simple navigation, QuizZeit makes learning new words engaging and effective. The app is currently 
under development and includes features for individual learning, with plans for multiplayer and grammar-based quizzes in future updates.

## Features

* **Level-Based Vocabulary Quizzes:** Test your vocabulary knowledge with level-based quizzes (A1, A2, B1).

* **Results Summary:** At the end of the quiz, users can review their scores and detailed question breakdowns.


## In Development
* **Multiplayer Mode:** Real-time quiz battles with other players (currently under development, shows a placeholder alert).
* **Grammar Quizzes:** Fill-in-the-blank style quizzes covering topics like grammatical cases.
* **Firebase Integration:**
  * User Authentication with Google Sign-In and Apple Sign-In integration to allow personalized user accounts.
  * Firestore for storing user quiz history and other user data.

## Architecture
The app follows a **Model-View-Controller (MVC)** architecture for simplicity and maintainability.
### Key Components 
* **Controllers:**
  * **ViewController:** Manages the main menu and navigation.
  * **CategoryViewController:** Handles category selection for Vocabulary and Grammar quizzes.
  * **QuizViewController:** Manages quiz flow, user interactions, and updates the view with questions and feedback.
  * **ResultsViewController:** Displays quiz results and a detailed summary of user answers.
* **Models:**
  * **QuizDataManager:** Handles JSON parsing for question data, tracks correct/incorrect answers, and stores progress locally using UserDefaults.
* **Views:**
  * **Storyboards:** The app’s user interface is designed using Storyboards (Main.storyboard, LaunchScreen.storyboard) to ensure clean navigation and fast prototyping.
## Technologies Used 
* **Swift:** Primary programming language for the app.
* **UIKit:** Framework for building the user interface.
* **JSON Parsing:** Loads questions dynamically based on the selected level.
* **UserDefaults:** Stores user progress locally (e.g., correct and incorrect answers).
* **Firebase:** For multiplayer functionality and real-time database integration.
* **MVC Architecture:** Organizes the app into Models, Views, and Controllers for easy management.
