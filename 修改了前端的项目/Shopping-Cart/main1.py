from flask import *
import sqlite3, hashlib, os
import mysql.connector
import time
from werkzeug.utils import secure_filename
from DAO.register import *
from DAO.login import*
from DAO.SPU import *
from DAO.SKU import *
from DAO.shop import*
from DAO.buyer import*
from DAO.second_class import *
from DAO.mer_collection import *
from Controller.login_cotrol import *
from Controller.shop_control import *
from Controller.buyer_control import *
from Controller.class_control import *
from Controller.sku_control import *
from Controller.cart_control import *
from Controller.home_control import *
from Controller.order_control import *
from Controller.search_control import *

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
            #execute("SELECT BUYER_ID, Nick_Name FROM buyer WHERE E_MAIL = ?", (session['email'], ))
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
    

@app.route("/", methods=["GET", "POST"])
def root():
    loggedIn = test_getLoginDetails()
#下面需要改，后期弄成自己的商品的入口
    list1=getLeftList()    
    if loggedIn:
        print('test_已经登陆')
        if session['is_buyer']=='True':
            search_key = request.form.get('search_key')
            valid,profileDatas= find_buyer_by_email(session['email'])
            profileData=profileDatas[0]
            buyer_id=profileData[0]
            SPU_Id = request.args.get('SPU_Id')
            if search_key!=None:
                print('search key is :')
                print(search_key)
                data=findSKUbyFullMatch((search_key))
                return render_template('home.html',loggedIn=loggedIn,list2=data,list1=list1,SPU_Id=-1)
            if SPU_Id==None:
                print('SPU_ID为空')
                SPU_Id=-1
                data=getRecommPage(buyer_id)
                #print(getRecommPage(buyer_id))
                return render_template('home.html',loggedIn=loggedIn,list2=data,list1=list1,SPU_Id=SPU_Id)
            else:
                SPU_Id=int(SPU_Id)
                data=getBuyerRightList(SPU_Id)
                return render_template('home.html',loggedIn=loggedIn,list2=data,list1=list1,SPU_Id=SPU_Id)

            
        else:
            #登陆的是商家
            return redirect(url_for('myshop'))
    else:
        search_key = request.form.get('search_key')
        SPU_Id = request.args.get('SPU_Id')
        if search_key!=None:
            print('search key is :')
            print(search_key)
            data=findSKUbyFullMatch((search_key))
            return render_template('home.html',loggedIn=loggedIn,list2=data,list1=list1,SPU_Id=-1)
        if SPU_Id==None:
            SPU_Id=-1
            data=getFirstPageForNotLogin()
            return render_template('home.html',loggedIn=loggedIn,list2=data,list1=list1,SPU_Id=SPU_Id)
        else:
            SPU_Id=int(SPU_Id)
            data=getBuyerRightList(SPU_Id)
            return render_template('home.html',  loggedIn=loggedIn,list2=data,list1=list1,SPU_Id=SPU_Id)


#测试使用，作为进入add_spu的入口
@app.route("/test_add_spu")
def test_add_spu():
    if 'email' not in session:
        return redirect(url_for('test_loginForm'))
    else:

        categories=getNameIdFromSecondClass()
        return render_template('add_spu.html',categories=categories)

#测试使用，作为add_SPU连接数据库的入口
@app.route("/add_SPU", methods=["GET", "POST"])
def add_SPU():
    if request.method == "POST":
        name = request.form['name']
        description = request.form['description']
        class_id=int(request.form['categoryName'])
        addSPU(name, description,class_id)
        return redirect(url_for('myshop',SPU_Id=-1))
        


#测试使用，作为进入add_sku的入口
@app.route("/test_add_sku")
def test_add_sku():
    #以下还需要传入SPU_id
    SPU_Id = request.args.get('SPU_Id')
    return render_template('add_sku.html',SPU_Id=SPU_Id)

