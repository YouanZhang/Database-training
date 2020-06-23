from flask import *
import sqlite3, hashlib, os
import mysql.connector
from werkzeug.utils import secure_filename
from DAO.register import *
from DAO.login import*
from DAO.SPU import *
from Controller.login_cotrol import *
app = Flask(__name__)
app.secret_key = 'random string'
UPLOAD_FOLDER = 'static/uploads'
ALLOWED_EXTENSIONS = set(['jpeg', 'jpg', 'png', 'gif'])
app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER

def test_getLoginDetails():
    conn = link_mysql()
    cur = conn.cursor()
    if 'email' not in session:
        loggedIn = False
        firstName = ''
        noOfItems = 0
    else:
        if session['is_buyer']=='True':
            loggedIn = True
            cur.execute("SELECT BUYER_ID, Nick_Name FROM buyer WHERE E_MAIL = ?", (session['email'], ))
            userId, firstName = cur.fetchone()
            cur.execute("SELECT count(SKU_ID) FROM cart WHERE BUYER_ID = ?", (userId, ))
            noOfItems = cur.fetchone()[0]
        else:
            loggedIn = True
            cur.execute("SELECT SHOP_ID, SHOP_Name FROM shop WHERE E_MAIL = ?", (session['email'], ))
            userId, firstName = cur.fetchone()
            cur.execute("SELECT WAREHOUSE_ID FROM warehouse WHERE SHOP_ID = ?", (userId, ))
            warehouse_id=cur.fetchall()
            cur.execute("SELECT count(SKU_ID) FROM store WHERE WAREHOUSE_ID = ?", (warehouse_id, ))
            noOfItems = cur.fetchone()[0]
    cur.close()
    conn.close()

    return (loggedIn, firstName, noOfItems)
    

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

#测试使用，作为进入add_spu的入口
@app.route("/test_add_spu")
def test_add_spu():
    if 'email' not in session:
        return redirect(url_for('test_loginForm'))
    else:
        #下面部份需要重新写的，等获取SPU_catgories搞定，就传入我们自己的SPU_catgories
        with sqlite3.connect('database.db') as conn:
            cur = conn.cursor()
            cur.execute("SELECT categoryId, name FROM categories")
            categories = cur.fetchall()
        conn.close()
        return render_template('add_spu.html',categories=categories)

#测试使用，作为add_SPU连接数据库的入口
@app.route("/add_SPU", methods=["GET", "POST"])
def add_SPU():
    if request.method == "POST":
        name = request.form['name']
        description = request.form['description']
        #这里还要添加SPU所属的class，等接口实现了加上
        addSPU(name, description)
        return redirect(url_for('myshop'))
        


#测试使用，作为进入add_sku的入口
@app.route("/test_add_sku")
def test_add_sku():
    return render_template('add_sku.html')



#测试用新数据库登录     hbc-622-20：00     
@app.route("/test_loginForm")
def test_loginForm():
    if 'email' in session:
        return redirect(url_for('root'))
    else:
        return render_template('new_login.html', error='')

#测试用新数据库登录  hbc-622-20：00          
@app.route("/test_login", methods = ['POST', 'GET'])
def test_login():
    if request.method == 'POST':
        email = request.form['email']
        password = request.form['password']
        if request.form['is_buyer']=='True':
            print('进入buyer判断')
            valid,data= buyer_login_info_valid(email,password)
            if valid:
                #session['email'] = email
                print('buyer 有效')
                return redirect(url_for('root'))
            else:
                error = 'Invalid UserId / Password'
                return render_template('new_login.html', error=error)
        else:
            print('进入shop判断')
            valid,data= shop_login_info_valid(email,password)
            if valid:
                print('shop 有效')
                session['email'] = email
                session['is_buyer']='True'
                return redirect(url_for('myshop'))
            else:
                error = 'Invalid UserId / Password'
                print('shop无效')
                return render_template('new_login.html', error=error)


@app.route("/myshop")
def myshop():
    iphone=['7','8','x']
    xiaomi=['6','8','10']
    list1=[['iphone',iphone],['xiaomi',xiaomi]]
    
    return render_template("myshop.html", list1 = list1)


def parse(data):
    ans = []
    i = 0
    while i < len(data):
        curr = []
        for j in range(7):
            if i >= len(data):
                break
            curr.append(data[i])
            i += 1
        ans.append(curr)
    return ans



if __name__ == '__main__':
    app.run(debug=True)




