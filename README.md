# Blog API

A RESTful API for a blogging platform built with Flask, supporting user registration, authentication (JWT), and CRUD operations for blog posts. The API uses SQLAlchemy for ORM and SQLite as the default database.

---

## Features
- User registration and login with JWT authentication
- Create, read, update, and delete blog posts
- User-specific blog management
- Search functionality for blog posts
- Role-based access (author-only actions)

---

## Project Structure
```
Blog API/
│
├── app/
│   ├── models/
│   │   ├── __init__.py
│   │   └── models.py
│   ├── routes/
│   │   ├── __init__.py
│   │   ├── auth.py
│   │   ├── blog.py
│   │   └── user.py
│   ├── __init__.py
│   └── config.py
│
├── instance/
├── dbInit.py
├── app.py
├── cmd.sh
├── README.md
└── requirements.txt
```

---

## Getting Started

### Prerequisites
- Python 3.7+

### Installation
1. **Clone the repository:**
   ```bash
   git clone <repo-url>
   cd Blog\ API
   ```
2. **Create a virtual environment (optional but recommended):**
   ```bash
   python3 -m venv venv
   source venv/bin/activate
   ```
3. **Install dependencies:**
   ```bash
   pip install -r requirements.txt
   ```
4. **Initialize the database:**
   ```bash
   python dbInit.py
   ```
5. **Run the application:**
   ```bash
   python app.py
   ```
   The API will be available at `http://localhost:3110/`

---

## API Endpoints

| Method | Endpoint                        | Description                                      | Auth Required |
|--------|---------------------------------|--------------------------------------------------|---------------|
| POST   | `/register`                     | Register a new user                              | No            |
| POST   | `/login`                        | Login and receive JWT token                      | No            |
| GET    | `/user/<userId>/blogs`          | Get all blogs by a specific user                 | Yes           |
| GET    | `/user/<userId>/blogs/<postId>` | Get a specific blog post by a user               | Yes           |
| GET    | `/user/me/blogs`                | Get blogs of the currently logged-in user        | Yes           |
| POST   | `/user/me/blogs`                | Create a new blog post for the current user      | Yes           |
| PUT    | `/user/me/blogs/<postId>`       | Update an existing blog post (author only)       | Yes           |
| DELETE | `/user/me/blogs/<postId>`       | Delete a blog post (author only)                 | Yes           |
| GET    | `/blogs`                        | Get all blog posts from all users                | No            |
| GET    | `/blogs/<postId>`               | Get a specific blog post                         | No            |

---

## Authentication
- JWT tokens are required for protected endpoints. Obtain a token via `/login` and include it in the `Authorization` header as `Bearer <token>`.

---

## Database Schema

### User Table
| Column Name    | Type        | Description                   |
| -------------- |------------|-------------------------------|
| `userId`       | Integer     | Primary key, unique user ID   |
| `userName`     | String(100) | Username, must be unique      |
| `email`        | String(100) | User email, must be unique    |
| `userHash`     | String(128) | Hashed password               |
| `createdAt`    | DateTime    | Timestamp of account creation |

```python
class User(Database.Model):
    __tablename__ = 'users'
    userId = Database.Column(Database.Integer, primary_key=True, autoincrement=True)
    userName = Database.Column(Database.String(100), unique=True, nullable=False)
    userHash= Database.Column(Database.String(128), nullable=False)
    email = Database.Column(Database.String(100), unique=True, nullable=False)
    createdAt = Database.Column(Database.DateTime, default=Database.func.now())
```

### Blog Table
| Column Name | Type         | Description                   |
| ----------- |-------------|-------------------------------|
| `postId`    | Integer      | Primary key, unique post ID   |
| `title`     | String(100)  | Title of the blog post        |
| `content`   | Text         | Main content of the blog post |
| `imageUrl`  | String(1000) | URL to an image for the post  |
| `postedAt`  | DateTime     | Timestamp of post creation    |
| `authorId`  | Integer (FK) | Foreign key to `User.userId`  |

```python
class Blog(Database.Model):
    __tablename__ = 'blogs'
    postId = Database.Column(Database.Integer, primary_key=True, autoincrement=True)
    title = Database.Column(Database.String(100), nullable=False)
    content = Database.Column(Database.Text, nullable=False)
    postedAt = Database.Column(Database.DateTime, default=Database.func.now())
    authorId = Database.Column(Database.Integer, Database.ForeignKey('users.userId'))
    imageUrl = Database.Column(Database.String(1000))

    relation = Database.relationship('User', foreign_keys=[authorId])
```

---

## Example Usage

### Register a User
```bash
curl -X POST http://localhost:3110/register \
     -H 'Content-Type: application/json' \
     -d '{"username": "testuser", "email": "test@example.com", "password": "password123"}'
```

### Login
```bash
curl -X POST http://localhost:3110/login \
     -H 'Content-Type: application/json' \
     -d '{"email": "test@example.com", "password": "password123"}'
```

### Create a Blog Post (Authenticated)
```bash
curl -X POST http://localhost:3110/user/me/blogs \
     -H 'Content-Type: application/json' \
     -H 'Authorization: Bearer <JWT_TOKEN>' \
     -d '{"title": "My First Blog", "content": "Hello World!", "imageUrl": "http://example.com/image.jpg"}'
```

---

## Requirements
See `requirements.txt` for all dependencies:
```
Flask
Flask-SQLAlchemy
Flask-JWT-Extended
Werkzeug
```

---

## License
This project is for educational purposes.
