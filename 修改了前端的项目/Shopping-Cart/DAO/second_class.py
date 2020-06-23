from DAO.link_database import *

def getNameIdFromSecondClass():
    conn = link_mysql()
    cur = conn.cursor()
    cur.execute('SELECT * FROM  WHERE `sku_id` = %s', (id,))
    data = cur.fetchall()
    # print('SELECT * FROM BUYER WHERE `e_mail` = %s AND `password` = %s', (email, password))
    vaild = len(data) != 0
    cur.close()
    conn.close()
    return vaild, data