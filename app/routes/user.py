from flask import Blueprint, jsonify, request
from flask_jwt_extended import jwt_required, get_jwt_identity
from app.models.models import Blog, User
from app import Database
from app.routes import blog

UserBP = Blueprint('User', __name__, url_prefix='/user')

@UserBP.route('/<int:userId>/blogs', methods=['GET'])
@jwt_required()
def getUserBlogs(userId):
    user = User.query.filter_by(userId=userId).first()
    if not user:
        return jsonify({'message': 'User not found'}), 404

    blogs = Blog.query.filter_by(authorId=userId).all()

    return jsonify(
        [
            {
                "postId": blog.postId,
                "title":blog.title,
                "content": blog.content,
                "imageUrl":blog.imageUrl,
                "postedAt":blog.postedAt
            } for blog in blogs
        ]
    ), 200

@UserBP.route('/me/blogs', methods=['GET'])
@jwt_required()
def getMyBlogs():
    me = get_jwt_identity()
    blogs = Blog.query.filter_by(authorId=me).all()

    return jsonify(
        [
            {
                "postId": blog.postId,
                "title":blog.title,
                "content": blog.content,
                "imageUrl":blog.imageUrl,
                "postedAt":blog.postedAt
            } for blog in blogs
        ]
    ), 200

@UserBP.route('/me/blogs', methods=['POST'])
@jwt_required()
def addBlog():
    me = get_jwt_identity()
    data = request.get_json()

    title = data.get('title')
    content = data.get('content')
    imageUrl = data.get('imageUrl')

    if not title or not content:
        return jsonify({'message': 'Title and content are required'}), 400

    new = Blog(
        title=title,
        content=content,
        authorId=me,
        imageUrl=imageUrl
    )

    Database.session.add(new)
    Database.session.commit()

    return jsonify({'message': 'Blog added successfully'}), 201

@UserBP.route('/me/blogs/<int:postId>', methods=['DELETE'])
@jwt_required()
def deleteUser(postId):
    me = get_jwt_identity()
    post = Blog.query.get_or_404(postId)
    if post.authorId != me:
        return jsonify({'message': 'You are not the author of this blog'}), 403

    Database.session.delete(post)
    Database.session.commit()
    return jsonify({'message': 'Blog deleted successfully'}), 200

@UserBP.route('/me/blogs/<int:postId>', methods=['PUT'])
@jwt_required()
def updatePost(postId):
    me = get_jwt_identity()
    post = Blog.query.get_or_404(postId)

    if post.authorId != me:
        return jsonify({'message': 'You are not the author of this blog'}), 403

    data = request.get_json()
    post.title = data.get('title', post.title)
    post.content = data.get('content', post.content)
    post.imageUrl = data.get('imageUrl', post.imageUrl)

    Database.session.commit()
    return jsonify({'message': 'Blog updated successfully'}), 200