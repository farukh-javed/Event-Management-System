from flask import Flask, render_template, jsonify, request, redirect, url_for, session
import pymysql

app = Flask(__name__)
app.secret_key = 'my_secret_key'
    
@app.route('/login', methods=['GET', 'POST'])
def login():
    error_message = None

    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']

        if username == 'ucp' and password == 'ucp123':
            # Set a session variable to indicate the user is logged in
            session['logged_in'] = True
            return redirect(url_for('index'))
        else:
            error_message = 'Invalid credentials. Please try again.'

    return render_template('login.html', error_message=error_message)

@app.route('/logout', methods=['GET'])
def logout():
    session.clear()
    return redirect(url_for('login'))

app.config['MYSQL_HOST'] = '127.0.0.1'
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = '12345'
app.config['MYSQL_DB'] = 'EMS'

def create_db_connection():
    try:
        connection = pymysql.connect(
            host=app.config['MYSQL_HOST'],
            user=app.config['MYSQL_USER'],
            password=app.config['MYSQL_PASSWORD'],
            db=app.config['MYSQL_DB']
        )
        return connection
    except pymysql.Error as e:
        print(f"Error connecting to MySQL: {e}")
        raise e

@app.route('/')
def index():
    if 'logged_in' not in session or not session['logged_in']:
        return redirect(url_for('login'))

    try:
        with create_db_connection() as connection:
            with connection.cursor(pymysql.cursors.DictCursor) as cursor:
                cursor.execute("SELECT * FROM Events")
                events = cursor.fetchall()
        return render_template('index.html', events=events)
    except pymysql.Error as e:
        print(f"Error fetching events: {e}")
        return render_template('error.html', error_message=str(e))

@app.route('/event_details/<int:event_id>')
def event_details(event_id):
    try:
        with create_db_connection() as connection:
            with connection.cursor(pymysql.cursors.DictCursor) as cursor:
                cursor.execute(f"SELECT * FROM Events where EventID = {event_id}")
                event = cursor.fetchone()

                if event:
                    venues = fetch_venue_details(connection)
                    organizer = fetch_organizer_details(connection)
                    attendees = fetch_attendees(connection)
                    registrations = fetch_registrations(connection)
                    categories = fetch_event_categories(connection)
                    sessions = fetch_sessions(connection)
                    speakers = fetch_speakers(connection)
                    feedbacks = fetch_feedbacks(connection)
                    tasks = fetch_tasks(connection)
                    payments = fetch_payments(connection)
                    transportation = fetch_transportation(connection)
                    accommodations = fetch_accommodations(connection)
                    exhibitors = fetch_exhibitors(connection)
                    social_media_promotions = fetch_social_media_promotions(connection)
                    security = fetch_security(connection)
                    catering = fetch_catering(connection)

                    return render_template('event_details.html', events=event, venues=venues, organizer=organizer,
                                           attendees=attendees, registrations=registrations,
                                           categories=categories, sessions=sessions,
                                           speakers=speakers, feedbacks=feedbacks,
                                           tasks=tasks, payments=payments,
                                           transportation=transportation,
                                           accommodations=accommodations,
                                           exhibitors=exhibitors,
                                           social_media_promotions=social_media_promotions,
                                           security=security, catering=catering)
                else:
                    return render_template('event_details.html', event={})
    except pymysql.Error as e:
        print(f"Error fetching event details: {e}")
        return render_template('error.html', error_message=str(e))

def fetch_venue_details(connection):
    with connection.cursor(pymysql.cursors.DictCursor) as cursor:
        cursor.execute("SELECT * FROM Venues limit 1")
        return cursor.fetchone()
    
def fetch_organizer_details(connection):
    with connection.cursor(pymysql.cursors.DictCursor) as cursor:
        cursor.execute("SELECT * FROM Organizers limit 1")
        return cursor.fetchone()

def fetch_attendees(connection):
    with connection.cursor(pymysql.cursors.DictCursor) as cursor:
        cursor.execute("SELECT * FROM Attendees")
        return cursor.fetchall()

def fetch_registrations(connection):
    with connection.cursor(pymysql.cursors.DictCursor) as cursor:
        cursor.execute("SELECT * FROM Registrations")
        return cursor.fetchall()

def fetch_event_categories(connection):
    with connection.cursor(pymysql.cursors.DictCursor) as cursor:
        cursor.execute("SELECT * FROM EventCategories")
        return cursor.fetchall()

