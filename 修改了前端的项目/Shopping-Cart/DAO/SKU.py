from link_database import *

#添加SKU
def addSKU(name, desc, price, SpuID, qty, city):
    conn = link_mysql()
    cur = conn.cursor()
    cur.execute('INSERT INTO SKU VALUES (NULL, %s, %s, %s, %s, %s, %s);',(name, desc, price, SpuID, qty, city))
    conn.commit()
    cur.close()
    conn.close()
    print('INSERT INTO SKU VALUES (NULL, %s, %s, %s, %s);',(name, desc, price, SpuID))

#addSPU('华为P40Pro 8GB+128GB 冰霜银','华为P40Pro，5G协议，存储量256GB, 银色', 5988, 3)
addSPU('华为P40Pro 8GB+128GB 红色','华为P40Pro，5G协议，存储量128GB, 红色', 5988, 3, 100, '广州')
#addSPU('华为P40Pro 8GB+256GB 零度白','华为P40Pro，5G协议，存储量256GB, 白色', 6488, 3)
#addSPU('华为P40Pro 8GB+128GB 零度白','华为P40Pro，5G协议，存储量128GB, 白色', 5988, 3)