#测试使用，作为add_SKU连接数据库的入口
@app.route("/add_SKU", methods=["GET", "POST"])
def add_SKU():
    if request.method == "POST":
        name = request.form['name']
        price = float(request.form['price'])
        price=int(price*100)
        description = request.form['description']
        stock = int(request.form['stock'])
        SPU_Id = request.form['SPU_Id']
        #Uploading image procedure
        image = request.files['image']
        if image and allowed_file(image.filename):
            filename = image.filename
            ext=filename.rsplit('.')[1]
            unix_time = int(time.time())
            filename=str(unix_time)+'.'+ext  # 修改了上传的文件名
            image.save(os.path.join(app.config['UPLOAD_FOLDER'], filename))
        imagename = filename
        print("SPU_id is %s" %SPU_Id)
        city='default'
        #上传SKU至数据库
        addSKUbyemail(name, description, price, SPU_Id, stock, imagename, session['email'])
        #addSKUbyemail(name, desc, price, SpuID, qty, city, email):
        return redirect(url_for('myshop',SPU_Id=SPU_Id))
        

#测试使用，作为remove_SKU连接数据库的入口
@app.route("/remove_SKU/")
def t_remove_SKU():
    SPU_Id = int(request.args.get('SPU_Id'))
    SKU_Id = int(request.args.get('SKU_Id'))
    #调用函数删除SKU(SKU_ID)
    remove_SKU(SKU_Id)
    return redirect(url_for('myshop',SPU_Id=SPU_Id))

#测试使用，作为edit_SKU进入html的入口
@app.route("/test_edit_SKU/")
def test_edit_SKU():
    SPU_Id = request.args.get('SPU_Id')
    SKU_Id = int(request.args.get('SKU_Id'))
    #SKU_Info=["1","《数据库实训》","这个课程实在是太棒了","99999","7","200","159","3"]
    valid,SKU_Infos=findSKUbyid(SKU_Id)
    SKU_Info=SKU_Infos[0]
    #调用函数获取SKU的信息
    if valid:
        return render_template("edit_SKU.html",SKU_Id=SKU_Id, SPU_Id=SPU_Id, SKU_Info=SKU_Info )
    else:
        return redirect(url_for('myshop',SPU_Id=SPU_Id))
#测试使用，作为edit_SKU.html连接数据库的入口
@app.route("/edit_SKU", methods=["GET", "POST"])
def edit_SKU():
    SPU_Id = int(request.form['SPU_Id'])
    SKU_Id = int(request.form['SKU_Id'])
    if request.method=='POST':

        #调用函数来修改SKU信息
        name = request.form['SKU_name']
        price = int(float(request.form['SKU_price'])*100)
        description = request.form['SKU_description']
        stock = int(request.form['SKU_qty'])
        #调用函数修改SKU信息
        #edit_SKU(SKU_Id,name,price,description,stock)
        edit_SKU_by_SKUID(SKU_Id, name, description, price,  stock)
        return redirect(url_for('myshop',SPU_Id=SPU_Id))

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


