from flask import Blueprint, jsonify
from app.models.models import Blog, User
from app import Database

BlogBP = Blueprint('Blog', __name__, url_prefix='/blogs')

@BlogBP.route('/<int:postId>', methods=['GET'])
def getBlog(postId):
    blog = Blog.query.get_or_404(postId)
    return jsonify(
        {
            "postId": blog.postId,
            "title":blog.title,
            "content": blog.content,
            "imageUrl":blog.imageUrl,
            "postedAt":blog.postedAt,
            "author":blog.authorId
        }
    ), 200

@BlogBP.route('', methods=['GET'])
def getBlogs():
    blogs = Blog.query.order_by(Blog.postedAt.desc()).all()
    return jsonify(
        [
            {
                "postId": blog.postId,
                "title":blog.title,
                "content": blog.content,
                "imageUrl":blog.imageUrl,
            } for blog in blogs
        ]
    ), 200