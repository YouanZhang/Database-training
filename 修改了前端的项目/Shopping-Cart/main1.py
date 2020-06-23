from flask import *
import sqlite3, hashlib, os
import mysql.connector
from werkzeug.utils import secure_filename
from DAO.register import *
from DAO.login import*
from Controller.login_control import *
app = Flask(__name__)
app.secret_key = 'random string'
UPLOAD_FOLDER = 'static/uploads'
ALLOWED_EXTENSIONS = set(['jpeg', 'jpg', 'png', 'gif'])
app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER


@app.route("/")
def root():
    loggedIn, firstName, noOfItems = test_getLoginDetails()
#下面需要改，后期弄成自己的商品的入口    
    with sqlite3.connect('database.db') as conn:
        cur = conn.cursor()
        cur.execute('SELECT productId, name, price, description, image, stock FROM products')
        itemData = cur.fetchall()
        cur.execute('SELECT categoryId, name FROM categories')
        categoryData = cur.fetchall()
    itemData = parse(itemData)   
    return render_template('home.html', itemData=itemData, loggedIn=loggedIn, firstName=firstName, noOfItems=noOfItems, categoryData=categoryData)