@app.route("/myshop/")
def myshop():
    if 'email' not in session:
        print('没有登录用户试图进入商家界面')
        return render_template('new_login.html')
    if session['is_buyer']=='True':
        print('买家尝试进入商家界面')
        return render_template('new_login.html')
    print('卖家进入商家界面')

    list1=getLeftList()
    valid=True
    SPU_Id = request.args.get('SPU_Id')
    if SPU_Id==None:
        #print('传入myshop的SPU为空')
        return render_template("myshop.html", list1 = list1,loggedIn=valid,SPU_Id=-1)
    SPU_Id = int(SPU_Id)
    print('传入myshop的SPU不为空')
    #要根据调用函数时输入的SPU_ID，在右侧显示出所有当前SPU_ID且是商家的SKU的SKU_LIST
    SKU_LIST=getRightList(session['email'],SPU_Id)
    # iphone_1=['1','iphone8p;128g;白','这可是非常优秀的手机 , 当然电池不太行','8848',SPU_Id,'30','777']
    # iphone_2=['1','iphone8p;128g;黑','这可是非常优秀的手机,  当然电池不太行','8848',SPU_Id,'30','777']
    # iphone_3=['1','iphone8p;64;黑','这可是非常优秀的手机,  当然电池不太行','8848',SPU_Id,'30','777']
    # list2=[iphone_1,iphone_2,iphone_3]

    #下面也需要修改，传入的数据包括，SPU_list(id,name),sku_list,loggedIn,SPU_ID
    return render_template("myshop.html", list1 = list1,list2=SKU_LIST,loggedIn=valid,SPU_Id=SPU_Id)


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
    return redirect(url_for('editProfile'))
    if 'email' not in session:
        return redirect(url_for('root'))
    loggedIn= test_getLoginDetails()
    is_buyer=session['is_buyer']
    return render_template("profileHome.html", loggedIn=loggedIn,is_buyer=is_buyer)
    
@app.route("/account/profile/edit")
def editProfile():
    if 'email' not in session:
        return redirect(url_for('root'))
    loggedIn= test_getLoginDetails()
    if session['is_buyer']=='True':
       valid,profileDatas= find_buyer_by_email(session['email'])
       profileData=profileDatas[0]
       return render_template("editProfile_buyer.html", profileData=profileData, loggedIn=loggedIn,is_buyer=session['is_buyer'])
    else:
        valid,profileDatas=find_shop_by_email(session['email'])
        profileData=profileDatas[0]  

        return render_template("editProfile_shop.html", profileData=profileData, loggedIn=loggedIn,is_buyer=session['is_buyer'])

#测试，提交修改的信息给数据库      
@app.route("/updateProfile", methods=["GET", "POST"])
def updateProfile():
    if request.method == 'POST':
        if session['is_buyer']=='True':
            buyer_name = request.form['nick_name']
            address = request.form['address']
            change_buyer_name(session['email'],buyer_name)
            change_buyer_address(session['email'],address)
        else:
            shop_name = request.form['SHOP_NAME']
            description = request.form['DESCRIBE_WORD']
            change_shop_name(session['email'],shop_name)
            change_shop_descrip(session['email'],description)
        print('如果添加了函数就修改成功了')
        return redirect(url_for('root'))

#测试，提交修改password的信息给数据库 
@app.route("/account/profile/changePassword", methods=["GET", "POST"])
def changePassword():
    if 'email' not in session:
        return redirect(url_for('test_loginForm'))
    if request.method == "POST":
        oldPassword = request.form['oldpassword']
        #oldPassword = hashlib.md5(oldPassword.encode()).hexdigest()
        newPassword = request.form['newpassword']
        cpassword=request.form['cpassword']
        #newPassword = hashlib.md5(newPassword.encode()).hexdigest()
        print("尝试修改密码")
        not_vaild = len(oldPassword) == 0
        if not_vaild:
            msg="输入不能为空"
            return render_template("changePassword.html", msg=msg)
        not_vaild = len(newPassword) == 0
        if not_vaild:
            msg="输入不能为空"
            return render_template("changePassword.html", msg=msg) 
              
        if (newPassword == cpassword):
            if session['is_buyer']=='True':
                print("buyer尝试修改密码")
                NULL,data=find_buyer_by_email(session['email'])
                password = data[0][2]
                if password==oldPassword:
                    change_buyer_password(session['email'],newPassword)
                    msg="success"
                    return render_template("changePassword.html", msg=msg)
                else:
                    msg="输入的旧密码不正确"
                    return render_template("changePassword.html", msg=msg)
            else:
                print("shop尝试修改密码")
                NULL,data=find_shop_by_email(session['email'])
                password = data[0][3]
                if password==oldPassword:
                    change_shop_password(session['email'],newPassword)
                    msg="success"
                    return render_template("changePassword.html", msg=msg)
                else:
                    msg="输入的旧密码不正确"
                    return render_template("changePassword.html", msg=msg)
        else:
            msg="两次输入密码不相同"
            return render_template("changePassword.html", msg=msg)       
    else:
        return render_template("changePassword.html")

