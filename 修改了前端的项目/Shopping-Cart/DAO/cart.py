from DAO.link_database import *

def addcart(buyer_id, sku_id, qty):
    conn = link_mysql()
    cur = conn.cursor()
    data = findcart(buyer_id, sku_id)
    if len(data) == 0:
        cur.execute('INSERT INTO CART VALUES (%s,%s,%s);', (buyer_id, sku_id, qty))
        print('Successfully INSERT INTO CART VALUES (%s,%s,%s);', (buyer_id, sku_id, qty))
    else:
        new_qty = qty + data[0][2]
        modify_cart(buyer_id, sku_id, new_qty)
    conn.commit()
    cur.close()
    conn.close()

def findcart(buyer_id, sku_id):
    conn = link_mysql()
    cur = conn.cursor()
    cur.execute('SELECT * FROM CART WHERE `buyer_id` = %s AND `sku_id` = %s;', (buyer_id, sku_id))
    data = cur.fetchall()
    cur.close()
    conn.close()
    return data

def removecart(buyer_id, sku_id):
    conn = link_mysql()
    cur = conn.cursor()
    cur.execute('DELETE FROM CART WHERE `buyer_id`= %s AND `sku_id` = %s;', (buyer_id, sku_id))
    conn.commit()
    cur.close()
    conn.close()
    print('DELETE FROM CART WHERE `buyer_id`= %s AND `sku_id` = %s;', (buyer_id, sku_id))

def cleanCart(buyer_id):
    conn = link_mysql()
    cur = conn.cursor()
    cur.execute('DELETE FROM CART WHERE `buyer_id`= %s;', (buyer_id, ))
    conn.commit()
    cur.close()
    conn.close()
    print('DELETE FROM CART WHERE `buyer_id`= %s;', (buyer_id, ))

def findcart_by_buyerid(buyer_id):
    conn = link_mysql()
    cur = conn.cursor()
    cur.execute('SELECT * FROM CART WHERE `buyer_id` = %s', (buyer_id, ))
    data = cur.fetchall()
    cur.close()
    conn.close()
    return data

def modify_cart(buyer_id, sku_id, qty):
    conn = link_mysql()
    cur = conn.cursor()
    cur.execute('UPDATE CART SET `QTY`=%s WHERE `buyer_id` = %s AND `sku_id` = %s;', (qty, buyer_id, sku_id))
    #cur.execute('SELECT * FROM CART WHERE `buyer_id` = %s AND `sku_id` = %s;', (buyer_id, sku_id))
    #print(cur.fetchall())
    conn.commit()
    cur.close()
    conn.close()
    print('UPDATE CART SET `QTY`=%S WHERE `buyer_id` = %s `sku_id` = %s', (qty, buyer_id, sku_id))
#addcart(1, 5, 1)
#addcart(1, 10, 1)
#modify_cart(1, 2, 20)
#print(findcart_by_buyerid(1))
#removecart(1, 6)
#cleanCart(1)