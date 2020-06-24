from DAO.link_database import *

def addNewSubOrder(parent_order_id, sku_id, qty, shop_id, money, express_id):
    conn = link_mysql()
    cur = conn.cursor()
    cur.execute('INSERT INTO SUB_ORDER VALUES (%s ,NULL, %s, %s, %s, %s, %s);', \
                (parent_order_id, sku_id, qty, shop_id, money, express_id))
    conn.commit()
    #cur.execute('SELECT * FROM SUB_ORDER WHERE `PARENT_ORDER_ID` = %s \
    #    AND `SKU_ID` = %s AND `QTY` = %s AND `SHOP_ID` = %s;', \
    #            (parent_order_id, sku_id, qty, shop_id))
    cur.execute('SELECT LAST_INSERT_ID();')
    data = cur.fetchall()
    cur.close()
    conn.close()
    print('INSERT INTO SUB_ORDER VALUES (%s ,NULL, %s, %s, %s, %s, %s);', \
                (parent_order_id, sku_id, qty, shop_id, money, express_id))
    #print(data)
    return data[0][0]

def findSubOrderById(suborder_id):
    conn = link_mysql()
    cur = conn.cursor()
    cur.execute('SELECT * FROM SUB_ORDER WHERE `SUB_ORDER_ID` = %s', (suborder_id,))
    data = cur.fetchall()
    cur.close()
    conn.close()
    return data

def findSubOrderByParentId(parent_id):
    conn = link_mysql()
    cur = conn.cursor()
    cur.execute('SELECT * FROM SUB_ORDER WHERE `PARENT_ORDER_ID` = %s', (parent_id, ))
    data = cur.fetchall()
    cur.close()
    conn.close()
    return data

def findSubOrderByShopId(shop_id):
    conn = link_mysql()
    cur = conn.cursor()
    cur.execute('SELECT * FROM SUB_ORDER WHERE `SHOP_ID` = %s', (shop_id, ))
    data = cur.fetchall()
    cur.close()
    conn.close()
    return data

#print(findSubOrderByParentId(1))