def fetch_sessions(connection):
    with connection.cursor(pymysql.cursors.DictCursor) as cursor:
        cursor.execute("SELECT * FROM Sessions")
        return cursor.fetchall()

def fetch_speakers(connection):
    with connection.cursor(pymysql.cursors.DictCursor) as cursor:
        cursor.execute("SELECT * FROM Speakers")
        return cursor.fetchall()

def fetch_feedbacks(connection):
    with connection.cursor(pymysql.cursors.DictCursor) as cursor:
        cursor.execute("SELECT * FROM Feedback")
        return cursor.fetchall()

def fetch_tasks(connection):
    with connection.cursor(pymysql.cursors.DictCursor) as cursor:
        cursor.execute("SELECT * FROM Tasks")
        return cursor.fetchall()

def fetch_payments(connection):
    with connection.cursor(pymysql.cursors.DictCursor) as cursor:
        cursor.execute("SELECT * FROM Payments")
        return cursor.fetchall()

def fetch_transportation(connection):
    with connection.cursor(pymysql.cursors.DictCursor) as cursor:
        cursor.execute("SELECT * FROM Transportation")
        return cursor.fetchall()

def fetch_accommodations(connection):
    with connection.cursor(pymysql.cursors.DictCursor) as cursor:
        cursor.execute("SELECT * FROM Accommodations")
        return cursor.fetchall()

def fetch_exhibitors(connection):
    with connection.cursor(pymysql.cursors.DictCursor) as cursor:
        cursor.execute("SELECT * FROM Exhibitors")
        return cursor.fetchall()

def fetch_social_media_promotions(connection):
    with connection.cursor(pymysql.cursors.DictCursor) as cursor:
        cursor.execute("SELECT * FROM SocialMediaPromotion")
        return cursor.fetchall()

def fetch_security(connection):
    with connection.cursor(pymysql.cursors.DictCursor) as cursor:
        cursor.execute("SELECT * FROM Security")
        return cursor.fetchall()

def fetch_catering(connection):
    with connection.cursor(pymysql.cursors.DictCursor) as cursor:
        cursor.execute("SELECT * FROM Catering")
        return cursor.fetchall()

@app.route('/event_details/<int:event_id>/json')
def event_details_json(event_id):
    try:
        with create_db_connection() as connection:
            with connection.cursor(pymysql.cursors.DictCursor) as cursor:
                cursor.execute("SELECT * FROM Events limit 1")
                event = cursor.fetchone()

                if event:
                    venues = fetch_venue_details(connection)
                    organizer = fetch_organizer_details(connection)
                    attendees = fetch_attendees(connection)
                    registrations = fetch_registrations(connection)
                    categories = fetch_event_categories(connection)
                    sessions = fetch_sessions(connection)
                    speakers = fetch_speakers(connection)
                    feedbacks = fetch_feedbacks(connection)
                    tasks = fetch_tasks(connection)
                    payments = fetch_payments(connection)
                    transportation = fetch_transportation(connection)
                    accommodations = fetch_accommodations(connection)
                    exhibitors = fetch_exhibitors(connection)
                    social_media_promotions = fetch_social_media_promotions(connection)
                    security = fetch_security(connection)
                    catering = fetch_catering(connection)

                    event_dict = {
                        'EventDetails': event,
                        'VenueDetails':venues,
                        'OrganizerDetails': organizer,
                        'Attendees': attendees,
                        'Registrations': registrations,
                        'EventCategories': categories,
                        'Sessions': sessions,
                        'Speakers': speakers,
                        'Feedbacks': feedbacks,
                        'Tasks': tasks,
                        'Payments': payments,
                        'Transportation': transportation,
                        'Accommodations': accommodations,
                        'Exhibitors': exhibitors,
                        'SocialMediaPromotions': social_media_promotions,
                        'Security': security,
                        'Catering': catering,
                    }
                    return jsonify(event_dict)
                else:
                    return jsonify({})
    except pymysql.Error as e:
        print(f"Error fetching event details: {e}")
        return jsonify({'error': str(e)})

@app.errorhandler(Exception)
def handle_exception(e):
    print(f"Unexpected error: {e}")
    return render_template('error.html', error_message=str(e))

if __name__ == '__main__':
    app.run(debug=True)