from DAO.link_database import *

#添加SPU
def addSPU(name, desc, qty):
    conn = link_mysql()
    cur = conn.cursor()
    cur.execute('INSERT INTO SHOP VALUES (NULL, %s, %s, %s);',(name, desc, qty))
    conn.commit()
    cur.close()
    conn.close()
    print('Successfully INSERT INTO SHOP VALUES (NULL, %s, %s, %s);',(name, desc, qty))