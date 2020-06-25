from DAO.link_database import *

#添加SKU
def addSKU(name, desc, price, SpuID, qty, city, shop_id):
    conn = link_mysql()
    cur = conn.cursor()
    cur.execute('INSERT INTO SKU VALUES (NULL, %s, %s, %s, %s, %s, %s, %s);',\
                (name, desc, price, SpuID, qty, city, shop_id))
    conn.commit()
    cur.close()
    conn.close()
    print('INSERT INTO SKU VALUES (NULL, %s, %s, %s, %s, %s, %s, %s);',\
                (name, desc, price, SpuID, qty, city, shop_id))
#删除SKU
def remove_SKU(sku_id):
    conn = link_mysql()
    cur = conn.cursor()
    cur.execute('DELETE FROM SKU WHERE `sku_id` = %s;', (sku_id, ))
    conn.commit()
    cur.close()
    conn.close()
    #print('DELETE FROM SKU WHERE `sku_id` = %s;', (sku_id, ))

#修改SKU qty
def edit_SKU_QTY(sku_id, qty):
    conn = link_mysql()
    cur = conn.cursor()
    cur.execute('UPDATE SKU SET `qty` =%s \
        WHERE `sku_id` = %s;', (qty, sku_id))
    # cur.execute('SELECT * FROM CART WHERE `buyer_id` = %s AND `sku_id` = %s;', (buyer_id, sku_id))
    # print(cur.fetchall())
    conn.commit()
    cur.close()
    conn.close()
    print('UPDATE SKU SET `qty` =%s \
        WHERE `sku_id` = %s;', (qty, sku_id))

#修改SKU
def edit_SKU_by_SKUID(sku_id, name, desc, price,  qty):
    conn = link_mysql()
    cur = conn.cursor()
    cur.execute('UPDATE SKU SET `sku_name`=%s, `sku_desc` = %s, `price`=%s, `qty` =%s \
    WHERE `sku_id` = %s;', (name, desc, price, qty, sku_id))
    # cur.execute('SELECT * FROM CART WHERE `buyer_id` = %s AND `sku_id` = %s;', (buyer_id, sku_id))
    # print(cur.fetchall())
    conn.commit()
    cur.close()
    conn.close()
    print('UPDATE SKU SET `sku_name`=%s, `sku_desc` = %s, `price`=%s, `qty` =%s \
    WHERE `sku_id` = %s;', (name, desc, price, qty, sku_id))

#查找SKU
def findSKUbyid(id):
    conn = link_mysql()
    cur = conn.cursor()
    cur.execute('SELECT * FROM SKU WHERE `sku_id` = %s', (id,))
    data = cur.fetchall()
    # print('SELECT * FROM BUYER WHERE `e_mail` = %s AND `password` = %s', (email, password))
    vaild = len(data) != 0
    cur.close()
    conn.close()
    return vaild, data

def findSKUbyname(name):
    conn = link_mysql()
    cur = conn.cursor()
    cur.execute('SELECT * FROM SKU WHERE `sku_name` = %s', (name, ))
    data = cur.fetchall()
    # print('SELECT * FROM BUYER WHERE `e_mail` = %s AND `password` = %s', (email, password))
    vaild = len(data) != 0
    cur.close()
    conn.close()
    return vaild, data

def findSKUbyShopandSPU(shop_id, spu_id):
    conn = link_mysql()
    cur = conn.cursor()
    cur.execute('SELECT * FROM SKU WHERE `shop_id` = %s AND `spu_id` = %s', (shop_id, spu_id))
    data = cur.fetchall()
    # print('SELECT * FROM BUYER WHERE `e_mail` = %s AND `password` = %s', (email, password))
    cur.close()
    conn.close()
    return data

def findSKUbyWord(word):
    conn = link_mysql()
    cur = conn.cursor()
    cur.execute('SELECT * FROM SKU WHERE \
    `sku_name` = %s OR `sku_desc` = %s;', (word, word))
    data = cur.fetchall()
    # print('SELECT * FROM BUYER WHERE `e_mail` = %s AND `password` = %s', (email, password))
    cur.close()
    conn.close()
    return data
#addSKU('华为P40Pro 8GB+128GB 冰霜银','华为P40Pro，5G协议，存储量256GB, 银色', 5988, 3)
#addSKU('华为P40Pro 8GB+128GB 红色','华为P40Pro，5G协议，存储量128GB, 红色', 5988, 3, 100, '广州', 1)
#addSKU('华为P40Pro 8GB+256GB 零度白','华为P40Pro，5G协议，存储量256GB, 白色', 6488, 3)
#addSKU('华为P40Pro 8GB+128GB 零度白','华为P40Pro，5G协议，存储量128GB, 白色', 5988, 3)
#print(findSKUbyShopandSPU(1, 3))
#remove_SKU(3)
#edit_SKU_by_SKUID(1, '小米9', '协议', 3999, 3)
#edit_SKU_QTY(1, 100)
#print(findSKUbyWord('协议'))