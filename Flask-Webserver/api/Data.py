from flask import Blueprint, jsonify, request
from . import db 
from .models import Data
from .models import Data_gesture
from .models import Data_Calendar
from .models import Data_Time
from .models import Data_Stock
from .models import Data_Voice

main = Blueprint('main',__name__)

## Time Commute Post and Get Request: 
@main.route('/time_commute', methods = ['POST'])
def add_commute():
    commute_data = request.get_json()
    new_commute = Data(name = commute_data['name'],time = commute_data['time'])
    db.session.add(new_commute)
    db.session.commit()
    
    return 'Done', 201 


@main.route('/time_commute_list')
def commute_func(): 
    commute_list = Data.query.all()
    commutes = [] 
    for commute in commute_list:
        commutes.append({'name': commute.name,'time': commute.time})
    return jsonify({'commutes':commutes})

@main.route('/delete_time_commute', methods = ['POST'])
def delete_commute():
    data_name = request.get_json() 
    name = data_name['name']
    db.session.query(Data).filter(Data.name == name).delete()
    db.session.commit()
    
    return 'Done', 201 

## Hand Gesture Post and Get Request: 
@main.route('/gesture_post', methods = ['POST'])
def add_gesture():
    
    db.session.query(Data_gesture).delete()
    gesture_data = request.get_json()
    new_gesture =Data_gesture(gesture = gesture_data['gesture'])
    db.session.add(new_gesture)
    db.session.commit()
    
    return 'Done', 201 


@main.route('/gesture_list')
def gesture_func(): 

    gesture_list = Data_gesture.query.all()
    gestures = [] 
    for gesture in gesture_list:
        gestures.append({'gesture': gesture.gesture})
    
    return jsonify({'Gestures':gestures})

@main.route('/delete_gesture', methods = ['POST'])
def delete_gesture():
    db.session.query(Data_gesture).delete()
    db.session.commit()
    
    return 'Done', 201 

## Calendar ID  Post and Get Request: 
@main.route('/Calendar_id_post', methods = ['POST'])
def add_calendar_id():
    
    db.session.query(Data_Calendar).delete()
    Calendar_id_data = request.get_json()
    new_calendar_id =Data_Calendar(calendar = Calendar_id_data['calendar'])
    db.session.add(new_calendar_id)
    db.session.commit()
    
    return 'Done', 201 


@main.route('/Calendar_id_list')
def calendar_func(): 

    calendar_id_list = Data_Calendar.query.all()
    calendars = [] 
    for calendar in calendar_id_list:
        calendars.append({'calendar': calendar.calendar})
    
    return jsonify({'Calendar_id':calendars})

# 24 Hour Time Post and Get Request: 
@main.route('/24_hour_post', methods = ['POST'])
def time_mode_check():
    
    db.session.query(Data_Time).delete()
    time_data = request.get_json()
    new_time =Data_Time(time_mode = time_data['time_mode'])
    db.session.add(new_time)
    db.session.commit()
    return 'Done', 201 


@main.route('/24_hour_list')
def time_mode_list(): 

    time_list = Data_Time.query.all()
    times = [] 
    for time in time_list:
        times.append({'time_mode': time.time_mode})
    return jsonify({'24 Hour Time':times})

## Stock Post and Get Request: 

@main.route('/stock_post', methods = ['POST'])
def add_stock():
    stock_data = request.get_json()
    new_stock = Data_Stock(stock_name = stock_data['stock_name'], stock_price = stock_data['stock_price'], stock_percent = stock_data['stock_percent'])
    db.session.add(new_stock)
    db.session.commit()
    
    return 'Done', 201 

@main.route('/stock_list')
def stock_list(): 
    stock_list = Data_Stock.query.all()
    stocks = [] 
    for stock in stock_list:
        stocks.append({'stock_name':stock.stock_name,'stock_price': stock.stock_price, 'stock_percent': stock.stock_percent})
    return jsonify({'Stock':stocks})

@main.route('/delete_stock', methods = ['POST'])
def delete_stock():
    data_stock = request.get_json() 
    name_stock = data_stock['stock_name']
    db.session.query(Data_Stock).filter(Data_Stock.stock_name == name_stock).delete()
    db.session.commit()

    return 'Done', 201 

## Voice Post and Get Request: 
@main.route('/Voice_post', methods = ['POST'])
def Voice_add():
    
    db.session.query(Data_Voice).delete()
    voice_data = request.get_json()
    new_voice =Data_Voice(voice = voice_data['voice'])
    db.session.add(new_voice)
    db.session.commit()
    
    return 'Done', 201 


@main.route('/Voice_list')
def Voice_func(): 

    voice_list = Data_Voice.query.all()
    voices = [] 
    for voice in voice_list:
        voices.append({'voice': voice.voice})
    
    return jsonify({'Voice':voices})
