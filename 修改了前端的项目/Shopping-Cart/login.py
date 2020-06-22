from link_database import *

def buyer_login_info_valid(email, password):
    conn = link_mysql()
    cur = conn.cursor()
    cur.execute('SELECT * FROM BUYER WHERE `e_mail` = %s AND `password` = %s', (email, password))
    data = cur.fetchall()
    #print('SELECT * FROM BUYER WHERE `e_mail` = %s AND `password` = %s', (email, password))
    print(data)

def shop_login_info_valid(email, password):

buyer_login_info_valid('a.qq.com', '123456')