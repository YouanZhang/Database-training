import mysql.connector

@app.route("/test_register", methods = ['POST'])
def register():
    if request.method == 'POST':

    	#连接数据库
    	with mysql.connector.connect(user='root',password='password',database='db',use_unicode=True) as conn:
    		try:
    			cursor = conn.cursor()

		        #buyer注册
		        if request.form['is_buyer']:

		        	#解析表单数据
		            buyerID = 1
		            name = request.form['name']
		            password = request.form['password']
		            email = request.form['email']
		            address = request.form['address']

		            #按照递增方式分配id
		            cur.execute('select max(buyer_id) as maxbid from buyer;')
		            ans = cur.fetchall();
		            if ans[0][0]!=null:
		            	buyerID = ans[0][0]+1

		            #将注册信息插入数据库
		            cur.execute('INSERT INTO BUYER VALUES (%s,%s,%s,%s,%s);',(buyerID,name,password,email,address))
		            conn.commit()
		            msg = "Registered Successfully"

		        #shop注册
		        else :

		        	#解析表单数据
		            shopID = 1
		            name = request.form['name']
		            description = request.form['description']
		            password = request.form['password']
		            email = request.form['email']
		            
		            #按照递增方式分配id
		            cur.execute('select max(shop_id) as maxsid from shop;')
		            ans = cur.fetchall();
		            if ans[0][0]!=null:
		            	shopID = ans[0][0]+1

		            #将注册信息插入数据库
		            cur.execute('INSERT INTO SHOP VALUES (%s,%s,%s,%s,%s);',(shopID,name,description,password,email))
		            conn.commit()
		            msg = "Registered Successfully"

		    except:
		    	conn.rollback()
		    	msg = "Error occured"
		    finally:
		    	cursor.close()
		    	conn.close()
		return render_template("login.html", error=msg)