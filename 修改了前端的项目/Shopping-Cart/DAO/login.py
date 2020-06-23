from DAO.link_database import *

def buyer_login_info_valid(email, password):
    conn = link_mysql()
    cur = conn.cursor()
    cur.execute('SELECT * FROM BUYER WHERE `e_mail` = %s AND `password` = %s', (email, password))
    data = cur.fetchall()
    #print('SELECT * FROM BUYER WHERE `e_mail` = %s AND `password` = %s', (email, password))
    vaild = len(data) != 0
    cur.close()
    conn.close()
    return vaild, data

def shop_login_info_valid(email, password):
    conn = link_mysql()
    cur = conn.cursor()
    cur.execute('SELECT * FROM SHOP WHERE `e_mail` = %s AND `password` = %s', (email, password))
    data = cur.fetchall()
    # print('SELECT * FROM BUYER WHERE `e_mail` = %s AND `password` = %s', (email, password))
    vaild = len(data) != 0
    cur.close()
    conn.close()
    return vaild, data

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
    

#print(shop_login_info_valid('yangj', 'a.qq.com'))