#测试，进入详情页面
@app.route("/show_productDescription")
def show_productDescription():
    if 'email' in session:
        print('已经登录了')

    #此函数会接受SKU_id
    SKU_Id = request.args.get('SKU_Id')
    #SKU_Id=10
    if SKU_Id==None:
        #测试使用的，用于进入详情
        return redirect(url_for('root'))
    #获取当前sku-id的详细信息
    valid, datas=findSKUbyid(SKU_Id)
    if valid:
        data=datas[0]
        loggedIn = test_getLoginDetails()
        return render_template('/productDescription.html',loggedIn=loggedIn,data=data)
    else:
        msg='此商品已失效！'
        return redirect(url_for('root'),msg=msg)

@app.route("/addToCart", methods=["GET", "POST"])
def addToCart():
    if 'email' not in session:
        return redirect(url_for('test_loginForm'))
    if session['is_buyer']!='True':
        return redirect(url_for('myshop'))
    else:
        qty=int(request.form['qty'])
        SKU_Id=request.form['SKU_Id']
        print("输入的购物数量是%s" %(qty))
        print("输入的SKU_Id是%s" %(SKU_Id))
        #还需要再从数据库读取库存确认最新的库存并对比
        valid,profileDatas= find_buyer_by_email(session['email'])
        buyer_id=profileDatas[0][0]
        addcart(buyer_id, SKU_Id, qty)
        return redirect(url_for('show_productDescription',SKU_Id=SKU_Id))


#测试，进入cart.html
@app.route("/cart")
def cart():
    if 'email' not in session:
        return redirect(url_for('test_loginForm'))
    loggedIn = test_getLoginDetails()
    # with sqlite3.connect('database.db') as conn:
    #     cur = conn.cursor()
    #     cur.execute("SELECT userId FROM users WHERE email = ?", (email, ))
    #     userId = cur.fetchone()[0]
    #     cur.execute("SELECT products.productId, products.name, products.price, products.image FROM products, kart WHERE products.productId = kart.productId AND kart.userId = ?", (userId, ))
    #     products = cur.fetchall()
    # totalPrice = 0
    # for row in products:
    #     totalPrice += row[2]
    #return render_template("cart.html", products = products, totalPrice=totalPrice, loggedIn=loggedIn, firstName=firstName, noOfItems=noOfItems)
    NULL,buyer_data=find_buyer_by_email(session['email'])
    Buyer_id=buyer_data[0][0]
    address=buyer_data[0][4]
    cart=cart_detail(Buyer_id)
    total = 0
    for i in cart:
        total += i[1][3] * i[0][2]
    #cart1=["1","10","2"]
    #cart2=["1","10","3"]
    #cart=[cart1,cart2]
    return render_template("cart.html",  loggedIn=loggedIn,cart=cart,total =total,address=address)

#测试，删除cart中的一条SKU
@app.route("/remove_one_cart/")
def remove_one_cart():
    NULL,buyer_data=find_buyer_by_email(session['email'])
    Buyer_Id=buyer_data[0][0]
    SKU_Id = int(request.args.get('SKU_Id'))
    #remove_one_cart(SKU_Id,Buyer_Id)
    removecart(Buyer_Id, SKU_Id)
    print("删除的的SKU_Id是%s" %(SKU_Id))
    return redirect(url_for('cart'))

@app.route("/create_order", methods=["GET", "POST"])
def create_order():


    #createOrderFromCart(buyer_id, status, address, express_id)
    NULL,buyer_data=find_buyer_by_email(session['email'])
    Buyer_id=buyer_data[0][0]
    cart=cart_detail(Buyer_id)
    if len(cart) == 0:
        return redirect(url_for('cart')) 
    address=request.form['address']
    createOrderFromCart(Buyer_id, '0', address, 'default')
    cleanCart(Buyer_id)
    return redirect(url_for('cart'))    

