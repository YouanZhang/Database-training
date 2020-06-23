from flask import *
import sqlite3, hashlib, os
import mysql.connector
from werkzeug.utils import secure_filename
from DAO.register import *
from DAO.login import*
from DAO.SPU import *
from DAO.shop import*
from DAO.buyer import*
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
        with sqlite3.connect('database.db') as conn:
            cur = conn.cursor()
            cur.execute('SELECT productId, name, price, description, image, stock FROM products')
            itemData = cur.fetchall()
            cur.execute('SELECT categoryId, name FROM categories')
            categoryData = cur.fetchall()
        itemData = parse(itemData)   
        return render_template('home.html', itemData=itemData, loggedIn=loggedIn, categoryData=categoryData)


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


#################以下一个函数临时的，到时候整个要重写
@app.route("/displayCategory")
def displayCategory():
        loggedIn, firstName, noOfItems = getLoginDetails()
        categoryId = request.args.get("categoryId")
        with sqlite3.connect('database.db') as conn:
            cur = conn.cursor()
            cur.execute("SELECT products.productId, products.name, products.price, products.image, categories.name FROM products, categories WHERE products.categoryId = categories.categoryId AND categories.categoryId = ?", (categoryId, ))
            data = cur.fetchall()
        conn.close()
        categoryName = data[0][4]
        data = parse(data)
        return render_template('displayCategory.html', data=data, loggedIn=loggedIn, firstName=firstName, noOfItems=noOfItems, categoryName=categoryName)
@app.route("/productDescription")
def productDescription():
    loggedIn = test_getLoginDetails()
    productId = request.args.get('productId')
    with sqlite3.connect('database.db') as conn:
        cur = conn.cursor()
        cur.execute('SELECT productId, name, price, description, image, stock FROM products WHERE productId = ?', (productId, ))
        productData = cur.fetchone()
    conn.close()
    return render_template("productDescription.html", data=productData, loggedIn = loggedIn)



#账户信息
@app.route("/account/profile")
def profileHome():
    if 'email' not in session:
        return redirect(url_for('root'))
    loggedIn= test_getLoginDetails()
    return render_template("profileHome.html", loggedIn=loggedIn)
    
@app.route("/account/profile/edit")
def editProfile():
    if 'email' not in session:
        return redirect(url_for('root'))
    loggedIn= test_getLoginDetails()
    if session['is_buyer']=='True':
       valid,profileData= find_buyer_by_email(session['email'])
       return render_template("editProfile_buyer.html", profileData=profileData, loggedIn=loggedIn,is_buyer=session['is_buyer'])
    else:
        valid,profileData=find_shop_by_email(session['email'])

        return render_template("editProfile_shop.html", profileData=profileData, loggedIn=loggedIn,is_buyer=session['is_buyer'])

#测试，提交修改的信息给数据库      
@app.route("/updateProfile", methods=["GET", "POST"])
def updateProfile():
    if request.method == 'POST':
        if session['is_buyer']=='True':
            buyer_name = request.form['nick_name']
            address = request.form['address']
            #change_buyer_name(session['email'],buyer_name)
            #change_buyer_address(session['email'],address)
        else:
            shop_name = request.form['SHOP_NAME']
            description = request.form['DESCRIBE_WORD']
            #change_shop_name(session['email'],shop_name)
            #change_shop_descrip(session['email'],description)
        print('如果添加了函数就修改成功了')
        return redirect(url_for('root'))
#测试，提交修改password的信息给数据库 
@app.route("/account/profile/changePassword", methods=["GET", "POST"])
def changePassword():
    if 'email' not in session:
        return redirect(url_for('test_loginForm'))
    if request.method == "POST":
        oldPassword = request.form['oldpassword']
        oldPassword = hashlib.md5(oldPassword.encode()).hexdigest()
        newPassword = request.form['newpassword']
        newPassword = hashlib.md5(newPassword.encode()).hexdigest()
        with sqlite3.connect('database.db') as conn:
            cur = conn.cursor()
            cur.execute("SELECT userId, password FROM users WHERE email = ?", (session['email'], ))
            userId, password = cur.fetchone()
            if (password == oldPassword):
                try:
                    cur.execute("UPDATE users SET password = ? WHERE userId = ?", (newPassword, userId))
                    conn.commit()
                    msg="Changed successfully"
                except:
                    conn.rollback()
                    msg = "Failed"
                return render_template("changePassword.html", msg=msg)
            else:
                msg = "Wrong password"
        conn.close()
        return render_template("changePassword.html", msg=msg)
    else:
        return render_template("changePassword.html")











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




