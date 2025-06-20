from flask import Blueprint, jsonify, request
from flask_jwt_extended import create_access_token, jwt_required, get_jwt_identity
from werkzeug.security import generate_password_hash, check_password_hash
from app.models.models import User
from datetime import timedelta
from app import Database

AuthBP = Blueprint('Auth', __name__)

@AuthBP.route('/register', methods=['POST'])
def registerUser():
    data = request.get_json()
    if not data:
        return jsonify({'message': 'No input data provided'}), 400

    if User.query.filter_by(email=data.get("email")).first() or User.query.filter_by(userName=data.get("username")).first():
        return jsonify({'message': 'User already exists'}), 400

    newUser = User(
        userName=data.get("username"),
        email=data.get("email"),
        userHash=generate_password_hash(data.get("password"), method='pbkdf2:sha256'))
    Database.session.add(newUser)
    Database.session.commit()
    return jsonify({'message': 'User created successfully'}), 201

@AuthBP.route('/login', methods=['POST'])
def loginUser():
    data = request.get_json()
    if not data:
        return jsonify({'message': 'No input data provided'}), 400

    user = User.query.filter_by(email=data.get("email")).first()

    if user and check_password_hash(user.userHash, data.get("password")):
        accessToken = create_access_token(identity=str(user.userId), expires_delta=timedelta(hours=3))
        return jsonify({'accessToken': accessToken}), 200
    else:
        return jsonify({'message': 'Invalid credentials'}), 401

