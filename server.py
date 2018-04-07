#!/usr/bin/env python


import flask
from flask import g, session, url_for
import sqlite3
import string
import serial
import os
import json
import threading


from contextlib import closing

if ( os.getuid() != 0 ):
	print "You must run this server as root to be able to read from `/dev/ttyACM0`!"
	exit()

ser = serial.Serial('/dev/ttyACM0')
distance = 1000

def read_serial():
	global distance
	while ( 1 ):
		
		distance = ser.readline().strip()
		if 'Out' not in distance:
			distance = float(distance)
		else:
			distance = 0


t = threading.Thread(target = read_serial, args = ())
t.daemon = True

t.start()

'''
\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
 Boilerplate Flask and Database set up...
'''

app = flask.Flask(__name__)
DATABASE = 'database.db'
SECRET_KEY = 'this_key_needs_to_be_used_for_session_variables'
UPLOAD_FOLDER = 'static/uploads'
ALLOWED_EXTENSIONS = set(['png', 'jpg', 'jpeg'])


app.config.from_object(__name__)

def init_db():
	with closing(connect_db()) as db:
		with app.open_resource('schema.sql', mode='r') as f:
			db.cursor().executescript(f.read())
		db.commit()

def connect_db():return sqlite3.connect( app.config['DATABASE'] )

@app.before_request
def before_request(): g.db = connect_db()

@app.teardown_request
def teardown_request(exception):
	db = getattr(g, 'db', None)
	if db is not None:
		db.close()

'''
///////////////////////////////////////////////////////////////////////////////////////
'''


@app.route('/about')
def about(): return flask.render_template('about.html')

@app.route('/contact')
def contact(): return flask.render_template('contact.html')

@app.route('/complete_order/<order_id>', methods = ["POST"])
def complete_order( order_id ): 

	cur = g.db.execute('DELETE FROM orders WHERE id = ( ? )', [ 
		order_id
	] )

	g.db.commit()

	return ""


@app.route('/restaurant/<restaurant_id>/', methods = ["GET", "POST"])
def restaurant( restaurant_id ): 

	if ( session.has_key('identifier') ):

		if ( session['identifier'] == 'food_server' ):

				cur = g.db.execute('SELECT seat_number, contents, id FROM orders WHERE restaurant_association = (?)', [ restaurant_id ])	
				response = cur.fetchall()		

				orders = [ { "seat_number": row[0], "contents": row[1], "id": row[2] } for row in response]
				
				return flask.render_template( "orders.html", orders = orders )

		if ( session['identifier'] == 'customer' ):

			if ( flask.request.method == 'GET' ):

				cur = g.db.execute('SELECT name, price, id FROM menu_items WHERE restaurant_association = (?)', [ restaurant_id ])	
				response = cur.fetchall()		

				menu_items = [ { "name": row[0], "price": row[1], "id": row[2] } for row in response]
				
				return flask.render_template( "menu.html", menu_items = menu_items )
			
			else:
				print dict(flask.request.form)
				items = dict(flask.request.form)
				items.pop('seat_number')
				if items == {}:
					flask.flash('You must order at least something!', 'error')
					
					return flask.redirect(flask.url_for('restaurant', restaurant_id = restaurant_id))
				if not flask.request.form['seat_number']:
					flask.flash('You must supply your seat number!', 'error')
					
					return flask.redirect(flask.url_for('restaurant', restaurant_id = restaurant_id))

				seat_number = flask.request.form['seat_number']
				receipt = []
				known_indexes = []
				
				for key in items:
					
					index = key.split('_')[-1]
					if index not in known_indexes:
						known_indexes.append(index)

				total_cost = 0
				for index in known_indexes:
					
					name = flask.request.form['order_' + index]
					quantity = int(flask.request.form['quantity_' + index])
					price = float(flask.request.form['price_' + index])
					final_price = quantity*price

					receipt.append("%d x %s ... $%0.2f" % ( quantity, name, final_price ))
					total_cost += final_price

				receipt.append("")
				receipt.append("TOTAL COST: %0.2f" % total_cost )

				receipt = "\n".join( receipt )


				if ( flask.request.form['seat_number'] == 'A33' ):
					
					# distance = 1000
					# for i in range(5):
					# 	try:
					# 		print "Attempting to Read..."
					# 		distance = ser.readline().strip()
					# 		print "Read:", distance
					# 	except:
					# 		print "This server does not have a functioning light sensor"

					# # If the user is more than 30
					# if distance == 'Out of range':
					# 	print "found out of range"
						# distance = 0
					# print distance
					# distance = float(distance)
					# print distance
					if distance > 30:
						flask.flash('You must be sitting in your seat to order!', 'error')
						return flask.redirect(flask.url_for('restaurant', restaurant_id = restaurant_id))



				cur = g.db.execute('INSERT INTO orders (seat_number, contents, restaurant_association) VALUES ( ?, ?, ? )', [ 
						               flask.request.form['seat_number'], 
						               receipt,
						               restaurant_id,
				] )

				g.db.commit()

				return flask.render_template( 'thankyou.html', receipt = receipt, seat_number = seat_number )
	else:
		return flask.redirect(flask.url_for('/'))	


@app.route('/stadium/<stadium_id>/')
def stadium( stadium_id ): 
	
	if ( session.has_key('identifier') ):
		if ( session['identifier'] == 'customer' ):

			question = "What restaurant would you like to order from?"

		elif ( session['identifier'] == 'food_server' ):
			
			question = "What restaurant are you working for today?"

		cur = g.db.execute('SELECT name, logo, id FROM restaurants WHERE stadium_association = (?)', [ stadium_id ])	
		response = cur.fetchall()		

		restaurants_array = [ { "name": row[0], "logo": row[1], "id": row[2] } for row in response]
		
		return flask.render_template( "restaurants.html", restaurants = restaurants_array, question = question)

	else:

		return flask.redirect(flask.url_for('/'))



@app.route('/stadiums')
def stadiums(): 

	cur = g.db.execute('SELECT name, logo, id FROM stadiums')	
	response = cur.fetchall()	
	
	stadiums_array = [ { "name": row[0], "logo": row[1], "id": row[2] } for row in response]
	
	return flask.render_template( "stadiums.html", stadiums = stadiums_array)


@app.route('/food_server')
def food_server(): 

	session['identifier'] = 'food_server'
	return flask.redirect(flask.url_for("stadiums"))


@app.route('/customer')
def customer(): 

	session['identifier'] = 'customer'
	return flask.redirect(flask.url_for("stadiums"))


@app.route('/')
def index(): 

	if ( session.has_key('identifier') ):
		if ( session['identifier'] == 'customer' ):
			return flask.redirect( flask.url_for('stadiums') )
		else:
			if ( session.has_key('restaurant_id') ):
				return flask.redirect( flask.url_for('restaurant', restaurant_id =  session['restaurant_id'] ) )

	return flask.render_template( "fan_or_restaurant.html" )

if ( __name__ == "__main__" ):

	app.run( debug=True, host='0.0.0.0', threaded=True )
	