from DAO.link_database import *

def addcart(buyer_id, sku_id, qty):
    conn = link_mysql()
    cur = conn.cursor()
    cur.execute('INSERT INTO CART VALUES (%s,%s,%s);', (buyer_id, sku_id, qty))
    conn.commit()
    cur.close()
    conn.close()
    print('Successfully INSERT INTO CART VALUES (%s,%s,%s);', (buyer_id, sku_id, qty))

def findcart(buyer_id, sku_id):
    conn = link_mysql()
    cur = conn.cursor()
    cur.execute('SELECT * FROM CART WHERE `buyer_id` = %s AND `sku_id` = %s;', (buyer_id, sku_id))
    data = cur.fetchall()
    cur.close()
    conn.close()
    return data

def findcart_by_buyerid(buyer_id):
    conn = link_mysql()
    cur = conn.cursor()
    cur.execute('SELECT * FROM CART WHERE `buyer_id` = %s', (buyer_id, ))
    data = cur.fetchall()
    cur.close()
    conn.close()
    return data
#addcart(1, 2, 1)
#print(findcart_by_buyerid(1))
