from link_database import *

#添加SPU
def addSPU(name, desc):
    conn = link_mysql()
    cur = conn.cursor()
    cur.execute('INSERT INTO SPU (SPU_ID,SPU_NAME,SPU_DESC) VALUES (NULL, %s, %s);',(name, desc))
    conn.commit()
    cur.close()
    conn.close()
    print('INSERT INTO SPU (SPU_ID,SPU_NAME,SPU_DESC) VALUES (NULL, %s, %s);',(name, desc))

#addSPU('Huawei P40 Pro','华为P40Pro手机，全网通，4G/5G')
#addSPU('Huawei P40','华为P40手机，全网通，4G/5G')