## Project Structure

```markdown
Blog API/
│
├── app/
│   ├── models/
│   │   ├── __init__.py
│   │   └── models.py
│   │
│   ├── routes/
│   │   ├── __init__.py
│   │   ├── auth.py
│   │   ├── blog.py
│   │   └── user.py
│   │
│   ├── __init__.py
│   └── config.py
│
├── instance/
│
├── dbInit.py
├── app.py
├── cmd.sh
├── README.md
└── requirements.txt
```
---

## Routes

| Method | Endpoint                        | Description                                      | Auth Required |
|--------|---------------------------------|--------------------------------------------------|---------------|
| POST   | `/register`                     | Register a new user                              | ❌ No          |
| POST   | `/login`                        | Login and receive JWT token                      | ❌ No          |
| GET    | `/user/<userId>/blogs`          | Get all blogs by a specific user                 | ✅ Yes         |
| GET    | `/user/<userId>/blogs/<postId>` | Get a specific blog post by a user               | ✅ Yes         |
| GET    | `/user/me/blogs`                | Get blogs of the currently logged-in user        | ✅ Yes         |
| POST   | `/blogs`                        | Create a new blog post                           | ✅ Yes         |
| PUT    | `/blogs/<postId>`               | Update an existing blog post                     | ✅ Yes (Author only) |
| DELETE | `/blogs/<postId>`               | Delete a blog post                               | ✅ Yes (Author only) |
| GET    | `/blogs`                        | Get all blog posts from all users                | ❌ No          |
| GET    | `/blogs/<postId>`               | Get a specific blog post                         | ❌ No          |
| GET    | `/blogs/search?query=...`       | Search blog posts by title/content               | ❌ No          |


---
## Database schema

### User Table
| Column Name    | Type        | Description                   |
| -------------- |-------------| ----------------------------- |
| `userId`       | Integer     | Primary key, unique user ID   |
| `userName`     | String(100) | Username, must be unique      |
| `email`        | String(100) | User email, must be unique    |
| `passwordHash` | String(128) | Hashed password               |
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
| ----------- |--------------| ----------------------------- |
| `postId`    | Integer      | Primary key, unique post ID   |
| `title`     | String(100)  | Title of the blog post        |
| `content`   | Text         | Main content of the blog post |
| `imageUrl`  | String(1000) | URL to an image for the post  |
| `postedAt` | DateTime     | Timestamp of post creation    |
| `authorId`  | Integer (FK) | Foreign key to `User.userId`  |
```python
class Blog(Database.Model):
    __tablename__ = 'blogs'
    postId = Database.Column(Database.Integer, primary_key=True, autoincrement=True)
    title = Database.Column(Database.String(100), nullable=False)
    content = Database.Column(Database.Text, nullable=False)
    postedAt = Database.Column(Database.DateTime, default=Database.func.now())
    authorId = Database.Column(Database.Integer, Database.ForeignKey('Users.userId'))
    imageUrl = Database.Column(Database.String(1000))
    
    relation = Database.relationship('User', foreign_keys=[authorId])
```
---
## Code Snippet

### `app/__init__.py`
```python
from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from flask_jwt_extended import JWTManager
from app import config

# Inits
Database = SQLAlchemy()
JWT = JWTManager()

# API Class
class CreateApp:
    def __init__(self):
        self.app = Flask(__name__)

    def createApp(self):
        self.app.config.from_object(config.Config)

        Database.init_app(self.app)
        JWT.init_app(self.app)

        # some imports
        from app.routes.auth import AuthBP
        from app.routes.user import UserBP
        from app.routes.blog import BlogBP

        # Register BluePrints
        self.app.register_blueprint(AuthBP)
        self.app.register_blueprint(UserBP)

        return self.app
```

## Getting Started

### Prerequisites
- Python 3.8+
- pip (Python package manager)

### Installation
1. Clone the repository:
   ```bash
   git clone https://github.com/Its-Vaibhav-2005/Blog-API.git
   cd Blog-API
   ```
2. Install dependencies:
   ```bash
   pip install -r requirements.txt
   ```

### Configuration
- The main configuration is in `app/config.py`:
  - `SECRET_KEY`: Flask secret key
  - `SQLALCHEMY_DATABASE_URI`: Database URI (default: SQLite `blog.db`)
  - `JWT_SECRET_KEY`: Secret for JWT tokens

### Database Initialization
To initialize the database, run:
```bash
python dbInit.py
```
This will create the necessary tables in `instance/blog.db`.

### Running the Application
To start the server:
```bash
python app.py
```
The API will be available at `http://localhost:3110/` by default.

---

## Authentication
- JWT-based authentication is used.
- Register via `/register` and login via `/login` to receive a JWT token.
- For protected routes, include the token in the `Authorization` header as:
  ```
  Authorization: Bearer <your_token>
  ```

---

## Main Files Overview
- `app.py`: Entry point to run the Flask app.
- `dbInit.py`: Script to initialize the database.
- `app/`: Main application package.
  - `__init__.py`: App factory, initializes Flask, SQLAlchemy, JWT, and registers blueprints.
  - `config.py`: Configuration settings.
  - `models/`: Contains SQLAlchemy models for User and Blog.
  - `routes/`: Contains route blueprints for authentication, user, and blog operations.
- `instance/blog.db`: SQLite database file (created after initialization).

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
  -H 'Authorization: Bearer <your_token>' \
  -d '{"title": "My First Blog", "content": "Hello World!", "imageUrl": "http://example.com/image.jpg"}'
```

---

## Notes
- Make sure to initialize the database before running the app.
- All protected routes require a valid JWT token in the `Authorization` header.
- The API follows RESTful conventions and returns JSON responses.