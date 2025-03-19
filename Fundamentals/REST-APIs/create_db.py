from api import db, app

with app.app_context():
    db.create_all() # This will create all the tables in the database
    print('Database created successfully!')