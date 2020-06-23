from DAO.link_database import *

#添加SPU
def addSPU(name, desc):
    conn = link_mysql()
    cur = conn.cursor()
    cur.execute('INSERT INTO SPU (SPU_ID,SPU_NAME,SPU_DESC) VALUES (NULL, %s, %s);',(name, desc))
    conn.commit()
    cur.close()
    conn.close()
    print('INSERT INTO SPU (SPU_ID,SPU_NAME,SPU_DESC) VALUES (NULL, %s, %s);',(name, desc))

def findSPUbyid(id):
    conn = link_mysql()
    cur = conn.cursor()
    cur.execute('SELECT * FROM SPU WHERE `spu_id` = %s', (id,))
    data = cur.fetchall()
    # print('SELECT * FROM BUYER WHERE `e_mail` = %s AND `password` = %s', (email, password))
    vaild = len(data) != 0
    cur.close()
    conn.close()
    return vaild, data

def findSPUbyname(name):
    conn = link_mysql()
    cur = conn.cursor()
    cur.execute('SELECT * FROM SPU WHERE `spu_name` = %s', (name, ))
    data = cur.fetchall()
    # print('SELECT * FROM BUYER WHERE `e_mail` = %s AND `password` = %s', (email, password))
    vaild = len(data) != 0
    cur.close()
    conn.close()
    return vaild, data
#addSPU('Huawei P40 Pro','华为P40Pro手机，全网通，4G/5G')
#addSPU('Huawei P40','华为P40手机，全网通，4G/5G')
#print(findSPUbyid(2))