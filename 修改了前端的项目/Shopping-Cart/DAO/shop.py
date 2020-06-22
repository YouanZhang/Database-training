from DAO.link_database import *

#查询用户
def find_shop_by_id(id):
    conn = link_mysql()
    cur = conn.cursor()
    cur.execute('SELECT * FROM SHOP WHERE `shop_id` = %s', (id, ))
    data = cur.fetchall()
    # print('SELECT * FROM BUYER WHERE `e_mail` = %s AND `password` = %s', (email, password))
    vaild = len(data) != 0
    cur.close()
    conn.close()
    return vaild, data

def find_shop_by_email(email):
    conn = link_mysql()
    cur = conn.cursor()
    cur.execute('SELECT * FROM SHOP WHERE `e_mail` = %s', (email,))
    data = cur.fetchall()
    # print('SELECT * FROM BUYER WHERE `e_mail` = %s AND `password` = %s', (email, password))
    vaild = len(data) != 0
    cur.close()
    conn.close()
    return vaild, data

#print(find_shop_by_email('atyj@qq.com'))
