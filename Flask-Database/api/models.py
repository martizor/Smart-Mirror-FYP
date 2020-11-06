from . import db

class Data(db.Model):
    id = db.Column(db.Integer, primary_key =True)
    time = db.Column(db.Integer)

class Data_gesture(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    gesture = db.Column(db.String(80))

class Data_Calendar(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    calendar = db.Column(db.String(80))

class Data_Time(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    time_mode = db.Column(db.String(80))

class Data_Stock(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    stock = db.Column(db.String(80))

class Data_Voice(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    voice = db.Column(db.String(80))
