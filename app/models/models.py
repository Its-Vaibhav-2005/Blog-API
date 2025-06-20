from app import Database

class User(Database.Model):
    __tablename__ = 'users'
    userId = Database.Column(Database.Integer, primary_key=True, autoincrement=True)
    userName = Database.Column(Database.String(100), unique=True, nullable=False)
    userHash= Database.Column(Database.String(128), nullable=False)
    email = Database.Column(Database.String(100), unique=True, nullable=False)
    createdAt = Database.Column(Database.DateTime, default=Database.func.now())



class Blog(Database.Model):
    __tablename__ = 'blogs'
    postId = Database.Column(Database.Integer, primary_key=True, autoincrement=True)
    title = Database.Column(Database.String(100), nullable=False)
    content = Database.Column(Database.Text, nullable=False)
    postedAt = Database.Column(Database.DateTime, default=Database.func.now())
    authorId = Database.Column(Database.Integer, Database.ForeignKey('users.userId'))
    imageUrl = Database.Column(Database.String(1000))

    relation = Database.relationship('User', foreign_keys=[authorId])