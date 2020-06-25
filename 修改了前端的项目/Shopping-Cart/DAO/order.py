from DAO.link_database import *
#import datetime

def addNewOrder(buyer_id, dt, status, address):
    conn = link_mysql()
    cur = conn.cursor()
    cur.execute('INSERT INTO PARENT_ORDER VALUES (NULL, %s, %s, %s, %s);', \
                (buyer_id, dt, status, address))
    conn.commit()
    #cur.execute('SELECT * FROM PARENT_ORDER WHERE `BUYTIME` = %s', (dt, ))
    cur.execute('SELECT LAST_INSERT_ID();')
    data = cur.fetchall()
    cur.close()
    conn.close()
    print('INSERT INTO PARENT_ORDER VALUES (NULL, %s, %s, %s, %s);',\
                (buyer_id, dt, status, address))
    #print(data)
    return data[0][0]

def findOrderByBuyerId(buyer_id):
    conn = link_mysql()
    cur = conn.cursor()
    cur.execute('SELECT * FROM PARENT_ORDER WHERE `buyer_id` = %s', (buyer_id,))
    data = cur.fetchall()
    cur.close()
    conn.close()
    return data

def findOrderByOrderId(order_id):
    conn = link_mysql()
    cur = conn.cursor()
    cur.execute('SELECT * FROM PARENT_ORDER WHERE `PARENT_ORDER_ID` = %s', (order_id, ))
    data = cur.fetchall()
    cur.close()
    conn.close()
    return data

def findOrderByDatetime(dt):
    conn = link_mysql()
    cur = conn.cursor()
    cur.execute('SELECT * FROM PARENT_ORDER WHERE `buytime` = %s', (dt, ))
    data = cur.fetchall()
    cur.close()
    conn.close()
    return data
#dt=datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")
#print(addNewOrder(2, dt, 'create', 'canton'))
#print(findOrderByDatetime('2020-06-24 14:52:16'))