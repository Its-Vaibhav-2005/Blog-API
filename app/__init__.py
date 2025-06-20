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

        # init db and jwt
        Database.init_app(self.app)
        JWT.init_app(self.app)

        # some imports
        from app.routes.auth import AuthBP
        from app.routes.user import UserBP
        from app.routes.blog import BlogBP

        # Register BluePrints
        self.app.register_blueprint(AuthBP)
        self.app.register_blueprint(UserBP)
        self.app.register_blueprint(BlogBP)

        return self.app