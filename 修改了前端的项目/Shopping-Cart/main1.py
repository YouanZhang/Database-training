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
            #cur.execute("SELECT BUYER_ID, Nick_Name FROM buyer WHERE E_MAIL = ?", (session['email'], ))
            #userId, firstName = cur.fetchone()
        else:
            loggedIn = True
            #cur.execute("SELECT SHOP_ID, SHOP_Name FROM shop WHERE E_MAIL = ?", (session['email'], ))
            #userId, firstName = cur.fetchone()

    cur.close()
    conn.close()
    if loggedIn==True:
        print('已经登陆了')
    else:
        print('登陆了')
    return (loggedIn)
    

@app.route("/")
def root():
    loggedIn = test_getLoginDetails()
#下面需要改，后期弄成自己的商品的入口    
    if loggedIn:
        if session['is_buyer']=='True':
            return render_template('home.html',loggedIn=loggedIn)
        else:
            return redirect(url_for('myshop'))
    else:
        return render_template('home.html',loggedIn=loggedIn)

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

#测试使用，作为add_SKU连接数据库的入口
@app.route("/add_SKU", methods=["GET", "POST"])
def add_SKU():
    if request.method == "POST":
        name = request.form['name']
        description = request.form['description']
        #这里还要添加SPU所属的class，等接口实现了加上
        addSPU(name, description)
        return redirect(url_for('myshop'))
        



#测试使用，作为进入register页面入口
@app.route("/registerationForm")
def registrationForm():
    return render_template("register.html")

#测试使用，作为register连接数据库的入口
@app.route("/test_register", methods = ['POST'])
def register():
    if request.method == 'POST':
        if request.form['is_buyer']=='True':
            name = request.form['name']
            password = request.form['password']
            email = request.form['email']
            address = request.form['address']
            register_buyer(name, password, email, address)
            return render_template('new_login.html', error='')
        else:
            name = request.form['name']
            password = request.form['password']
            email = request.form['email']
            address = request.form['address']
            register_shop(name, name, password,email)
            return render_template('new_login.html', error='')

#测试用新数据库登录     hbc-622-20：00     
@app.route("/test_loginForm")
def test_loginForm():
    if 'email' in session:
        if session['is_buyer']=='True':
            return redirect(url_for('root'))
        else:
            return redirect(url_for('myshop'))
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
                session.pop('email', None)
                session.pop('is_buyer',None)
                #用户部分还没有实现，优先搞定商家部份
                session['email'] = email
                session['is_buyer']='True'
                print('buyer 有效')
                return redirect(url_for('root'))
            else:
                error = 'Invalid UserId / Password'
                return render_template('new_login.html', error=error)
        else:
            print('进入shop判断')
            valid,data= shop_login_info_valid(email,password)
            if valid:
                session.pop('email', None)
                session.pop('is_buyer',None)
                print('shop 有效')
                session['email'] = email
                session['is_buyer']='False'
                #return render_template('myshop.html',loggedIn=valid)
                return redirect(url_for('myshop'))
            else:
                error = 'Invalid UserId / Password'
                print('shop无效')
                return render_template('new_login.html')

@app.route("/logout")
def logout():
    session.pop('email', None)
    session.pop('is_buyer',None)
    return redirect(url_for('test_loginForm'))


@app.route("/myshop")
def myshop():
    if 'email' not in session:
        print('没有登录用户试图进入商家界面')
        return render_template('new_login.html')
    if session['is_buyer']=='True':
        print('买家尝试进入商家界面')
        return render_template('new_login.html')
    print('卖家进入商家界面')
    #下面是临时的数据，到时候需要改写，并把信息传入给page。
    #需要SPU_list,SKU_list
    iphone=['7','8','x']
    xiaomi=['6','8','10']
    list1=[['iphone',iphone],['xiaomi',xiaomi]]
    valid=True
    return render_template("myshop.html", list1 = list1,loggedIn=valid)










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




