from flask import Flask;
from flask_sqlalchemy import SQLAlchemy
from flask_restful import Api, Resource, reqparse, abort, fields, marshal_with

app = Flask(__name__) # Creating a Flask app
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///data.db' # Here we are using sqlite database, we can use any other database like mysql, postgresql etc.
db = SQLAlchemy(app) # This will create a database object
api = Api(app)

# This is a model class, which will create a table in the database
class UserModel(db.Model):
    id = db.Column(db.Integer, primary_key=True) # Primary key means this field will be unique for each record(row) 
    username = db.Column(db.String(80), unique=True, nullable=False)
    email = db.Column(db.String(120), unique=True, nullable=False)

    def __repr__(self): # This is a representation method, which will return the string representation of the object
        return f'User(name = {self.username}, email = {self.email})'

@app.route('/')
def home():
    return '<h2>This is Home page of this app</h2>'

# This is a request parser, which will parse the request data
user_args = reqparse.RequestParser()
user_args.add_argument('username', type=str, help='Username is required!', required=True)  
user_args.add_argument('email', type=str, help='Email is required!', required=True)

# This is a response field, which will format the response data in the specified format
userFields = {
    'id': fields.Integer,
    'username': fields.String,
    'email': fields.String
}

# This is a resource class, which will handle the requests
class Users(Resource):
    @marshal_with(userFields) # A decorator which will format the response data in JSON format
    def get(self):
        users = UserModel.query.all()
        return users
    
    @marshal_with(userFields)
    def post(self):
        args = user_args.parse_args()
        user = UserModel(username=args['username'], email=args['email']) # Creating a user object with the request data
        db.session.add(user)
        db.session.commit()
        users = UserModel.query.all() # This will return all the records(rows) from the table
        return users, 201
    
class User(Resource):
    @marshal_with(userFields)
    def get(self, user_id):
        user = UserModel.query.filter_by(id=user_id).first() # This will return the first record(row) with the specified ID
        if not user:
            abort(404, message='User not found with that ID!')
        return user
    
    @marshal_with(userFields)
    def patch(self, user_id):
        args = user_args.parse_args()
        user = UserModel.query.filter_by(id=user_id).first()
        if not user:
            abort(404, message='User not found with that ID!')
        if args['username']:
            user.username = args['username']
        if args['email']:
            user.email = args['email']
        db.session.commit()
        return user
    
    @marshal_with(userFields)
    def delete(self, user_id):
        user = UserModel.query.filter_by(id=user_id).first()
        if not user:
            abort(404, message='User not found with that ID!')
        db.session.delete(user)
        db.session.commit()
        users = UserModel.query.all()
        return users
    
api.add_resource(Users, '/api/users/') # This will add the User resource to the api with the specified URL
api.add_resource(User, '/api/users/<int:user_id>') # This will add the User resource to the api with the specified URL

if __name__ == '__main__':
    app.run(debug=True) # debug=True will automatically reload the server when we make changes in the code, diable it in production

