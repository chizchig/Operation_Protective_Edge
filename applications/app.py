from flask import Flask, render_template, request, redirect, url_for, session
from flask_sqlalchemy import SQLAlchemy
from dotenv import load_dotenv
import os

# Load environment variables from a .env file
load_dotenv()

app = Flask(__name__)
app.secret_key = os.getenv('SECRET_KEY', 'replace_this_with_a_secure_key')  # Replace with a secure secret key
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///site.db'  # SQLite database file
db = SQLAlchemy(app)

# User model
class User(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(20), unique=True, nullable=False)
    password = db.Column(db.String(60), nullable=False)
    first_name = db.Column(db.String(30), nullable=False)
    last_name = db.Column(db.String(30), nullable=False)
    age = db.Column(db.Integer, nullable=False)
    phone_number = db.Column(db.String(15), nullable=False)
    email = db.Column(db.String(120), unique=True, nullable=False)

# Mock database (replace with a real database in a production environment)
users = []

# Routes

@app.route('/')
def home():
    if 'user' in session:
        return redirect(url_for('dashboard'))
    return render_template('home.html')

@app.route('/signup', methods=['GET', 'POST'])
def signup():
    if request.method == 'POST':
        # Get user input from the form
        username = request.form['username']
        password = request.form['password']
        confirm_password = request.form['confirm_password']
        first_name = request.form['first_name']
        last_name = request.form['last_name']
        age = request.form['age']
        phone_number = request.form['phone_number']
        email = request.form['email']

        # Check if the password and confirm password match
        if password == confirm_password:
            # Store user information in the database (mocked here)
            users.append({
                'username': username,
                'password': password,
                'first_name': first_name,
                'last_name': last_name,
                'age': age,
                'phone_number': phone_number,
                'email': email
            })

            # Redirect to the login page
            return redirect(url_for('home'))
        else:
            return render_template('signup.html', error='Passwords do not match')

    return render_template('signup.html')

@app.route('/login', methods=['POST'])
def login():
    username = request.form['username']
    password = request.form['password']

    # Check if the user is registered
    for user in users:
        if user['username'] == username and user['password'] == password:
            session['user'] = user
            return redirect(url_for('dashboard'))

    return render_template('home.html', error='Invalid credentials')

@app.route('/dashboard')
def dashboard():
    if 'user' not in session:
        return redirect(url_for('home'))

    user = session['user']
    return render_template('dashboard.html', user=user)

@app.route('/logout')
def logout():
    session.pop('user', None)
    return redirect(url_for('home'))

@app.route('/activities')
def activities():
    return render_template('activities.html')

@app.route('/search', methods=['GET'])
def search():
    # Handle the search logic here
    # Retrieve search query from request.args.get('search')
    # Perform search and return results

    return "Search results will be displayed here."

@app.route('/chat')
def chat():
    return render_template('chat.html')

# Run the application

if __name__ == '__main__':
    with app.app_context():
        # Create the database tables before running the application
        db.create_all()
    app.run(debug=True)