@app.route("/account/orders")
def acount_orders():
    if 'email' not in session:
        return redirect(url_for('test_loginForm'))
    if session['is_buyer']=='True':
        return redirect(url_for('buyer_order'))
    else:
         return redirect(url_for('seller_order'))

@app.route("/buyer_order")
def buyer_order():
    NULL,buyer_data=find_buyer_by_email(session['email'])
    Buyer_id=buyer_data[0][0]
    data=getBuyerOrder(Buyer_id)
    if len(data)==0:
        return render_template("buyer_order.html",loggedIn=True)
    i=data[0]
    #print(i[1][0])
    return render_template("buyer_order.html",data=data,loggedIn=True)

@app.route("/seller_order")
def seller_order():
    valid,profileDatas=find_shop_by_email(session['email'])
    shop_id=profileDatas[0] [0] 
    data= findSubOrderByShopIdWithNameandCity(shop_id)
    #print(data[0])
    #print('hhhhhh')
    return render_template("seller_order.html",data=data,loggedIn=True)


def allowed_file(filename):
    return '.' in filename and \
            filename.rsplit('.', 1)[1] in ALLOWED_EXTENSIONS



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

@app.route('/findSKU_name_by_id/<string:id>')
def findSKU_name_by_id(id):
    print("tttttttttttttt")
    print(id)
    id=int(id)
    NULL,datas=findSKUbyid(id)
    data=datas[0]
    return data[1]

@app.route('/findSKU_pic_by_id/<string:id>')
def findSKU_pic_by_id(id):
    id= int(id)
    NULL,datas=findSKUbyid(id)
    data=datas[0]
    return data[6]  

@app.route('/wishlist')
def wishlist():
    if 'email' not in session:
        return redirect(url_for('test_loginForm'))
    if session['is_buyer']!='True':
        return redirect(url_for("root"))

    valid,profileDatas= find_buyer_by_email(session['email'])
    buyer_id=profileDatas[0][0]
    data=findMerCollectionByBuyerID(buyer_id)

    print(data)
    return render_template("wishlist.html",data=data,loggedIn=True)


@app.route('/addToCollection', methods=["GET", "POST"])
def addToCollection():
    if 'email' not in session:
        return redirect(url_for('test_loginForm'))
    if session['is_buyer']!='True':
        #print("进了addCollection，但是是个seller")
        return redirect(url_for('myshop'))
    SKU_Id= int(request.args.get('SKU_Id'))
    print("要加入collection的SKU_Id是%s" %(SKU_Id))
    #还需要再从数据库读取库存确认最新的库存并对比
    valid,profileDatas= find_buyer_by_email(session['email'])
    buyer_id=profileDatas[0][0]
    addMerColletion(buyer_id, SKU_Id)
    return redirect(url_for('show_productDescription',SKU_Id=SKU_Id))

@app.route('/remove_one_collection')
def remove_one_collection():
    if 'email' not in session:
        return redirect(url_for('test_loginForm'))
    if session['is_buyer']!='True':
        #print("进了addCollection，但是是个seller")
        return redirect(url_for('myshop'))
    NULL,buyer_data=find_buyer_by_email(session['email'])
    Buyer_Id=buyer_data[0][0]
    SKU_Id = int(request.args.get('SKU_Id'))
    #remove_one_cart(SKU_Id,Buyer_Id)
    #removecart(Buyer_Id, SKU_Id)
    dropMerCollection(Buyer_Id, SKU_Id)
    print("删除的的collection's SKU_Id是%s" %(SKU_Id))
    return redirect(url_for('wishlist'))    

if __name__ == '__main__':
    app.run(debug=True)




