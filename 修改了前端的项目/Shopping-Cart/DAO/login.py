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

print(shop_login_info_valid('aqing@', 'a.qq.com'))