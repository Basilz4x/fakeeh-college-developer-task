# Mini Helpdesk Ticketing System - Fakeeh College

## Overview

This project is a modern, full-stack web application built to fulfill the requirements of the Fakeeh College for Medical Sciences developer task. It functions as a streamlined internal helpdesk, enabling staff members to submit and track support tickets, while providing administrators with the tools to manage and resolve these requests efficiently.

The application is built with a focus on professional software architecture, including a clear separation of concerns (Clean Architecture), robust state management, and layered security, ensuring the final product is both functional and maintainable.

---

## 🚀 Live Deployment

**Live Application Link:** [**https://courageous-genie-2815fd.netlify.app**]

**Public GitHub Repository:** [**https://github.com/Basilz4x/fakeeh-college-developer-task**]

---

## ✨ Features

* **Secure Role-Based Authentication:** Login system for 'Admin' and 'Staff' roles.
* **Ticket Creation & Replies:** All users can create tickets and add replies in a comment thread.
* **Role-Based Views:** Admins see all tickets, while Staff can only view their own submitted tickets.
* **Database-Level Security:** Row Level Security (RLS) policies ensure users can only access permitted data.
* **Admin Ticket Management:** Admins can change a ticket's status to "Closed" or re-open it.
* **Server-Side Search:** A fast and secure search functionality to find tickets by title.
* **Light & Dark Mode:** Instantly switch between themes for user comfort.
* **Robust Error Handling:** A full-stack pipeline handles errors gracefully, from custom JSON responses in PostgreSQL RPCs to specific exceptions in the Flutter app.

---

## 🏗️ Project Structure

The project is organized using Clean Architecture principles to ensure a clear separation of concerns between the UI, business logic, and data layers.

### Flutter Project Structure
```bash
├── assets
│   └── images
│
├── lib
│   ├── core
│   │   ├── constants
│   │   ├── enums
│   │   ├── exceptions
│   │   ├── router
│   │   └── themes
│   │
│   ├── data
│   │   ├── models
│   │   └── repositories
│   │
│   ├── domain
│   │
│   ├── presentation
│   │   ├── controllers
│   │   ├── pages
│   │   └── widgets
│   │
│   └── main.dart
│
├── pubspec.yaml
```

### Database Schema
```bash
├── app_users
│   ├── id            # UUID, PK, FK to auth.users
│   ├── email         # TEXT, UNIQUE
│   └── role          # user_role ENUM: 'admin' | 'staff'
│
├── tickets
│   ├── id            # UUID, PK
│   ├── reference_id  # TEXT, UNIQUE
│   ├── created_by    # UUID, FK to app_users.id
│   ├── title         # TEXT
│   ├── description   # TEXT
│   └── status        # ticket_status ENUM: 'Open' | 'Closed'
│
└── replies
    ├── id            # UUID, PK
    ├── ticket_id     # UUID, FK to tickets.id
    ├── user_id       # UUID, FK to app_users.id
    └── content       # TEXT
```

### Database Functions (RPCs)

Key business logic is encapsulated in PostgreSQL functions to ensure security and data integrity.

| Function Name                  | Description                                      |
| :----------------------------- | :----------------------------------------------- |
| `create_ticket`                | Creates a new ticket for the current user.       |
| `create_reply`                 | Adds a reply to a ticket as the current user.    |
| `update_ticket_status`         | Admin-only. Changes a ticket's status.           |
| `get_tickets`                  | Intelligently fetches tickets based on the caller's role. |
| `get_ticket_by_id`             | Fetches a single ticket with creator details.    |
| `get_replies_for_ticket`       | Fetches all replies for a ticket with author details. |
| `search_tickets`               | Performs a secure, role-based search.            |
| `generate_ticket_reference_id` | (Trigger Function) Automatically run on insert.  |

---

## 🛠️ Technologies Used

* **Frontend:** Flutter Web
* **State Management:** Flutter Riverpod 2.0
* **Backend & Database:** Supabase (PostgreSQL, Auth, RPC Functions)
* **Routing:** go_router
* **Theming:** flex_color_scheme
* **Environment Variables:** flutter_dotenv

---
## ⚙️ Setup and How to Run Locally

To run this project on your local machine, please follow these steps:

**1. Prerequisites:**
   - Ensure you have [Flutter](https://flutter.dev/docs/get-started/install) installed on your system.
   - Enable web support for Flutter: `flutter config --enable-web`

**2. Clone the Repository:**
   ```bash
   git clone [INSERT YOUR GITHUB REPO LINK HERE]
   cd [YOUR-PROJECT-FOLDER-NAME]
   ```

**3. Set Up Environment Variables:**

- In the root of the project, create a file named .env
- Add your Supabase URL and Anon Key to this file:
```bash
SUPABASE_URL=[https://your-project-url.supabase.co](https://your-project-url.supabase.co)
SUPABASE_ANON_KEY=your-long-anon-key-goes-here
```
- In pubspec.yaml, ensure .env is listed under flutter: -> assets:.

**4. Install Dependencies:**
Run the following command in your terminal:
```bash
flutter pub get
```

**5. Run the Application:**
Start the application on a Chrome browser:
```bash
flutter run -d chrome
```
---

## 🔑 Test Credentials

You can use the following credentials to test the application:

| Role       | Email                 | Password  |
|------------|-----------------------|-----------|
| 👨‍💻 Admin  | admin@fakeeh.edu.sa   | admin123  |
| 👤 Staff   | user1@fakeeh.edu.sa   | pass123   |
| 👤 Staff   | user2@fakeeh.edu.sa   | pass123   |
| 👤 Staff   | user3@fakeeh.edu.sa   | pass123   |
| 👤 Staff   | user4@fakeeh.edu.sa   | pass123   |
| 👤 Staff   | user5@fakeeh.edu.sa   | pass123   |









